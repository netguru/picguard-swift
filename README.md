![](Images/Header.png)

![](https://www.bitrise.io/app/0ee59475f60743f7.svg?token=yOJZx9kJX6J2MRDNsHRnxQ&branch=develop)
![](https://img.shields.io/github/release/netguru/picguard-swift.svg)
![](https://img.shields.io/badge/swift-2.2-orange.svg)
![](https://img.shields.io/badge/carthage-compatible-green.svg)
![](https://img.shields.io/badge/cocoapods-compatible-green.svg)

Use [Google Cloud Vision API](https://cloud.google.com/vision/) to analyze pictures uploaded in your application and guard against inappropriate content.

## Usage

After [obtaining your own Google API Key](https://cloud.google.com/vision/docs/auth-template/cloud-api-auth#set_up_an_api_key), create a `Picguard` instance to be used in the following examples:

```swift
let picguard = Picguard(APIKey: "foobar")
```

### Detecting unsafe content

If your app is a service which allows users to upload photos, you may often need a NSFW filter to reject pictures containing **adult content**, **violence**, **spoof** and **medical content**.

Picguard offers a unified method for checking all of above categories and uses an algorithm to calculate an average likelihood of NSFW content:

```swift
picguard.detectUnsafeContentLikelihood(image: anImage) { result in
    switch result {
        case .Success(let likelihood):
            print("Likelihood of NSFW content: \(likelihood)")
        case .Error(let error):
            print("Error detecting NSFW content: \(error)")
    }
}
```

### Detecting face presence

Sometimes you may need to know whether a photo **contains any faces**. For such case, Picguard offers a simple method to calculate a likelihood of any face being present in a picture:

```swift
picguard.detectFacePresenceLikelihood(image: anImage) { result in
    switch result {
        case .Success(let likelihood):
            print("Likelihood of face presence: \(likelihood)")
        case .Error(let error):
            print("Error detecting face presence: \(error)")
    }
}
```

### Raw annotation

As Picguard is a **fully featured Google Cloud Vision API client**, you may compose your own requests that are not covered by above helpers and interpret the results your way:

```swift
picguard.annotate(image: anImage, features: [
    .Face(maxResults: 2),
    .Label(maxResults: 5),
    .Landmark(maxResults: 3),
]) { result in
    switch result {
        case .Success(let response):
            print("Face annotations: \(response.faceAnnotations)")
            print("Label annotations: \(response.labelAnnotations)")
            print("Landmark annotations: \(response.landmarkAnnotations)")
        case .Error(let error):
            print("Error analyzing image: \(error)")
    }
}
```

All `*Annotation` data types are richly documented and reflect equivalent [API classes](https://cloud.google.com/vision/reference/rest/v1/images/annotate).

### More examples

If you feel the need to play with Picguard before using it in your app, we prepared a **demo playground** especially for you! Just clone this repository, build the framework, open `Picguard.playground` and you're ready to go!

## Installation

### Requirements

Picguard is written in **Swift 2.2** and requires **Xcode 7.3** or higher to be compiled. Minimum deployment target is **iOS 9** and **OS X 10.11**.

### Carthage

If you're using [Carthage](https://github.com/Carthage/Carthage), just add the following dependency to your `Cartfile`:

```none
github "netguru/picguard-swift"
```

### CocoaPods

Using Picguard with CocoaPods is as easy as adding the following dependency to your `Podfile`:

```none
use_frameworks!
pod 'Picguard'
```

## Development

### Environment

Picguard is written in **Swift 2.2** and requires **Xcode 7.3** or higher to be developed.

### Installation

Install Carthage dependencies using the following command and you're ready to go!

```bash
$ carthage bootstrap --platform 'iOS,Mac'
```

### Coding standards

Picguard follows standards described in [GitHub's Swift Style Guide](https://github.com/github/swift-style-guide).

Please note that one of the points is to "**use tabs, not spaces**". Rationale: When using tabs, developers can configure the IDE to display them as 2, 3, 4 or any other number of spaces they like – thus there is no discussion on that topic.

### Organizational standards

Keep **build settings** in the appropriate `xcconfig` files inside `Configuration` directory. Please do not include any build settings in `pbxproj`.

**Source files** and **spec files** should be placed inside `Sources` and `Tests` directories respectively, without additional subfolders. You may use groups to manage the files inside the Xcode project itself.

**Bitrise CI** configuration should be described in `bitrise.yml` file and no workflows should be overwritten inside Bitrise.io UI.

### Committing

This repository uses [git-flow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) and protects `develop` and `master` branches from force pushes, and red builds, which means the whole development process is pull-request-driven.

## About

This project is made with <3 by [Netguru](https://netguru.co/opensource) and maintained by:

- Adrian Kashivskyy ([github](https://github.com/akashivskyy), [twitter](https://twitter.com/akashivskyy))
- Łukasz Wolańczyk ([github](https://github.com/lukwol))

Also, don't forget to check out [the original Picguard](https://github.com/netguru/picguard), our ruby gem for validating uploaded images!

### License

This project is licensed under the MIT License. See [LICENSE.md](LICENSE.md) for more info.
