//
//  SignUpViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2021/12/31.
//

import UIKit
import SnapKit

class SignUpViewController: BaseViewController {
	
	let mainView = SignUpView()
	var viewModel = SignUpViewModel()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "새싹농장 가입하기"
		navigationController?.navigationBar.tintColor = .black
		mainView.button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
		
		mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
		mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
		mainView.userNameTextField.addTarget(self, action: #selector(nickNameTextFieldDidChange(_:)), for: .editingChanged)
		mainView.checkPasswordTextField.addTarget(self, action: #selector(checkPasswordTextField(_:)), for: .editingChanged)
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
	@objc func checkPasswordTextField(_ textfield: UITextField) {
		if textfield.text == viewModel.password.value {
			textfield.textColor = .green
		} else {
			textfield.textColor = .red
		}
	}
	
	override func configure() {
		super.configure()
	}
	
	@objc func signUpButtonClicked() {
		print(#function)
		print(viewModel.email.value)
		
		viewModel.postUserSignUp {
			let alert = UIAlertController(title: "회원가입", message: "가입되었습니다.", preferredStyle: .alert)
			
			let allow = UIAlertAction(title: "allow", style: .default) { action in
				self.navigationController?.popViewController(animated: true)
			}
			alert.addAction(allow)
			self.present(alert, animated: true, completion: nil)
		}
	}
	
}
