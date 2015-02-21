SwiftRational
=============

A small library implementing support for [rational numbers](http://en.wikipedia.org/wiki/Rational_number) in Swift. Implemented as a single type, `Rational`.

Features
--------

* Construct rationals from integers, doubles, integer literals, double literals, or a numerator and denominator
* Rationals are always in irreduceable form
* `+`, `-`, `*`, `/`, `==`, `<`, and all other comparison operators
* Conforms to `Printable` - print them out or stringify them
* Conforms to `Hashable` - use as dictionary keys
* `-` prefix operator to negate
* `inverse` property to get the inverse
* Conforms to `AbsoluteValuable`; get the absolute value using `abs`
* Check for overflow using `addWithOverflow`, `subtractWithOverflow`, `multiplyWithOverflow`, and `divideWithOverflow`


Instructions
------------

1. Clone the repository
2. Copy the file `rational.swift` into your project, *or* add the framework
3. Enjoy


Plans
-----

* Unit tests
* `%` and `remainderWithOverflow` support
* Get demo project to stop giving me cryptic warnings

Pull requests, bug reports, and any other feedback are all welcome.


License
-------

SwiftRational © 2015 Austin Zheng, released as open-source software subject to the MIT license.
