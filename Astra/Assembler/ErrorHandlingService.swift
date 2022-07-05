//
//  ErrorHandlingService.swift
//  Astra
//

import AstraCoreAPI
import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct ErrorHandlingService: ErrorHandlingServiceProtocol {
	static var moduleName: String = "Client.ErrorHandlingService"
	
	func handleError(error: Error?, completion: (() -> Void)?) {
		guard let presentingViewController = UIApplication.topViewController() else {
			completion?()
			return
		}
		
		if let alertController = presentingViewController as? UIAlertController {
			alertController.dismiss(animated: true) {
				handleError(error: error, completion: completion)
			}
			return
		}
		
		var title: String?
		var message: String?
		
		if let error = error as? AuthenticationService.RegisterError {
			switch error {
			case .dataGovAPIKeyInvalid:
				message = "Your specified API key is invalid. Please recheck it and try again."
			}
		}
		
		presentingViewController.displayAlertWithErrorStyle(title: title, message: message) {
			completion?()
		}
	}
}
