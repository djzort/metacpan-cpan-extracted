# NAME

Math::BigInt::Pari - a math backend library based on Math::Pari

# SYNOPSIS

    # to use it with Math::BigInt
    use Math::BigInt lib => 'Pari';

    # to use it with Math::BigFloat
    use Math::BigFloat lib => 'Pari';

    # to use it with Math::BigRat
    use Math::BigRat lib => 'Pari';

# DESCRIPTION

Math::BigInt::Pari inherits from Math::BigInt::Lib.

Provides support for big integer in Math::BigInt et al. calculations via means
of Math::Pari, an XS layer on top of the very fast PARI library.

# BUGS

Please report any bugs or feature requests to
`bug-math-bigint-pari at rt.cpan.org`, or through the web interface at
[https://rt.cpan.org/Ticket/Create.html?Queue=Math-BigInt-Pari](https://rt.cpan.org/Ticket/Create.html?Queue=Math-BigInt-Pari)
(requires login). We will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

# SUPPORT

After installing, you can find documentation for this module with the perldoc
command.

    perldoc Math::BigInt::Pari

You can also look for information at:

- GitHub

    [https://github.com/pjacklam/p5-Math-BigInt-Pari](https://github.com/pjacklam/p5-Math-BigInt-Pari)

- RT: CPAN's request tracker

    [https://rt.cpan.org/Dist/Display.html?Name=Math-BigInt-Pari](https://rt.cpan.org/Dist/Display.html?Name=Math-BigInt-Pari)

- MetaCPAN

    [https://metacpan.org/release/Math-BigInt-Pari](https://metacpan.org/release/Math-BigInt-Pari)

- CPAN Testers Matrix

    [http://matrix.cpantesters.org/?dist=Math-BigInt-Pari](http://matrix.cpantesters.org/?dist=Math-BigInt-Pari)

- CPAN Ratings

    [https://cpanratings.perl.org/dist/Math-BigInt-Pari](https://cpanratings.perl.org/dist/Math-BigInt-Pari)

# LICENSE

This program is free software; you may redistribute it and/or modify it under
the same terms as Perl itself.

# AUTHOR

Original Math::BigInt::Pari written by Benjamin Trott 2001,
<ben@rhumba.pair.com>.

Extended and maintained by Tels 2001-2007 [http://bloodgate.com](http://bloodgate.com)

Maintained by Peter John Acklam <pjacklam@gmail.com> 2010-2021.

[Math::Pari](https://metacpan.org/pod/Math%3A%3APari) was written by Ilya Zakharevich.

# SEE ALSO

[Math::BigInt](https://metacpan.org/pod/Math%3A%3ABigInt), [Math::BigFloat](https://metacpan.org/pod/Math%3A%3ABigFloat), [Math::Pari](https://metacpan.org/pod/Math%3A%3APari), and the other backends
[Math::BigInt::Calc](https://metacpan.org/pod/Math%3A%3ABigInt%3A%3ACalc), [Math::BigInt::GMP](https://metacpan.org/pod/Math%3A%3ABigInt%3A%3AGMP), and [Math::BigInt::Pari](https://metacpan.org/pod/Math%3A%3ABigInt%3A%3APari).
