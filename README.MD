# Technical assignment - Wikipedia location service app

## Wikipedia app

In order to open the Wikipedia app using a deeplink, I need to:
- find out what is the existing way of handing deep/universal links
- adjust the logic in a way that is consistent with the existing codebase
- try reusing existing mechanism instead of adding my own solutions 

Diff with changes made can be found (here)[https://github.com/wikimedia/wikipedia-ios/compare/main...atmamont:wikipedia-ios-abn-amro-assignment:feature/places_deep_link]

In short, logic is:
- whenever we detect `Places` deep/universal link, we parse all query parameters trying to instantiate full location object (simple dictionary)
- on success, we pass this object via new `PlacesViewController` API call to `showPlace(_ place: Place)`
- on failure we proceed with the standard logic trying to open an article with a given URL

## Places app

### Comments

My goal for this app was not only to meet the criteria but learn something new in addition. We do not use much of SwiftUI in production yet so I decided this is the perfect opportunity to leverage new `Observability` framework and get better at SwiftUI data flow in general so in the future I have better understanding how to start using SwiftUI in a big UIKit project. It removes some workarounds that were needed before to make abstractions over observable data types and it's a breeze now! I truly enjoyed the speed of building UI using SwiftUI. I was paying attention to proper decoupling SwiftUI from the business-logic and other layers including view models and it seems it went pretty well.
Another goal was to write a couple of unit tests for SwiftUI view triggered behaviors. Unlike the UIKit, I didn't find a quick way to simulate view loading (something similar to `sut.loadViewIfNeeded()` in `UIViewController`) that usually starts the test sequence. I do not think it is hard but I just ran out of time having quite packed week behind.
However, I learned how to write unit tests again `@Observable` and it looks nice right out of the box even without additional helpers and wrappers like it usually happens with expectations to make tests code readable.

### What to improve

1. I briefly researched ways to improve optionality when used as Binding and didn't find the quick one. Everything seemed to be a compromise so I just made view model parameters non-optional. However, in a real project I would of course never use an empty string instead of optional.
2. More code could be extracted to reuse (like opening an external app using `UIApplication.shared.open`).
3. SwiftUI UI part is very basic as I decided that this is something I can spend a lot of time on without good returns considering my basic knowledge of SwiftUI. I prefered to invest my time in the architecture and unit tests.
4. The "Open custom location" screen is definitely a trade-off. I wish I had more time to introduce a new caching layer (even using SwiftData maybe?) and add a custom user-provided location to the main dataset so it renders automatically on the main feed. For now let's be pragmatic and just accomplish the requirements without adding the new location to the dataset.
5. Error handling is not present in the UP part. All errors are properly handled and passed from the feed loading layer but ignored in the view model. Of course I would propagate them to view and present a simple alert if I could spare a bit more time.
  
### Dependencies diagram 

![Diagram](DependencyDiagram.drawio.png)
