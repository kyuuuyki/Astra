//
//  Assembler+RootViewController.swift
//  Astra
//

//  swiftlint:disable fatal_error_message

import AstraCoreAPI
import AstraCoreModels
import AstraMediaLibrary
import Foundation
import KyuGenericExtensions
import UIKit

extension Assembler {
	func configureRootViewController(window: UIWindow?) {
		guard let mainSceneModule = resolver.resolve(
			SceneModuleProtocol.self,
			name: MainSceneModule.moduleName
		) else {
			fatalError()
		}
		
		guard let mainViewController = mainSceneModule.build(with: nil) else { return }
		let navigationController = UINavigationController(rootViewController: mainViewController)
		
		window?.rootViewController = navigationController
		rootViewController = navigationController
	}
}
