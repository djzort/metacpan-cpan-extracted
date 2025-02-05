use Test::More;
use Lingua::EN::Inflexion;

ok verb(q{psyches})->is_singular  => q{is_singular: 'psyches'};
ok verb(q{wears})->is_singular  => q{is_singular: 'wears'};
ok verb(q{withdraws})->is_singular  => q{is_singular: 'withdraws'};
ok verb(q{shrinks})->is_singular  => q{is_singular: 'shrinks'};
ok verb(q{inlays})->is_singular  => q{is_singular: 'inlays'};
ok verb(q{speaks})->is_singular  => q{is_singular: 'speaks'};
ok verb(q{hews})->is_singular  => q{is_singular: 'hews'};
ok verb(q{daren't})->is_singular  => q{is_singular: 'daren't'};
ok verb(q{forbids})->is_singular  => q{is_singular: 'forbids'};
ok verb(q{thrusts})->is_singular  => q{is_singular: 'thrusts'};
ok verb(q{grinds})->is_singular  => q{is_singular: 'grinds'};
ok verb(q{avalanches})->is_singular  => q{is_singular: 'avalanches'};
ok verb(q{lays})->is_singular  => q{is_singular: 'lays'};
ok verb(q{beats})->is_singular  => q{is_singular: 'beats'};
ok verb(q{doesn't})->is_singular  => q{is_singular: 'doesn't'};
ok verb(q{shakes})->is_singular  => q{is_singular: 'shakes'};
ok verb(q{dives})->is_singular  => q{is_singular: 'dives'};
ok verb(q{seems})->is_singular  => q{is_singular: 'seems'};
ok verb(q{tears})->is_singular  => q{is_singular: 'tears'};
ok verb(q{sunburns})->is_singular  => q{is_singular: 'sunburns'};
ok verb(q{reaches})->is_singular  => q{is_singular: 'reaches'};
ok verb(q{rids})->is_singular  => q{is_singular: 'rids'};
ok verb(q{withholds})->is_singular  => q{is_singular: 'withholds'};
ok verb(q{loses})->is_singular  => q{is_singular: 'loses'};
ok verb(q{sheds})->is_singular  => q{is_singular: 'sheds'};
ok verb(q{irises})->is_singular  => q{is_singular: 'irises'};
ok verb(q{shan't})->is_singular  => q{is_singular: 'shan't'};
ok verb(q{brings})->is_singular  => q{is_singular: 'brings'};
ok verb(q{n't})->is_singular  => q{is_singular: 'n't'};
ok verb(q{menus})->is_singular  => q{is_singular: 'menus'};
ok verb(q{awakes})->is_singular  => q{is_singular: 'awakes'};
ok verb(q{walks})->is_singular  => q{is_singular: 'walks'};
ok verb(q{quizzes})->is_singular  => q{is_singular: 'quizzes'};
ok verb(q{rings})->is_singular  => q{is_singular: 'rings'};
ok verb(q{hits})->is_singular  => q{is_singular: 'hits'};
ok verb(q{drives})->is_singular  => q{is_singular: 'drives'};
ok verb(q{claps})->is_singular  => q{is_singular: 'claps'};
ok verb(q{blows})->is_singular  => q{is_singular: 'blows'};
ok verb(q{will})->is_singular  => q{is_singular: 'will'};
ok verb(q{foresees})->is_singular  => q{is_singular: 'foresees'};
ok verb(q{leans})->is_singular  => q{is_singular: 'leans'};
ok verb(q{costs})->is_singular  => q{is_singular: 'costs'};
ok verb(q{looks})->is_singular  => q{is_singular: 'looks'};
ok verb(q{slays})->is_singular  => q{is_singular: 'slays'};
ok verb(q{sneaks})->is_singular  => q{is_singular: 'sneaks'};
ok verb(q{can})->is_singular  => q{is_singular: 'can'};
ok verb(q{gets})->is_singular  => q{is_singular: 'gets'};
ok verb(q{mistakes})->is_singular  => q{is_singular: 'mistakes'};
ok verb(q{sings})->is_singular  => q{is_singular: 'sings'};
ok verb(q{leaps})->is_singular  => q{is_singular: 'leaps'};
ok verb(q{stops})->is_singular  => q{is_singular: 'stops'};
ok verb(q{bites})->is_singular  => q{is_singular: 'bites'};
ok verb(q{mayn't})->is_singular  => q{is_singular: 'mayn't'};
ok verb(q{drinks})->is_singular  => q{is_singular: 'drinks'};
ok verb(q{leaves})->is_singular  => q{is_singular: 'leaves'};
ok verb(q{interlays})->is_singular  => q{is_singular: 'interlays'};
ok verb(q{would})->is_singular  => q{is_singular: 'would'};
ok verb(q{begins})->is_singular  => q{is_singular: 'begins'};
ok verb(q{wants})->is_singular  => q{is_singular: 'wants'};
ok verb(q{rises})->is_singular  => q{is_singular: 'rises'};
ok verb(q{might})->is_singular  => q{is_singular: 'might'};
ok verb(q{remembers})->is_singular  => q{is_singular: 'remembers'};
ok verb(q{begets})->is_singular  => q{is_singular: 'begets'};
ok verb(q{bets})->is_singular  => q{is_singular: 'bets'};
ok verb(q{kills})->is_singular  => q{is_singular: 'kills'};
ok verb(q{knows})->is_singular  => q{is_singular: 'knows'};
ok verb(q{comes})->is_singular  => q{is_singular: 'comes'};
ok verb(q{helps})->is_singular  => q{is_singular: 'helps'};
ok verb(q{shits})->is_singular  => q{is_singular: 'shits'};
ok verb(q{shaves})->is_singular  => q{is_singular: 'shaves'};
ok verb(q{skis})->is_singular  => q{is_singular: 'skis'};
ok verb(q{leads})->is_singular  => q{is_singular: 'leads'};
ok verb(q{may})->is_singular  => q{is_singular: 'may'};
ok verb(q{swings})->is_singular  => q{is_singular: 'swings'};
ok verb(q{stings})->is_singular  => q{is_singular: 'stings'};
ok verb(q{s})->is_singular  => q{is_singular: 's'};
ok verb(q{creches})->is_singular  => q{is_singular: 'creches'};
ok verb(q{learns})->is_singular  => q{is_singular: 'learns'};
ok verb(q{changes})->is_singular  => q{is_singular: 'changes'};
ok verb(q{strides})->is_singular  => q{is_singular: 'strides'};
ok verb(q{smells})->is_singular  => q{is_singular: 'smells'};
ok verb(q{can't})->is_singular  => q{is_singular: 'can't'};
ok verb(q{haven't})->is_singular  => q{is_singular: 'haven't'};
ok verb(q{creeps})->is_singular  => q{is_singular: 'creeps'};
ok verb(q{upsets})->is_singular  => q{is_singular: 'upsets'};
ok verb(q{aches})->is_singular  => q{is_singular: 'aches'};
ok verb(q{chooses})->is_singular  => q{is_singular: 'chooses'};
ok verb(q{drags})->is_singular  => q{is_singular: 'drags'};
ok verb(q{dies})->is_singular  => q{is_singular: 'dies'};
ok verb(q{spits})->is_singular  => q{is_singular: 'spits'};
ok verb(q{proves})->is_singular  => q{is_singular: 'proves'};
ok verb(q{flies})->is_singular  => q{is_singular: 'flies'};
ok verb(q{binds})->is_singular  => q{is_singular: 'binds'};
ok verb(q{seeks})->is_singular  => q{is_singular: 'seeks'};
ok verb(q{overhears})->is_singular  => q{is_singular: 'overhears'};
ok verb(q{sits})->is_singular  => q{is_singular: 'sits'};
ok verb(q{forgives})->is_singular  => q{is_singular: 'forgives'};
ok verb(q{means})->is_singular  => q{is_singular: 'means'};
ok verb(q{caches})->is_singular  => q{is_singular: 'caches'};
ok verb(q{expects})->is_singular  => q{is_singular: 'expects'};
ok verb(q{loves})->is_singular  => q{is_singular: 'loves'};
ok verb(q{sows})->is_singular  => q{is_singular: 'sows'};
ok verb(q{flees})->is_singular  => q{is_singular: 'flees'};
ok verb(q{understands})->is_singular  => q{is_singular: 'understands'};
ok verb(q{asks})->is_singular  => q{is_singular: 'asks'};
ok verb(q{dreams})->is_singular  => q{is_singular: 'dreams'};
ok verb(q{thrives})->is_singular  => q{is_singular: 'thrives'};
ok verb(q{sinks})->is_singular  => q{is_singular: 'sinks'};
ok verb(q{hasn't})->is_singular  => q{is_singular: 'hasn't'};
ok verb(q{hurts})->is_singular  => q{is_singular: 'hurts'};
ok verb(q{breaks})->is_singular  => q{is_singular: 'breaks'};
ok verb(q{continues})->is_singular  => q{is_singular: 'continues'};
ok verb(q{waits})->is_singular  => q{is_singular: 'waits'};
ok verb(q{wends})->is_singular  => q{is_singular: 'wends'};
ok verb(q{forgets})->is_singular  => q{is_singular: 'forgets'};
ok verb(q{shows})->is_singular  => q{is_singular: 'shows'};
ok verb(q{lies})->is_singular  => q{is_singular: 'lies'};
ok verb(q{happens})->is_singular  => q{is_singular: 'happens'};
ok verb(q{has})->is_singular  => q{is_singular: 'has'};
ok verb(q{talks})->is_singular  => q{is_singular: 'talks'};
ok verb(q{swears})->is_singular  => q{is_singular: 'swears'};
ok verb(q{mustn't})->is_singular  => q{is_singular: 'mustn't'};
ok verb(q{treads})->is_singular  => q{is_singular: 'treads'};
ok verb(q{overdraws})->is_singular  => q{is_singular: 'overdraws'};
ok verb(q{presets})->is_singular  => q{is_singular: 'presets'};
ok verb(q{dares})->is_singular  => q{is_singular: 'dares'};
ok verb(q{holds})->is_singular  => q{is_singular: 'holds'};
ok verb(q{shall})->is_singular  => q{is_singular: 'shall'};
ok verb(q{bends})->is_singular  => q{is_singular: 'bends'};
ok verb(q{misunderstands})->is_singular  => q{is_singular: 'misunderstands'};
ok verb(q{won't})->is_singular  => q{is_singular: 'won't'};
ok verb(q{strews})->is_singular  => q{is_singular: 'strews'};
ok verb(q{abides})->is_singular  => q{is_singular: 'abides'};
ok verb(q{feels})->is_singular  => q{is_singular: 'feels'};
ok verb(q{finds})->is_singular  => q{is_singular: 'finds'};
ok verb(q{rends})->is_singular  => q{is_singular: 'rends'};
ok verb(q{springs})->is_singular  => q{is_singular: 'springs'};
ok verb(q{smites})->is_singular  => q{is_singular: 'smites'};
ok verb(q{aren't})->is_singular  => q{is_singular: 'aren't'};
ok verb(q{sweats})->is_singular  => q{is_singular: 'sweats'};
ok verb(q{sha'n't})->is_singular  => q{is_singular: 'sha'n't'};
ok verb(q{bleeds})->is_singular  => q{is_singular: 'bleeds'};
ok verb(q{clings})->is_singular  => q{is_singular: 'clings'};
ok verb(q{provides})->is_singular  => q{is_singular: 'provides'};
ok verb(q{rides})->is_singular  => q{is_singular: 'rides'};
ok verb(q{ought})->is_singular  => q{is_singular: 'ought'};
ok verb(q{quits})->is_singular  => q{is_singular: 'quits'};
ok verb(q{sweeps})->is_singular  => q{is_singular: 'sweeps'};
ok verb(q{watches})->is_singular  => q{is_singular: 'watches'};
ok verb(q{falls})->is_singular  => q{is_singular: 'falls'};
ok verb(q{wrings})->is_singular  => q{is_singular: 'wrings'};
ok verb(q{must})->is_singular  => q{is_singular: 'must'};
ok verb(q{forsakes})->is_singular  => q{is_singular: 'forsakes'};
ok verb(q{knits})->is_singular  => q{is_singular: 'knits'};
ok verb(q{dwells})->is_singular  => q{is_singular: 'dwells'};
ok verb(q{goes})->is_singular  => q{is_singular: 'goes'};
ok verb(q{follows})->is_singular  => q{is_singular: 'follows'};
ok verb(q{insists})->is_singular  => q{is_singular: 'insists'};
ok verb(q{digs})->is_singular  => q{is_singular: 'digs'};
ok verb(q{misleads})->is_singular  => q{is_singular: 'misleads'};
ok verb(q{blitzes})->is_singular  => q{is_singular: 'blitzes'};
ok verb(q{remains})->is_singular  => q{is_singular: 'remains'};
ok verb(q{wins})->is_singular  => q{is_singular: 'wins'};
ok verb(q{strives})->is_singular  => q{is_singular: 'strives'};
ok verb(q{meets})->is_singular  => q{is_singular: 'meets'};
ok verb(q{oughtn't})->is_singular  => q{is_singular: 'oughtn't'};
ok verb(q{flings})->is_singular  => q{is_singular: 'flings'};
ok verb(q{likes})->is_singular  => q{is_singular: 'likes'};
ok verb(q{stands})->is_singular  => q{is_singular: 'stands'};
ok verb(q{overtakes})->is_singular  => q{is_singular: 'overtakes'};
ok verb(q{slinks})->is_singular  => q{is_singular: 'slinks'};
ok verb(q{kneels})->is_singular  => q{is_singular: 'kneels'};
ok verb(q{isn't})->is_singular  => q{is_singular: 'isn't'};
ok verb(q{busts})->is_singular  => q{is_singular: 'busts'};
ok verb(q{eats})->is_singular  => q{is_singular: 'eats'};
ok verb(q{builds})->is_singular  => q{is_singular: 'builds'};
ok verb(q{becomes})->is_singular  => q{is_singular: 'becomes'};
ok verb(q{burns})->is_singular  => q{is_singular: 'burns'};
ok verb(q{undertakes})->is_singular  => q{is_singular: 'undertakes'};
ok verb(q{staves})->is_singular  => q{is_singular: 'staves'};
ok verb(q{vexes})->is_singular  => q{is_singular: 'vexes'};
ok verb(q{swells})->is_singular  => q{is_singular: 'swells'};
ok verb(q{don't})->is_singular  => q{is_singular: 'don't'};
ok verb(q{slides})->is_singular  => q{is_singular: 'slides'};
ok verb(q{stays})->is_singular  => q{is_singular: 'stays'};
ok verb(q{steals})->is_singular  => q{is_singular: 'steals'};
ok verb(q{beholds})->is_singular  => q{is_singular: 'beholds'};
ok verb(q{undergoes})->is_singular  => q{is_singular: 'undergoes'};
ok verb(q{arises})->is_singular  => q{is_singular: 'arises'};
ok verb(q{keeps})->is_singular  => q{is_singular: 'keeps'};
ok verb(q{gilds})->is_singular  => q{is_singular: 'gilds'};
ok verb(q{withstands})->is_singular  => q{is_singular: 'withstands'};
ok verb(q{stinks})->is_singular  => q{is_singular: 'stinks'};
ok verb(q{could})->is_singular  => q{is_singular: 'could'};
ok verb(q{breeds})->is_singular  => q{is_singular: 'breeds'};
ok verb(q{slits})->is_singular  => q{is_singular: 'slits'};
ok verb(q{needn't})->is_singular  => q{is_singular: 'needn't'};
ok verb(q{saws})->is_singular  => q{is_singular: 'saws'};
ok verb(q{gives})->is_singular  => q{is_singular: 'gives'};
ok verb(q{moves})->is_singular  => q{is_singular: 'moves'};
ok verb(q{puts})->is_singular  => q{is_singular: 'puts'};
ok verb(q{niches})->is_singular  => q{is_singular: 'niches'};
ok verb(q{fights})->is_singular  => q{is_singular: 'fights'};
ok verb(q{shoes})->is_singular  => q{is_singular: 'shoes'};
ok verb(q{sublets})->is_singular  => q{is_singular: 'sublets'};
ok verb(q{spends})->is_singular  => q{is_singular: 'spends'};
ok verb(q{needs})->is_singular  => q{is_singular: 'needs'};
ok verb(q{catches})->is_singular  => q{is_singular: 'catches'};
ok verb(q{douches})->is_singular  => q{is_singular: 'douches'};
ok verb(q{swims})->is_singular  => q{is_singular: 'swims'};
ok verb(q{weeps})->is_singular  => q{is_singular: 'weeps'};
ok verb(q{should})->is_singular  => q{is_singular: 'should'};
ok verb(q{bursts})->is_singular  => q{is_singular: 'bursts'};
ok verb(q{deals})->is_singular  => q{is_singular: 'deals'};
ok verb(q{spoils})->is_singular  => q{is_singular: 'spoils'};
ok verb(q{rives})->is_singular  => q{is_singular: 'rives'};
ok verb(q{strips})->is_singular  => q{is_singular: 'strips'};
ok verb(q{lives})->is_singular  => q{is_singular: 'lives'};
ok verb(q{speeds})->is_singular  => q{is_singular: 'speeds'};
ok verb(q{wakes})->is_singular  => q{is_singular: 'wakes'};
ok verb(q{bellyaches})->is_singular  => q{is_singular: 'bellyaches'};
ok verb(q{was})->is_singular  => q{is_singular: 'was'};
ok verb(q{runs})->is_singular  => q{is_singular: 'runs'};
ok verb(q{foretells})->is_singular  => q{is_singular: 'foretells'};

done_testing();
