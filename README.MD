# Technical assignment - Wikipedia

## Wikipedia app

Changes:
- find out what is the existing way of handing deep/universal links
- adjust the logic in a way that is consistent with the existing codebase
- try to re-use existing mechanism instead of adding own solutions on top 

Changes can be found (here)[https://github.com/wikimedia/wikipedia-ios/compare/main...atmamont:wikipedia-ios-abn-amro-assignment:feature/places_deep_link]

In short, logic is:
- whenever we detect `Places` deep/universal link, we parse all query parameters trying to instantiate full location object (simple dictionary)
- on success, we pass this object via new `PlacesViewController` API call to `showPlace(_ place: Place)`
- on failure we proceed with the standard logic trying to open an article with a given URL
