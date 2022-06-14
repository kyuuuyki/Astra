//
//  Assembler.swift
//  Astra
//

import AstraAuthentication
import AstraCoreAPI
import AstraCoreModels
import AstraMediaLibrary
import Foundation
import KyuGenericExtensions
import SideMenu
import UIKit

public final class Assembler: AssemblerProtocol {
	// MARK: Public
	public static func assembler() -> AssemblerProtocol {
		return self.shared
	}
	
	public let container: ContainerProtocol = Container()
	
	// MARK: Private
	private init() {}
	private static let shared = Assembler()
	private var rootViewController: UIViewController?
}

public extension Assembler {
	func configure(window: UIWindow?) {
		// MARK: Services
		configureServices()
		
		// MARK: Scenes
		configureAuthentication()
		configureMediaLibrary()
		
		// MARK: Set RootViewController
		configureRootViewController(window: window)
	}
	
	func configureServices() {
		let transitionCoordinator = TransitionCoordinator()
		container.register(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) { _ in
			return transitionCoordinator
		}
		
		let authenticationService = AstraCoreAPI.coreAPI().authenticationService()
		container.register(AuthenticationServiceProtocol.self) { _ in
			return authenticationService
		}
		
		let mediaLibraryService = AstraCoreAPI.coreAPI().mediaLibraryService()
		container.register(MediaLibraryServiceProtocol.self) { _ in
			return mediaLibraryService
		}
	}
}

private extension Assembler {
	func configureRootViewController(window: UIWindow?) {
		let startSceneModule = resolver.resolve(
			SceneModuleProtocol.self,
			name: MainSceneModule.moduleName
		)
		
		guard let startViewController = startSceneModule?.build(with: nil) else { return }
		let navigationController = UINavigationController(rootViewController: startViewController)
		
		window?.rootViewController = navigationController
		rootViewController = navigationController
	}
}
