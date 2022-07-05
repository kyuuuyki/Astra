//
//  AppDelegate.swift
//  Astra
//

import AstraCoreAPI
import AVKit
import IQKeyboardManagerSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		IQKeyboardManager.shared.enable = true
		
		do {
			let audioSession = AVAudioSession.sharedInstance()
			try audioSession.setCategory(.playback, mode: .moviePlayback)
		} catch {
			print("Audio session failed")
		}
		
		let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") ?? ""
		AstraCoreAPI.coreAPI().configure(environment: .production, googleServiceInfo: plistPath)
		AstraCoreAPI.coreAPI().application(
			application,
			didFinishLaunchingWithOptions: launchOptions
		)
		
		return true
	}
	
	// MARK: UISceneSession Lifecycle
	
	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		return UISceneConfiguration(
			name: "Default Configuration",
			sessionRole: connectingSceneSession.role
		)
	}
	
	func application(
		_ application: UIApplication,
		didDiscardSceneSessions
		sceneSessions: Set<UISceneSession>
	) {
	}
	
	func application(
		_ app: UIApplication,
		open url: URL,
		options: [UIApplication.OpenURLOptionsKey: Any] = [:]
	) -> Bool {
		return AstraCoreAPI.coreAPI().application(app, open: url, options: options)
	}
}
