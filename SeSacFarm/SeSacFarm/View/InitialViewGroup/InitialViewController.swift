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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if UserDefaults.standard.string(forKey: "jwt") != nil {
			guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
			windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
			windowScene.windows.first?.makeKeyAndVisible()
		}
		
		
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
