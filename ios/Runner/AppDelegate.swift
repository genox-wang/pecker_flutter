import UIKit
import Flutter
import AppTrackingTransparency
import StoreKit
import Sentry


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  var mainChannel: FlutterMethodChannel?
  var backgroundTask:UIBackgroundTaskIdentifier! = nil
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller : FlutterViewController = self.window.rootViewController as! FlutterViewController
    mainChannel = FlutterMethodChannel(name: "pecker_flutter", binaryMessenger: controller.binaryMessenger)
    mainChannel?.setMethodCallHandler(_handlerMainChannel)
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    startSentry();
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
     NSLog("PUSH registration failed: \(error)")
  }
  
  func startSentry() {
    SentrySDK.start { options in
      options.dsn = "your sentry dsn"

      // Example uniform sample rate: capture 100% of transactions
      // In Production you will probably want a smaller number such as 0.5 for 50%
      options.sampleRate = 0.2
    }
  }
  
  func _handlerMainChannel(call:FlutterMethodCall,result:@escaping FlutterResult) {
      if (call.method == "appReview") {
        appReview();
      } else if (call.method == "quickAppReview") {
        quickAppReview();
      } else if (call.method == "requestIDFA") {
        requestIDFA(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
  }
  
  func appReview() {
    let appReviewUrl = URL.init(string:"your appReview URL")
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(appReviewUrl!, options: [:], completionHandler: nil)
    } else {
      UIApplication.shared.openURL(appReviewUrl!)
    }
  }
  
  func quickAppReview() {
    if #available(iOS 10.3, *) {
      SKStoreReviewController.requestReview()
    } else {
      // Fallback on earlier versions
    }
  }
  
  func requestIDFA(result: @escaping FlutterResult) {
     if #available(iOS 14, *) {
       ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
         result(status.rawValue)
       })
     } else {
       result(-1)
     }
  }
  
  override func applicationDidEnterBackground(_ application: UIApplication) {
    mainChannel?.invokeMethod("ios_pause", arguments: nil)
    
    //如果已存在后台任务，先将其设为完成
    if self.backgroundTask != nil {
      application.endBackgroundTask(self.backgroundTask)
      self.backgroundTask = UIBackgroundTaskIdentifier.invalid
    }

    self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
      () -> Void in
      //如果没有调用endBackgroundTask，时间耗尽时应用程序将被终止
      application.endBackgroundTask(self.backgroundTask)
      self.backgroundTask = UIBackgroundTaskIdentifier.invalid
    })

  }

  override func applicationWillEnterForeground(_ application: UIApplication) {
    application.endBackgroundTask(self.backgroundTask)
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    mainChannel?.invokeMethod("ios_resume", arguments: nil)
  }
}
