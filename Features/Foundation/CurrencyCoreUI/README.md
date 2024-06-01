# SMSCore Feature
<a id="markdown-smscore-feature" name="smscore-feature"></a>

<!-- TOC -->

- [SMSCore Feature](#smscore-feature)
  - [1. SMSCore classes](#1-smscore-classes)
    - [1.1. Coordinator](#11-coordinator)
        - [1.1.1. Create a custom Coordinator](#111-create-a-custom-coordinator)
    - [1.2. Keychain](#12-keychain)
      - [1.2.1. Create a Keychain](#121-create-a-keychain)
      - [1.2.2. Share data across apps](#122-share-data-across-apps)
      - [1.2.3. Keychain sharing utilities](#123-keychain-sharing-utilities)
  - [2. SMSCore Protocols](#2-smscore-protocols)
      - [2.1. Withable](#21-withable)
  - [3. Extensions](#3-extensions)
    - [3.1. Combine](#31-combine)
      - [3.1.1. CancelBag](#311-cancelbag)
  - [4. Debug Utilities ](#4-debug-utilities)
    - [4.1. Dump String](#41-dump-string)


<!-- /TOC -->



The SMSCore feature offers fundamental classes, extensions and protocols which are used throughout the SAP Mobile Start app. It should serve as the SMSCore for all other features.

## 1. SMSCore classes 
<a id="markdown-smscore-classes" name="smscore-classes"></a>

### 1.1. Coordinator 
<a id="markdown-coordinator" name="coordinator"></a>

The `Coordinator` is a base class which should be used to create coordinators which control the UI flow of the application. The idea is based on the [Coordinator Pattern](https://www.youtube.com/watch?v=a1g3k3NObkE&t=1023s&ab_channel=CocoaHeadsStockholm). A `Coordinator` is an entity that manages the presenting/dismissing of one or more UIViewControllers to form an encapsulated user flow. The coordinator is utilised within SAP Mobile Start to control UI flows. Each feature that provides a dedicated UI flow should expose an `Coordinator` instance for other features to consume. 

##### 1.1.1. Create a custom Coordinator 
<a id="markdown-create-a-custom-coordinator" name="create-a-custom-coordinator"></a>

The `Coordinator` base class mimics the concept on an abstract class. In order to create a custom coordinator you __must__ inherit from the base `Coordinator` class and __must__ implement dedicated `init`, `start` and `finish` methods. Additionally you need to declare the type of the `rootViewController` of your `Coordinator` instance.

```swift
public final class MyCoordinator: Coordinator<UINavigationController> {

    // MARK: - Initializer
    override public init(rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController)
    }

    // MARK: - Lifecycle
    override public func start() { }

    override public func finish() { }
}
```

### 1.2. Keychain
<a id="markdown-keychain" name="keychain"></a>

The `Keychain` class offers a simple convenient Swift wrapper around the iOS Keychain. You can use it so save instances of the following types:

- `Data`
- `Bool`
- `String`
- `Codable`

#### 1.2.1. Create a Keychain
<a id="markdown-create-a-keychain" name="create-a-keychain"></a>

 In order to use the Keychain just instantiate a new instance and start to save, get or delete values on it.

 ```swift
 var keychain: Keychain = Keychain()

 let value: Bool = true

 // Set a value
 try keychain.set(value, forKey: "valueKey") // Wo

 // Get the value
 let data  = try keychain.get("valueKey")

 // Delete the key
 try keychain.delete("valueKey")
 ```

#### 1.2.2. Share data across apps 
<a id="markdown-share-data-across-apps" name="share-data-across-apps"></a>
 <a id="markdown-share-data-across-apps" name="share-data-across-apps"></a>

In order to share Keychain items across apps, you can create a Keychain instance with an `accessGroup` attached to it. Please be aware that you still need to add the Keychain sharing capability to your entitlements file.

```swift
var keychain: Keychain = Keychain(accessGroupIdentifier: "<AppIdentifier>.com.test")
```

#### 1.2.3. Keychain sharing utilities 
<a id="markdown-keychain-sharing-utilities" name="keychain-sharing-utilities"></a>

To properly enable Keychain Sharing between the main app of SAP Mobile Start and Extensions the same Access Group compatible to previous releases of SAP Mobile Start needs to be used. For this utilities exist to reference the same Access Group:

- `BundleIdentifier`
- `AccessGroup`

`BundleIdentifier` offers to access the main BundleIdentifier of the current executable with its currently only case `executable` and property `id`.

`AccessGroup` will construct a consistent Access Group for both the main application and all of its Extensions.
It needs the `bundleId` as parameter, where the previously mentioned utility can be used.
`AccessGroup` will extract the TeamID out of the Bundle, which needs to be added to the `.plist` of each executable using the key `Team_Id`.
It is recommended to point to the property `$(DEVELOPMENT_TEAM)` of the configuration files.
The final access group can be accessed using the property `id`, which prepends the TeamID to a static suffix which is used since v1.0 of SAP Mobile Start.

## 2. SMSCore Protocols 
<a id="markdown-smscore-protocols" name="smscore-protocols"></a>

#### 2.1. Withable 
<a id="markdown-withable" name="withable"></a>

The `Withable` protocol is a convenient protocol to support declarative initialization of classes. You can think of it as something like `map()` for a single element.

```swift
lazy var submitButton = UIButton().with {
    $0.setTitle("Submit", for: .normal)
    $0.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
}
```

You can even add the protocol to your own classes:

```swift
final class MyViewModel: Withable {
    var text: String
    var count: Int
}

let viewModel = MyViewModel().with {
    $0.text = "Hello World"
    $0.count = 42
}
```

## 3. Extensions 
<a id="markdown-extensions" name="extensions"></a>

For all extensions that are not explicitly mentioned here, please refer to the Swift Documentation of the respective source files

### 3.1. Combine 
<a id="markdown-combine" name="combine"></a>

#### 3.1.1. CancelBag 
<a id="markdown-cancelbag" name="cancelbag"></a>

A `CancelBag` is a convenient wrapper around a `Set<AnyCancellable>` that makes storing of references to `AnyCancellable` instances easier by not caring about the lifetime of these references by hand. 

```swift
// Create the bag
let cancelBag = CancelBag()

// Declare your publishers and store their `AnyCancellables` in the bag
Just(1)
    .eraseToAnyPublisher()
    .sink { _ in }
    .store(in: cancelBag)

Just(1)
    .eraseToAnyPublisher()
    .sink { _ in }
    .store(in: cancelBag)
```

## 4. Debug Utilities 
<a id="markdown-debug-utilities" name="debug-utilities"></a>


### 4.1 Dump String 
<a id="markdown-dump-string" name="dump-string"></a>

To create a nice debug string for `Any` instance, you can use `dumpString` to create a string and then print it.

```swift
import SMSCore

let myType: MyType

print(dumpString(from: myType))
```
