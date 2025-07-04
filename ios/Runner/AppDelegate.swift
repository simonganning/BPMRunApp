import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
/*
class AppDelegate: UIResponder, UIApplicationDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
   
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate{
}

func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
  print("connected")
}
func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
  print("disconnected")
}
func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
  print("failed")
}
func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
  print("player state changed")
}

lazy var appRemote: SPTAppRemote = {
  let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
  appRemote.connectionParameters.accessToken = self.accessToken
  appRemote.delegate = self


  return appRemote
}()

func connect() {
self.playURI = "spotify:track:20I6sIOMTCkB6w7ryavxtO"
  self.appRemote.authorizeAndPlayURI(self.playURI)
}

func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
  // Connection was successful, you can begin issuing commands
  self.appRemote.playerAPI?.delegate = self
  self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
    if let error = error {
      debugPrint(error.localizedDescription)
    }
  })
}
func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
  debugPrint("Track name: %@", playerState.track.name)
}

func applicationWillResignActive(_ application: UIApplication) {
  if self.appRemote.isConnected {
    self.appRemote.disconnect()
  }
}

func applicationDidBecomeActive(_ application: UIApplication) {
  if let _ = self.appRemote.connectionParameters.accessToken {
    self.appRemote.connect()
  }
}

*/
