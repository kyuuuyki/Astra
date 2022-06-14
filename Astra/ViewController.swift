//
//  ViewController.swift
//  Astra
//

//  swiftlint:disable all

import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func didTapOnForceCrashButton(_ sender: Any) {
		fatalError("Crash was triggered")
	}
}
