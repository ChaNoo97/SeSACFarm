//
//  SignUpView.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2021/12/31.
//

import UIKit
import SnapKit

class SignUpView: UIView, ViewProtocol {
	
	let emailTextField = UITextField()
	let userNameTextField = UITextField()
	let passwordTextField = UITextField()
	let checkPasswordTextField = UITextField()
	let button = MainButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setUpConstranits()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func configure() {
		let placeholderText = ["이메일 주소", "닉네임", "비밀번호", "비밀번호 확인"]
		
		[emailTextField, userNameTextField, passwordTextField, checkPasswordTextField].forEach {
			$0.borderStyle = .roundedRect
		}
		
		emailTextField.placeholder = placeholderText[0]
		userNameTextField.placeholder = placeholderText[1]
		passwordTextField.placeholder = placeholderText[2]
		checkPasswordTextField.placeholder = placeholderText[3]
		
		button.backgroundColor = .green
		button.setTitle("가입하기", for: .normal)
	}
	
	func setUpConstranits() {
		[emailTextField, userNameTextField, passwordTextField, checkPasswordTextField, button].forEach {
			addSubview($0)
		}
		
		emailTextField.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
			$0.height.equalTo(50)
		}
		
		userNameTextField.snp.makeConstraints {
			$0.top.equalTo(emailTextField.snp.bottom).offset(10)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
			$0.height.equalTo(50)
		}
		
		passwordTextField.snp.makeConstraints {
			$0.top.equalTo(userNameTextField.snp.bottom).offset(10)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
			$0.height.equalTo(50)
		}
		
		checkPasswordTextField.snp.makeConstraints {
			$0.top.equalTo(passwordTextField.snp.bottom).offset(10)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
			$0.height.equalTo(50)
		}
		
		button.snp.makeConstraints {
			$0.top.equalTo(checkPasswordTextField.snp.bottom).offset(10)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
			$0.height.equalTo(50)
		}
		
		
	}
	
}
