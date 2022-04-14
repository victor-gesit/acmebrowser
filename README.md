# ACME Browser

ACME Browser is a small lightweight web browser that lets a user surf the web. It allows the creation of multiple tabs.

### Tech

ACME Browser is built for iPhones and is built mainly using Apple's technologies.

- [Swift](swift.org) - Apple's programming language for building for Apple devices.
- [SwiftUI](https://developer.apple.com/xcode/swiftui) - Apple's most recent framework for building user interfaces.

### Installation

ACME Browser is built using [Swift 5.0](swift.org) on [XCode 13.3](https://developer.apple.com/documentation/xcode-release-notes/xcode-13-release-notes) and runs on iOS 15.0 and above.
To run on your machine,

- Clone this repo
- Open the `acmebrowser.xcodeproj` file in XCode
- Specify your provisioning profile. You might have to change the build identifier also.
- Run the app on a connected device or emulator.


### Features
- A new tab is automatically created when a user opens the app
- A new tab can be added to existing tabs.
- User can navigate to previous and next pages (if they exist)

### Additonal Features
- If a user enters an invalid url/text, a google search is performed on that text
- A user can see a thumbnail of the page they're currently on.

### Not Implemented
- I started out working on implementing the preview feature but was blocked by an error in the function for taking a screenshot of a View.
## License

[MIT](https://opensource.org/licenses/MIT)
