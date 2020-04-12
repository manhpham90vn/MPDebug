# MPDebug
![MPDebug](https://raw.githubusercontent.com/manhpham90vn/MPDebug/master/demo.png)
[![CI Status](https://img.shields.io/travis/manhpham90vn/MPDebug.svg?style=flat)](https://travis-ci.org/manhpham90vn/MPDebug)
[![Version](https://img.shields.io/cocoapods/v/MPDebug.svg?style=flat)](https://cocoapods.org/pods/MPDebug)
[![License](https://img.shields.io/cocoapods/l/MPDebug.svg?style=flat)](https://cocoapods.org/pods/MPDebug)
[![Platform](https://img.shields.io/cocoapods/p/MPDebug.svg?style=flat)](https://cocoapods.org/pods/MPDebug)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

### NodeJS

```shell
brew install node
cd Server
npm install
```

### Run Server

```shell
./run.sh
```

final go to [Server](http://localhost:3000/)

## Installation

MPDebug is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MPDebug'
```

and your AppDelegate add

```Swift
MPDebugLog.share.start()
```
of 

```Swift
MPDebugLog.share.start(ip: "http://192.168.0.102:3000")
```

# Todo
- [ ] Support multipart form data request
- [ ] Support custom log command ex: MPDebug.Log("ViewController Deinited")
- [ ] Support custom log level ex: debug, verbose, info, error
- [ ] Support time of http request
- [ ] Support search and filter for server ex: filter url, device and search keyword

## Author

manhpham90vn, manhpham90vn@icloud.com

## License

MPDebug is available under the MIT license. See the LICENSE file for more info.
