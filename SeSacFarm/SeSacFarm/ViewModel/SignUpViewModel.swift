//
//  SignUpViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/02.
//

import Foundation

class SignUpViewModel {
	
	var userName: Observable<String> = Observable("name")
	var email: Observable<String> = Observable("email")
	var password: Observable<String> = Observable("password")
	
	func postUserSignUp(completion: @escaping () -> Void) {
		APIService.signUP(userName: userName.value, email: email.value, password: password.value) { userData, error in
			guard let userData = userData else {
				return
			}
			UserDefaults.standard.set(userData.user.email, forKey: "userEmail")
			UserDefaults.standard.set(userData.user.username, forKey: "userName")
			completion()
		}
	}
}
