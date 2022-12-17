import UIKit
import Flutter
import GoogleMobileAds  /// add this line

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "jc_3fnjs5851x3fvkvdswxr80000gn" ]
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
