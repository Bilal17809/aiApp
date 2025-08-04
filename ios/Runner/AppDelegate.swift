// import Flutter
// import UIKit
// import Firebase
//
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//
//     // Initialize Firebase
//     FirebaseApp.configure()
//
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
import Flutter
import UIKit
import Firebase
import OneSignalFramework


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    OneSignal.initialize("5b57822f-9f90-487c-81d7-817f512d0a6f")
    // Initialize Firebase
     FirebaseApp.configure()
    // Register plugins
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}