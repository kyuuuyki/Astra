//
//  ViewController.swift
//  Astra
//

import AstraAuthentication
import AstraCoreModels
import AstraMediaLibrary
import KyuGenericExtensions
import UIKit

struct ViewControllerSceneModule: SceneModuleProtocol {
	static var moduleName: String = "Main.ViewController"
	var nibName = String(describing: ViewController.self)
	var bundle: Bundle? = .main
	
	let transitionCoordinator: TransitionCoordinatorProtocol
	let authenticationService: AuthenticationServiceProtocol
	let userService: UserServiceProtocol
	
	init(
		transitionCoordinator: TransitionCoordinatorProtocol,
		authenticationService: AuthenticationServiceProtocol,
		userService: UserServiceProtocol
	) {
		self.transitionCoordinator = transitionCoordinator
		self.authenticationService = authenticationService
		self.userService = userService
	}
	
	func build(with parameters: [String: Any]?) -> UIViewController? {
		let viewController = ViewController(
			nibName: nibName,
			bundle: bundle
		)
		
		viewController.mainTransitionCoordinator = transitionCoordinator
		viewController.authenticationService = authenticationService
		viewController.userService = userService
		return viewController
	}
}

class ViewController: UIViewController {
	var mainTransitionCoordinator: TransitionCoordinatorProtocol!
	var authenticationService: AuthenticationServiceProtocol!
	var userService: UserServiceProtocol!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		displaySignInViewIfNeeded()
	}
	
	func displaySignInViewIfNeeded() {
		authenticationService.getSessionStatus { [weak self] status in
			guard let self = self else { return }
			
			switch status {
			case .signedIn(let user):
				self.displaySignUpViewIfNeeded(user: user)
			case .signedOut:
				self.navigateToSignIn()
			}
		}
	}
	
	func displaySignUpViewIfNeeded(user: UserProtocol) {
		userService.getUserSecret(by: user.id) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success:
				self.navigateToMain()
			case .failure:
				self.navigateToSignUp()
			}
		}
	}
	
	func navigateToSignIn() {
		mainTransitionCoordinator.performNavigation(
			NavigationType.presentAndPush(
				sceneName: SignInSceneModule.moduleName,
				parameters: nil
			),
			animated: true,
			completion: nil
		)
	}
	
	func navigateToSignUp() {
		mainTransitionCoordinator.performNavigation(
			NavigationType.presentAndPush(
				sceneName: SignUpSceneModule.moduleName,
				parameters: nil
			),
			animated: true,
			completion: nil
		)
	}
	
	func navigateToMain() {
		mainTransitionCoordinator.performNavigation(
			NavigationType.presentAndPush(
				sceneName: MainSceneModule.moduleName,
				parameters: nil
			),
			animated: true,
			completion: nil
		)
	}
}
