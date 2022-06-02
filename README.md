## Build tools & versions used
- macOS 12.4
- iOS 15.5
- Xcode 13.4
- Swift 5
- SwiftUI

## Steps to run the app
- Xcode will take a minute to resolve a couple of small packages using Swift Package Manager.
- Please use any iOS simulator or device on version 15.4 and above.
- To simulate an error loading the data or for malformed data use `EmployeesResponseType`.

## What areas of the app did you focus on?
## What was the reason for your focus? What problems were you trying to solve?
First and foremost I focused on creating a beautiful (if I may say) UI/UX which highlights the key elements of the employees. To provide the best user experience I even took advantage of `URLCache` to allow for offline viewing and super fast image loading. Accessibility support is built right into SwiftUI so if a user requires larger text or wants to use dark mode they're empowered to do so. On the code side, I focused on creating a highly decoupled, scalable and testable architecture using methods like protocol oriented programming, dependency injection and MVVM. Finally, SwiftUI enabled me to create previously complex views in only a few lines of code using its declarative programming paradigm.

## How long did you spend on this project?
~8 hours (with breaks ☺️)

## Did you make any trade-offs for this project? What would you have done differently with more time?
SwiftUI currently only supports using its `.refreshable()` modifier to create a pull-to-refresh in a `List`. Since I'm using a `LazyVGrid` that wasn't possible and I instead needed to add a dedicated button which isn't ideal. Given more time, I would look into creating a custom pull-to-refresh using `GeometryReader` and `PreferenceKey`.

## What do you think is the weakest part of your project?
As mentioned above, SwiftUI still has many limitations and much room to grow but at the same time can provide tremendous value when used correctly.

## Did you copy any code or dependencies? Please make sure to attribute them here!
I'm making use of two dependencies one of which I wrote and maintain. Firstly, `SFSafeSymbols` protects users of SF Symbols from entering the name of the symbol wrong by making use of a custom `Image` initializer. `SwiftNetworking` is my own package that I use in my apps for abstracting networking logic and extending some `Foundation` APIs like `URLSession` and `URLRequest`. The key element you'll find being used in my code is the `HTTPClient` which is simply a protocol that any object can conform to and allows for better testability for example. `URLSession` conforms to this protocol right out of the box and is what I use for this project.

## Is there any other information you’d like us to know?
Thanks for taking time to check out my implementation and hope you enjoy!
