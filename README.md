# picguard-swift

![](https://www.bitrise.io/app/0ee59475f60743f7.svg?token=yOJZx9kJX6J2MRDNsHRnxQ&branch=develop)
![](https://img.shields.io/github/release/netguru/picguard-swift.svg)
![](https://img.shields.io/badge/swift-2.2-orange.svg)
![](https://img.shields.io/badge/carthage-compatible-green.svg)

Use Google Cloud Vision API to analyze pictures uploaded in your application and guard against inappropriate content.

## Development

### Environment

Picguard is written in **Swift 2.2** and requires **Xcode 7.3** or higher to be developed.

### Installation

Install Carthage dependencies using the following command and you're ready to go!

```bash
$ carthage bootstrap --platform 'iOS'
```

### Coding standards

Picguard follows standards described in [GitHub's Swift Style Guide](https://github.com/github/swift-style-guide).

### Organizational standards

Keep **build settings** in the appropriate `xcconfig` files inside `Configuration` directory. Please do not include any build settings in `pbxproj`.

**Source files** and **spec files** should be placed inside `Sources` and `Tests` directories respectively, without additional subfolders. You may use groups to manage the files inside the Xcode project itself.

**Bitrise CI** configuration should be described in `bitrise.yml` file and no workflows should be overwritten inside Bitrise.io UI.

## About

### Maintainers

**Adrian Kashivskyy**

- https://github.com/akashivskyy
- https://twitter.com/akashivskyy

**Łukasz Wolańczyk**

- https://github.com/lukwol

### License

Picguard is licensed under the MIT License. See [LICENSE.md](LICENSE.md).
