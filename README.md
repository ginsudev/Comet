
# Comet

A Framework for writing SwiftUI preference panes for iOS jailbreak tweaks.


## Installing the Theos template

1. Install Orion:
https://orion.theos.dev/getting-started.html

2. Clone this repository

```bash
  git clone https://github.com/ginsudev/Comet && cd Comet
```

3. Copy Comet.framework to theos
- Install Comet from Chariz repo, then copy `/Library/Frameworks/Comet.framework/` from device to your `theos/lib` directory on Mac (`$(THEOS)/lib/`).

- Or run `make package` to get `Comet.framework` and move it to `theos/lib` folder.

4. Copy / Move the `comet-prefs` folder into `$THEOS/vendor/templates/ios/` with Finder or by command:

```bash
  cp -r comet-prefs/ $THEOS/vendor/templates/ios/
```
5. Run the `build.sh` script in `$THEOS/vendor/templates/`

```bash
  cd $THEOS/vendor/templates/

  ./build.sh
```

6. Create a new project with NIC and choose `iphone/tweak_swift` (Skip if you already have a tweak):

```bash
  cd ~

  $THEOS/bin/nic.pl

  Choose a Template (required): 19 (Or whatever number `iphone/tweak_swift` comes in at)
  Project Name (required): Some tweak name
  Package Name [com.yourcompany.sometweakname]: com.somecompany.sometweakname
  Author/Maintainer Name [Ginsu]: Ginsu
  [iphone/tweak_swift] MobileSubstrate Bundle filter [com.apple.springboard]: [Press Enter]
```

7. Create `comet-prefs` as a subproject inside your tweak:

```bash
cd ~/sometweakname/

$THEOS/bin/nic.pl

Choose a Template (required): 9 (Or whatever number `comet-prefs` comes in at)
Project Name (required): Some prefs name
Package Name [com.yourcompany.sometweakname]: com.somecompany.someprefsname
Author/Maintainer Name [Ginsu]: Ginsu
```

8. Run `make spm` in your project:

```bash
  make spm
```

9. Add `com.ginsu.comet` as a dependency to your tweak.
```bash
Depends: com.ginsu.comet
```
Additionally, you can edit your Makefiles and changes settings like TARGET and specify different sdk versions. Note: Comet only supports iOS 14+.
## How to use it?

That's the simplest part, once you've got everything setup, you can start creating your SwiftUI views and modifying `RootView.swift` to your liking.

### Adding new preferences with the @Published(key: _, registry: _) attribute
Preferably inside of the `PreferenceStorage.swift` file, you can add your preferences like so:
```swift
@Published(key: "isEnabledSomeFeature", registry: registry) var isEnabledSomeFeature = false
```
#### Breakdown:
- The `registry` paramater is the file path to your preference plist file.
- The `key` paramater is the key where the value will be read from and written to.
- `isEnabledSomeFeature` is the name of the variable (could be anything, but good to keep it the same as the key name).
- The initial value assigned to the property (In this case `false`) is the default / fallback value that will be used if there is no value for the key.

### Best practice in adding additional pages
Firstly, to add a new page to your preference pane, you would use a `NavigationLink` in SwiftUI. Example:
```swift
struct RootView: View {
    @StateObject private var preferenceStorage = PreferenceStorage()
    
    var body: some View {
        Form {
            NavigationLink("2nd page") {
                PageTwo()
                    .environmentObject(preferenceStorage)
            }
        }
    }
}
```
#### Why did I use an .environmentObject() modifier?
Firstly, it's good practice to have 1 source of truth for all your preferences. In other words, have all your preferences in the `PreferenceStorage.swift` file. We can then pass `preferenceStorage` down the view hierachy so that it can be accessed in subviews. For example:

```swift
struct PageTwo: View {
    @EnvironmentObject var preferenceStorage: PreferenceStorage
    
    var body: some View {
        Form {
            Section {
                Toggle("Enabled 2", isOn: $preferenceStorage.isEnabledTwo)
            } header: {
                Text("The best tweak ever")
            } footer: {
                Text("A footer for the best tweak ever.")
                    .foregroundColor(preferenceStorage.isEnabledTwo ? .green : .red)
                    .animation(.default, value: preferenceStorage.isEnabledTwo)
            }
        }
        .navigationTitle("Page 2!")
    }
}
```
One of the benefits here is that you can toggle some preferences on/off and then show additional changes on the RootView, like hide/show a row depending if some option is enabled, etc..
## Known issues

1. You can't use `.toolbar()` or `.navigationTitle()` SwiftUI modifiers inside of `RootView`, but you can in subsequent pages / links. Workaround: add buttons to the nav bar in `RootViewController.swift` file, or don't touch the navigation bar in `RootView`.
