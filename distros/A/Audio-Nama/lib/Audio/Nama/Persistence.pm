# ---------- Persistent State Support -------------


package Audio::Nama;
use File::Copy;
use Modern::Perl; no warnings 'uninitialized';

sub save_state {
	logsub("&save_state");
	my $filename = shift;
	if ($filename)
	{

		# remove extension if present
		
		$filename =~ s/\.json//;

		# append filename if warranted
		
		$filename = 
				$filename =~ m{/} 	
									? $filename	# as-is if input contains slashes
									: join_path(project_dir(),$filename) 
	}
	my $path = $filename || $file->state_store();
	$project->{nama_version} = $VERSION;

	# store playback position, if possible
	$project->{playback_position} = ecasound_iam("getpos") if $this_engine->valid_setup();

	# some stuff get saved independently of our state file
	
	logpkg(__FILE__,__LINE__,'debug', "saving palette");
	$ui->save_palette;

	# do nothing more if only Main and Mixdown
	
	#user_tracks_present() or throw("No user tracks, skipping..."), return;
	
	logpkg(__FILE__,__LINE__,'debug',"Saving state as ", $path);
	save_system_state($path);
	save_global_effect_chains();

	save_midish();

	# store alsa settings

	if ( $config->{opts}->{a} ) {
		my $filename = $filename;
		$filename =~ s/\.yml$//;
		pager("storing ALSA settings\n");
		pager(qx(alsactl -f $filename.alsa store))
	}
}
sub initialize_marshalling_arrays {
	@tracks_data = (); # zero based, iterate over these to restore
	@bus_data = (); # 
	@marks_data = ();
	@fade_data = ();
	@inserts_data = ();
	@effects_data = ();
	@edit_data = ();
	@project_effect_chain_data = ();
	@global_effect_chain_data = ();
	$text->{command_history} = {};

}

sub save_system_state {

	my $path = shift;
	my $output_format = shift;

	sync_effect_parameters(); # in case a controller has made a change
	# we sync read-only parameters, too, but I think that is
	# harmless

	initialize_marshalling_arrays();
	
	# prepare tracks for storage
	
	$this_track_name = $this_track->name if $this_track;

	logpkg(__FILE__,__LINE__,'debug', "copying tracks data");

	map { push @tracks_data, $_->as_hash } all_tracks();

	# print "found ", scalar @tracks_data, "tracks\n";

	# delete obsolete fields
	map { my $t = $_;
				map{ delete $t->{$_} } 
					qw(ch_r ch_m source_select send_select jack_source jack_send);
	} @tracks_data;

	logpkg(__FILE__,__LINE__,'debug', "copying bus data");

	@bus_data = map{ $_->as_hash } sort { $a->name cmp $b->name} Audio::Nama::Bus::all();


	my $by_n = sub { $a->{n} <=> $b->{n} };

	# prepare inserts data for storage
	
	logpkg(__FILE__,__LINE__,'debug', "copying inserts data");
	
	@inserts_data = sort $by_n map{ $_->as_hash } values %Audio::Nama::Insert::by_index;

	# prepare marks data for storage (new Mark objects)

	logpkg(__FILE__,__LINE__,'debug', "copying marks data");

	@marks_data = sort {$a->{time} <=> $b->{time} } map{ $_->as_hash } Audio::Nama::Mark::all();
	@effects_data = sort { $a->{id} cmp $b->{id} } map{ $_->as_hash } values %Audio::Nama::Effect::by_id;
	
	@fade_data = sort $by_n map{ $_->as_hash } values %Audio::Nama::Fade::by_index;

	@edit_data = sort $by_n map{ $_->as_hash } values %Audio::Nama::Edit::by_index;

	@project_effect_chain_data = sort $by_n map { $_->as_hash } 
		Audio::Nama::EffectChain::find(project => 1);

	# save history -- 50 entries, maximum

	my @history;
	@history = $text->{term}->GetHistory if $text->{term};
	my %seen;
	$text->{command_history} = [];
	map { push @{$text->{command_history}}, $_ 
			unless $seen{$_}; $seen{$_}++ } @history;
	my $max = scalar @{$text->{command_history}};
	$max = 50 if $max > 50;
	@{$text->{command_history}} = @{$text->{command_history}}[-$max..-1];
	logpkg(__FILE__,__LINE__,'debug', "serializing");

	my @formats = $output_format || $config->serialize_formats;

	map{ 	my $format = $_ ;
			serialize(
				file => $path,
				format => $format,
				vars => \@tracked_vars,
				class => 'Audio::Nama',
				);

	} @formats;

	serialize(
		file => $file->untracked_state_store,
		format => 'json',
		vars => \@persistent_vars,
		class => 'Audio::Nama',
	);	

	"$path.json";
}
{
my %is_legal_suffix = ( 
		json => 'json', 
		yml => 'yaml', 
		pl 	 => 'perl',
		bin  => 'storable',
		yaml => 'yaml', # we allow formats as well
		perl => 'perl',
		storable => 'storable',
);
sub get_newest {
	
	# choose the newest
	#
	my ($path, $format) = @_;
	
	# simply return the file
	# if filename matches exactly, 
	# and we know the format
	
	return($path, $format) if -f $path and $is_legal_suffix{$format};

	my ($dir, $name) = $path =~ m!^(.*?)([^/]+)$!; 
	
	# otherwise we glob, sort and filter directory entries
	
	my @sorted = 
		sort{ $a->[1] <=> $b->[1] } 
		grep{ $is_legal_suffix{$_->[2]} }
		map 
		{ 
			my ($suffix) = m/^$path(?:\.(\w+))?$/;
			[$_, -M $_, $suffix] 
		} 
		glob("$path*");
	logpkg(__FILE__,__LINE__,'debug', sub{json_out \@sorted});
	($sorted[0]->[0], $sorted[0]->[2]);
}
}

{ my %decode = 
	(
		json => \&json_in,
		yaml => sub 
		{ 
			my $yaml = shift;

			# remove empty key hash lines to satisfy YAML::Tiny
			$yaml = join $/, grep{ ! /^\s*:/ } split $/, $yaml;

			$yaml = quote_yaml_scalars( $yaml );

			yaml_in($yaml);
		},
		perl => sub {my $perl_source = shift; eval $perl_source},
		storable => sub { my $bin = shift; thaw( $bin) },
	);
	
	# allow dispatch by either file format or suffix 
	@decode{qw(yml pl bin)} = @decode{qw(yaml perl storable)};

sub decode {

	my ($source, $suffix) = @_;
	$decode{$suffix} 
		or die qq(key $suffix: expecting one of).join q(,),keys %decode;
	$decode{$suffix}->($source);
}
}

sub restore_state_from_file {
	logsub("&restore_state_from_file");
	my $filename = shift;
	$filename =~ s/\.json$//;
	$filename = join_path(project_dir(), $filename) 
		if $filename and not $filename =~ m(/);
	$filename ||= $file->state_store();

	my ($ref, $path, $source, $suffix); 

	# get state file, newest if more than one
	# with same name, differing extensions
	# i.e. State.json and State.yml
	initialize_marshalling_arrays();

	# restore from default filenames	
	
	( $path, $suffix ) = get_newest($file->untracked_state_store);
	if ($path)
	{
		$source = read_file($path);

		$ref = decode($source, $suffix);
		assign(
				data	=> $ref,	
				vars   	=> \@persistent_vars,
				class 	=> 'Audio::Nama');
		assign_singletons( { data => $ref });
	}
	
	( $path, $suffix ) = get_newest($filename);
	if ($path)
	{
		$source = read_file($path);
		$ref = decode($source, $suffix);

		assign(
					data => $ref,
					vars   => \@tracked_vars,
					class => 'Audio::Nama');
		

		# perform assignments for singleton
		# hash entries (such as $fx->{ applied});
		# that that assign() misses
		
		assign_singletons({ data => $ref });

	}
	
	restore_global_effect_chains();

	####### Backward Compatibility ########

	if ( $project->{nama_version}  < 1.214 )  { }

	# restore effects, no change to track objects needed
	
	map
	{ my %args = %$_;
		my $class = delete $args{class};
		my $FX = $class->new(%args, restore => 1);
	} @effects_data;
	
	# restore user buses
		
	Audio::Nama::Bus::initialize();	
	map{ my $class = $_->{class}; $class->new( %$_ ) } @bus_data;
	create_system_buses();

	# temporary turn on mastering mode to enable
	# recreating mastering tracksk

	#my $current_master_mode = $mode->{mastering};
	#$mode->{mastering} = 1;

	# convert field "latency" to "latency_op"
	map{ $_->{latency_op} = delete $_->{latency} if $_->{latency} } @tracks_data;

	# restore tracks
	map{ 
		my %args = %$_; 
		my $class = $args{class} || "Audio::Nama::Track";
		my $track = $class->new( %args, restore => 1 );
	} @tracks_data;


	# restore inserts
	
	Audio::Nama::Insert::initialize();
	
	map{ 
		bless $_, $_->{class}; # bless directly, bypassing constructor
		$Audio::Nama::Insert::by_index{$_->{n}} = $_;
	} @inserts_data;

	# Restore GUI for user tracks
	map{ 
		my $n = $_->{n};

		# create gui
		$ui->track_gui($n) unless $n <= 2;

	} @tracks_data;

	$this_track = $tn{$this_track_name}, set_current_bus() if $this_track_name;
	
	#print "\n---\n", $main->dump;  
	#print "\n---\n", map{$_->dump} Audio::Nama::audio_tracks();# exit; 
	$ui->manifest;
	logpkg(__FILE__,__LINE__,'debug', sub{ join " ", map{ ref $_, $/ } all_tracks() });


	# restore Alsa mixer settings
	if ( $config->{opts}->{a} ) {
		my $filename = $filename; 
		$filename =~ s/\.yml$//;
		pager("restoring ALSA settings\n");
		pager(qx(alsactl -f $filename.alsa restore));
	}

	# text mode marks 

 	map
    {
		my %h = %$_;
		my $mark = Audio::Nama::Mark->new( %h ) ;
    } 
    grep { (ref $_) =~ /HASH/ } @marks_data;

	$ui->restore_time_marks();
	$ui->paint_mute_buttons;

	# track fades
	
	map{ 
		my %h = %$_; 
		my $fade = Audio::Nama::Fade->new( %h ) ;
	} @fade_data;

	# edits 
	
	map{ 
		my %h = %$_; 
		my $edit = Audio::Nama::Edit->new( %h ) ;
	} @edit_data;

	# restore command history
	
	$text->{term}->SetHistory(@{$text->{command_history}})
		if (ref $text->{command_history}) =~ /ARRAY/;

;
	# restore effect chains and profiles
	
	%Audio::Nama::EffectChain::by_index = ();
	#say "Project Effect Chain Data\n", json_out( \@project_effect_chain_data);
 	map { my $fx_chain = Audio::Nama::EffectChain->new(%$_) } 
		(@project_effect_chain_data, @global_effect_chain_data);

	my $fname = $file->midi_store;
	midish_cmd(qq<load "$fname">);
	
} 
sub convert_rw {
	my $h = shift;
	$h->{rw} = MON, return if $h->{rw} eq 'REC' and ($h->{rec_defeat} or $h->{is_mix_track});
	$h->{rw} = PLAY, return if $h->{rw} eq 'MON';
}
sub is_nonempty_hash {
	my $ref = shift;
	return if (ref $ref) !~ /HASH/;
	return (keys %$ref);
}
	 

sub save_global_effect_chains {

	@global_effect_chain_data  = map{ $_->as_hash } Audio::Nama::EffectChain::find(global => 1);

	# always save global effect chain data because it contains
	# incrementing counter

	map{ 	my $format = $_ ;
			serialize(
				file => $file->global_effect_chains,
				format => $format,
				vars => \@global_effect_chain_vars, 
				class => 'Audio::Nama',
			);
	} $config->serialize_formats;

}
sub restore_global_effect_chains {

	logsub("&restore_global_effect_chains");
		my $path =  $file->global_effect_chains;
		my ($resolved, $format) = get_newest($path);  
		throw("$resolved: file not found"), return unless $resolved;
		my $source = read_file($resolved);
		throw("$resolved: empty file"), return unless $source;
		logpkg(__FILE__,__LINE__,'debug', "format: $format, source: \n",$source);
		my $ref = decode($source, $format);
		assign(
				data => $ref,
				vars   => \@global_effect_chain_vars, 
				class => 'Audio::Nama');
		assign_singletons({ data => $ref });
}
1;

__END__