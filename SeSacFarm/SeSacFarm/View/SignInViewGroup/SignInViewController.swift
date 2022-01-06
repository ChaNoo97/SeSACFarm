//
//  SignInViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/01.
//

import UIKit
import SnapKit
import Toast

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
		self.view.endEditing(true)
		viewModel.postUserLogin { value in
			if value {
				guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
				windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
				windowScene.windows.first?.makeKeyAndVisible()
			} else {
				self.view.makeToast("아이디/비밀번호를 확인해 주세요.")
			}
		}
	}
}
