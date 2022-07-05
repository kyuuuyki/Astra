//
//  Assembler+Authentication.swift
//  Astra
//

//  swiftlint:disable fatal_error_message

import AstraAuthentication
import AstraCoreAPI
import AstraCoreModels
import Foundation
import KyuGenericExtensions

extension Assembler {
	func configureAuthentication() {
		// MARK: Resolving
		guard let transitionCoordinator = resolver.resolve(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) else {
			fatalError()
		}
		
		guard let errorHandlingService = resolver.resolve(
			ErrorHandlingServiceProtocol.self,
			name: ErrorHandlingService.moduleName
		) else {
			fatalError()
		}
		
		guard let authenticationService = resolver.resolve(
			AuthenticationServiceProtocol.self,
			name: AuthenticationService.moduleName
		) else {
			fatalError()
		}
		
		guard let userService = resolver.resolve(
			UserServiceProtocol.self,
			name: UserService.moduleName
		) else {
			fatalError()
		}
		
		// MARK: Registration
		container.register(
			SceneModuleProtocol.self,
			name: SignUpSceneModule.moduleName
		) { _ in
			return SignUpSceneModule(
				transitionCoordinator: transitionCoordinator,
				errorHandlingService: errorHandlingService,
				authenticationService: authenticationService
			)
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: SignInSceneModule.moduleName
		) { _ in
			return SignInSceneModule(
				transitionCoordinator: transitionCoordinator,
				authenticationService: authenticationService,
				userService: userService
			)
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: SignOutSceneModule.moduleName
		) { _ in
			return SignOutSceneModule(
				transitionCoordinator: transitionCoordinator,
				authenticationService: authenticationService
			)
		}
	}
}
