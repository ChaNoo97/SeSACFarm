//
//  SignInViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/01.
//

import UIKit
import SnapKit

class SignInViewController: BaseViewController {
	
	let mainView = SignInView()
	var viewModel = SignInViewModel()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.fetchUserInfo()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "새싹농장 시작하기"
		
		viewModel.email.bind { text in
			self.mainView.emailTextField.text = text
		}
		viewModel.userName.bind { text in
			self.mainView.userNameTextField.text = text
		}
		
		mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
		mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
		mainView.userNameTextField.addTarget(self, action: #selector(nickNameTextFieldDidChange(_:)), for: .editingChanged)
		
		mainView.button.addTarget(self, action: #selector(logInButtonClicked), for: .touchUpInside)
	}
	
	@objc func emailTextFieldDidChange(_ textfield: UITextField) {
		viewModel.email.value = textfield.text ?? ""
	}
	@objc func passwordTextFieldDidChange(_ textfield: UITextField) {
		viewModel.password.value = textfield.text ?? ""
	}
	@objc func nickNameTextFieldDidChange(_ textfield: UITextField) {
		viewModel.userName.value = textfield.text ?? ""
	}
	
	@objc func logInButtonClicked() {
		viewModel.postUserLogin {
			print("뷰 전환")
		}
	}
	
}
