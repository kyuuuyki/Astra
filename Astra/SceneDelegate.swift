//
//  SceneDelegate.swift
//  Astra
//

import AstraCoreAPI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard scene as? UIWindowScene != nil else { return }
		Assembler.assembler().configure(window: window)
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
	}
	
	func sceneDidBecomeActive(_ scene: UIScene) {
	}
	
	func sceneWillResignActive(_ scene: UIScene) {
	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
	}
	
	func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
		AstraCoreAPI.coreAPI().scene(scene, openURLContexts: URLContexts)
	}
}
