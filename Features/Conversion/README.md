# Analytics Feature
<a id="markdown-analytics-feature" name="analytics-feature"></a>


<!-- TOC -->

- [Analytics Feature](#analytics-feature)
	- [1. How to](#1-how-to)
		- [1.1. Create an Analytics API instance](#11-create-an-analytics-api-instance)
			- [1.1.1. Environment Modes](#111-environment-modes)
		- [1.2. Use the analytics API](#12-use-the-analytics-api)
			- [1.2.1. Custom events](#121-custom-events)

<!-- /TOC -->

The Onboarding feature offers all fundamental functionality to onboard and authenticate a user and use their log in state to authenticate against backend

## 1. How to 
<a id="markdown-how-to" name="how-to"></a>

In order to use the analytics feature some steps must be executed. 

When you are solely developing a feature without any executable target you can directly jump to [1.1. Create an analytics API instance](#11-create-an-analytics-api-instance). If you are also in charge of an executable target please also refer to [1.2. Use the analytics API](#12-use-the-analytics-api)

### 1.1. Create an Analytics API instance 
<a id="markdown-create-an-analytics-api-instance" name="create-an-analytics-api-instance"></a>

Regularly a `AnalyticsAPI` instance is present within our dependency injection container at runtime. This needs be done __only__ in application targets, feature targets then can just assume there is a `AnalyticsAPI` instance present and use it accordingly. 

In order to register a `AnalyticsAPI` instance you need to have a concrete type ready that conforms to the protocol. The onboarding feature has already prepared the `AnalyticsService` type for that. So in order to use analytics throughout the app, register a concrete `AnalyticsService` instance as early as possible in the lifecycle of the application. It is recommended to extend from `Resolver` and conform to `ResolverRegistering` and implement `registerAllServices()`. This method is called whenever some feature wants to resolve a type for the first time. 

> Please pay attention that the `AnalyticsService` needs to have an `OnboardingAPI` instance being registered beforehand.

```swift
// AppDelegate+Injection.swift

import SMSCore

import Onboarding
import OnboardingAPI

import Analytics
import AnalyticsAPI

extension Resolver: ResolverRegistering {
	public static func registerAllServices() {

		register { SMSOnboardingServiceiOS() }
            .implements(OnboardingAPI.self)
			.scope(.shared)

        register { AnalyticsService() }
		  	.implements(AnalyticsAPI.self)
			.scope(.shared)
	}
}

```

In order for the `AnalyticsService` to function correctly it is necessary that you call `.initialize` as soon as possible after app start. The best place, would be inside your `AppDelegate.application(_:didFinishLaunchingWithOptions:)` method.

```swift
import UIKit
import AnalyticsAPI
import SMSCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	@Injected private var analyticsService: AnalyticsAPI

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		analyticsService.initialize()
		return true
	}
}
```

#### 1.1.1. Environment Modes
<a id="markdown-environment-modes" name="environment-modes"></a>

The analytics feature offers two modes it can operate in: 
* `develop` 
* `production`

Per default `develop` is active. In order to activate production mode, please add the following flag to your `SMS_ANALYTICS_ENVIRONMENT_PRODUCTION` to you `SWIFT_ACTIVE_COMPILATION_CONDITIONS` flag in the builds settings.

```
SWIFT_ACTIVE_COMPILATION_CONDITIONS = $(inherited) SMS_ANALYTICS_ENVIRONMENT_PRODUCTION
``` 

### 1.2. Use the analytics API
<a id="markdown-use-the-analytics-api" name="use-the-analytics-api"></a>


The basic event tracking hooks up to all interactions of the user automatically without you doing something. The only thing necessary is that it is integrated into the executable target as described in [1.1. Create an Analytics API instance](#11-create-an-analytics-api-instance)

#### 1.2.1. Custom events 
<a id="markdown-custom-events" name="custom-events"></a>
In addition to the automatic events tracked by the service it is possible to also track custom events. Create a new `AnalyticsEvent` instance and tell the `AnalyticsAPI` to track it. 


> **Warning**
> While the interface offers the possibility to track custom parameters, this is currently not applied since we are not allowed to track parameters

```swift
@Injected private var analyticsService: AnalyticsAPI

let event = AnalyticsEvent(title: "start_user_pressed_tile")

analyticsService.track(event: event)
```