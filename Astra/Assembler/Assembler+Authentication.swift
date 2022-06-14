//
//  Assembler+Authentication.swift
//  Astra
//

import AstraAuthentication
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
			return
		}
		
		guard let authenticationService = resolver.resolve(
			AuthenticationServiceProtocol.self
		) else {
			return
		}
		
		// MARK: Registering
		container.register(
			SceneModuleProtocol.self,
			name: SignUpSceneModule.moduleName
		) { _ in
			return SignUpSceneModule(
				transitionCoordinator: transitionCoordinator
			)
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: SignInSceneModule.moduleName
		) { _ in
			return SignInSceneModule(
				transitionCoordinator: transitionCoordinator,
				authenticationService: authenticationService
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
