# ReactiveEstimote

[![CI Status](http://img.shields.io/travis/eliperkins/ReactiveEstimote.svg?style=flat)](https://travis-ci.org/eliperkins/ReactiveEstimote)
[![Version](https://img.shields.io/cocoapods/v/ReactiveEstimote.svg?style=flat)](http://cocoadocs.org/docsets/ReactiveEstimote)
[![License](https://img.shields.io/cocoapods/l/ReactiveEstimote.svg?style=flat)](http://cocoadocs.org/docsets/ReactiveEstimote)
[![Platform](https://img.shields.io/cocoapods/p/ReactiveEstimote.svg?style=flat)](http://cocoadocs.org/docsets/ReactiveEstimote)

A few handy extensions for working with the Estimote SDK, together with ReactiveCocoa.

This library came to be after attempting to work with editing properties of an `ESTBeacon` object, but needing to wait for the connection to the device.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objc
ESTBeacon *beacon = //some beacon from an `ESTBeaconManager`

[[beacon
    rac_connect]
    flattenMap:^RACStream *(ESTBeacon *beacon) {
        return [[[beacon rac_writeMajor:1]
            concat:[beacon rac_writeMinor:1]]
            concat:[beacon rac_writeProximityUUID:[[NSUUID alloc] initWithUUIDString:@"44F77920-EBF9-11E3-AC10-0800200C9A66"]]];
    }];

```

## Requirements

## Installation

ReactiveEstimote is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ReactiveEstimote"

## Author

Eli Perkins, eli.j.perkins@gmail.com

## License

ReactiveEstimote is available under the MIT license. See the LICENSE file for more info.
