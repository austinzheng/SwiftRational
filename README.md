SwiftRational
=============

A small library implementing support for [rational numbers](http://en.wikipedia.org/wiki/Rational_number) in Swift, as the `Rational` type.

**WARNING**: This is unmaintained proof-of-concept software; **don't use it for anything that actually matters.** Try something like Xiaodi Wu's [NumericAnnex](https://github.com/xwu/NumericAnnex) library instead.

Features
--------

* Construct rationals from integers, doubles, integer literals, double literals, or a numerator and denominator
* Rationals are always in irreducible form
* Value semantics, just like the standard numeric types you know and love
* `+`, `-`, `*`, `/`, `==`, `<`, and all other comparison operators
* Conforms to `Printable` - print them out or stringify them
* Conforms to `Hashable` - use as dictionary keys
* `-` prefix operator to negate
* `inverse` property to get the inverse
* Conforms to `AbsoluteValuable`; get the absolute value using `abs`
* Perform overflow-checked arithmetic using `addWithOverflow`, `subtractWithOverflow`, `multiplyWithOverflow`, and `divideWithOverflow`


Instructions
------------

1. Clone the repository
2. Copy the file `rational.swift` into your project, *or* add the framework
3. Enjoy using rational numbers


Plans
-----

* Unit tests
* `%` and `remainderWithOverflow` support
* Get demo project to stop giving me cryptic warnings (note that these warnings won't affect your usage of the code)

Pull requests, bug reports, and any other feedback are all welcome.


License
-------

SwiftRational © 2015 Austin Zheng, released as open-source software subject to the MIT license.
