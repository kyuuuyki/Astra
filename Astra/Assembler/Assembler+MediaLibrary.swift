//
//  Assembler+MediaLibrary.swift
//  Astra
//

//  swiftlint:disable fatal_error_message

import AstraCoreAPI
import AstraCoreModels
import AstraMediaLibrary
import Foundation
import KyuGenericExtensions

extension Assembler {
	func configureMediaLibrary() {
		// MARK: Resolving
		guard let transitionCoordinator = resolver.resolve(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) else {
			fatalError()
		}
		
		guard let authenticationService = resolver.resolve(
			AuthenticationServiceProtocol.self,
			name: AuthenticationService.moduleName
		) else {
			fatalError()
		}
		
		guard let mediaLibraryService = resolver.resolve(
			MediaLibraryServiceProtocol.self,
			name: MediaLibraryService.moduleName
		) else {
			fatalError()
		}
		
		guard let userService = resolver.resolve(
			UserServiceProtocol.self,
			name: UserService.moduleName
		) else {
			fatalError()
		}
		
		// MARK: Registering
		container.register(
			SceneModuleProtocol.self,
			name: MainSceneModule.moduleName
		) { _ in
			return MainSceneModule(
				transitionCoordinator: transitionCoordinator,
				authenticationService: authenticationService,
				mediaLibraryService: mediaLibraryService,
				userService: userService
			)
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: MediaListSceneModule.moduleName
		) { _ in
			return MediaListSceneModule(
				transitionCoordinator: transitionCoordinator,
				mediaLibraryService: mediaLibraryService
			)
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: MediaDetailSceneModule.moduleName
		) { _ in
			return MediaDetailSceneModule(
				transitionCoordinator: transitionCoordinator,
				mediaLibraryService: mediaLibraryService
			)
		}
	}
}
