//
//  InitialViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2021/12/31.
//

import UIKit
import SnapKit

class InitialViewController: BaseViewController {
	let mainView = InitialView()
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.backButtonTitle = ""
		mainView.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		print(UserDefaults.standard.string(forKey: "userEmail") ?? "")
		setupLabelTap()
	}
	
	override func configure() {
		super.configure()
	}
	
	@objc func buttonClicked() {
		let vc = SignUpViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func labelTapped(_ sender: UITapGestureRecognizer) {
			let vc = SignInViewController()
		navigationController?.pushViewController(vc, animated: true)
		}
		
		func setupLabelTap() {
			let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
			self.mainView.label.isUserInteractionEnabled = true
			self.mainView.label.addGestureRecognizer(labelTap)
			
		}

	
	
}
