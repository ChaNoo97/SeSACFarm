//
//  SignInView.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/01.
//

import UIKit
import SnapKit

class SignInView:UIView, ViewProtocol {
	let emailTextField = UITextField()
	let userNameTextField = UITextField()
	let passwordTextField = UITextField()
	let button = MainButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setUpConstranits()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
		setUpConstranits()
	}
	
	func configure() {
		[emailTextField, userNameTextField, passwordTextField].forEach {
			$0.borderStyle = .roundedRect
		}
		
		emailTextField.placeholder = "이메일 주소"
		userNameTextField.placeholder = "닉네임"
		passwordTextField.placeholder = "비밀번호"
		
		button.backgroundColor = .green
		button.setTitle("시작하기", for: .normal)
	}
	
	func setUpConstranits() {
		[emailTextField, userNameTextField, passwordTextField, button].forEach {
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
		
		button.snp.makeConstraints {
			$0.top.equalTo(passwordTextField.snp.bottom).offset(10)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
			$0.height.equalTo(50)
		}
	}
	
	
}
