//
//  Assembler.swift
//  Astra
//

//  swiftlint:disable fatal_error_message

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
	var rootViewController: UIViewController?
}

public extension Assembler {
	func configure(window: UIWindow?) {
		configureServices()
		
		configureAuthentication()
		configureMediaLibrary()
		
		configureRootViewController(window: window)
		configureSideMenu()
	}
	
	func configureServices() {
		container.register(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) { _ in
			return TransitionCoordinator()
		}
		
		container.register(
			ErrorHandlingServiceProtocol.self,
			name: ErrorHandlingService.moduleName
		) { _ in
			return ErrorHandlingService()
		}
		
		container.register(
			AuthenticationServiceProtocol.self,
			name: AuthenticationService.moduleName
		) { _ in
			return AuthenticationService()
		}
		
		container.register(
			MediaLibraryServiceProtocol.self,
			name: MediaLibraryService.moduleName
		) { _ in
			let apiKey = AstraCoreAPI.coreAPI().userSecret?.dataGovAPIKey ?? "DEMO_KEY"
			return MediaLibraryService(apiKey: apiKey)
		}
		
		container.register(
			UserServiceProtocol.self,
			name: UserService.moduleName
		) { _ in
			return UserService()
		}
	}
}

private extension Assembler {
	func configureSideMenu() {
		guard let signOutSceneModule = resolver.resolve(
			SceneModuleProtocol.self,
			name: SignOutSceneModule.moduleName
		) else {
			fatalError()
		}
		
		guard let signOutViewController = signOutSceneModule.build(with: nil) else { return }
		let sideMenuNavigationController = SideMenuNavigationController(
			rootViewController: signOutViewController
		)
		sideMenuNavigationController.menuWidth = UIScreen.main.bounds.width * 4 / 5
		sideMenuNavigationController.presentationStyle = .viewSlideOutMenuIn
	}
}
