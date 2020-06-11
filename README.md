# mapbox-ios-issue-demo
Mapbox annotations issues on iOS

#### Environment
 - xCode 11.5
 - iPad Air 3rd gen with iOS 13.5
 - Mapbox-iOS-SDK v5.9.0


#### How to reproduce
 1. Download the repo
 2. Run `pod install` in the Terminal
 3. Open the workspace in xCode 11
 4. Run the app on iPad

### Issues
[Video](https://github.com/RustamG/mapbox-ios-issue-demo/raw/master/Video.mp4)

1. Floating annotations are shown in the top left corner. These annotations are supposed to be displayed in the currently not-visible area of the map. [Screenshot](https://github.com/RustamG/mapbox-ios-issue-demo/blob/master/Floating-annotation-bug.png)
2. `didSelect` delegate methods are not called when I click on the annotations that are showing in the initial map area. However if I pan the map far from this area and return back there, click events start to work.
3. Annotations are moved to the top-left corner after clicking on them until further interactions with the map. See 0:43 in the [video](https://github.com/RustamG/mapbox-ios-issue-demo/raw/master/Video.mp4)

#### Things to note
1. I add annotations to the `mapView` in `DispatchQueue.main.asyncAfter` [closure]([https://github.com/RustamG/mapbox-ios-issue-demo/blob/master/mapbox-issue-demo/Map/MapView.swift#L51](https://github.com/RustamG/mapbox-ios-issue-demo/blob/master/mapbox-issue-demo/Map/MapView.swift#L51)) to emulate loading from external source. 
2. I use [centerOffset](https://github.com/RustamG/mapbox-ios-issue-demo/blob/master/mapbox-issue-demo/Map/ZoneMapAnnotation.swift#L80) for annotation views because their actual coordinate is in the lower left corner.
3. I embed the Mapbox view in SwiftUI environment.
