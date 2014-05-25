RDHOrderedDictionary [![Build Status](https://travis-ci.org/rhodgkins/RDHOrderedDictionary.svg?branch=master)](https://travis-ci.org/rhodgkins/RDHOrderedDictionary)
====================

Ordered version of `NSDictionary` backed by a `NSOrderedSet`.

[Documentation](http://cocoadocs.org/docsets/RDHOrderedDictionary/)

The main purpose of this class is to provide a guranteed order to a `NSDictionary` as the keys are set on the dictionary. The standard `NSDictionary` does not keep the order of items as they are entered, where as `RDHOrderedDictionary` uses a `NSOrderedSet` as its key storage. As well as meaning that the key order is kept constant, it also means various methods are available such as [`firstKey`](http://cocoadocs.org/docsets/RDHOrderedDictionary/0.2.0/Classes/RDHOrderedDictionary.html#//api/name/firstKey) and  [`firstValue`](http://cocoadocs.org/docsets/RDHOrderedDictionary/0.2.0/Classes/RDHOrderedDictionary.html#//api/name/firstValue) (also [`lastKey`](http://cocoadocs.org/docsets/RDHOrderedDictionary/0.2.0/Classes/RDHOrderedDictionary.html#//api/name/lastKey) and  [`lastValue`](http://cocoadocs.org/docsets/RDHOrderedDictionary/0.2.0/Classes/RDHOrderedDictionary.html#//api/name/lastValue)) for convenient accessing of entries.
