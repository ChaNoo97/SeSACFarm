//
//  SignInViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/02.
//

import Foundation


class SignInViewModel {
	
	let email: Observable<String> = Observable("")
	let userName: Observable<String> = Observable("")
	let password: Observable<String> = Observable("")
	
	func postUserLogin(completion: @escaping (Bool) -> Void) {
		APIService.logIn(identifier: email.value, password: password.value) { userData, error in
			guard let userData = userData else {
				completion(false)
				return
			}
			UserDefaults.standard.set(userData.jwt, forKey: "jwt")
			UserDefaults.standard.set(userData.user.username, forKey: "loginUserName")
			UserDefaults.standard.set(userData.user.email, forKey: "loginUserEmail")
			UserDefaults.standard.set(userData.user.id, forKey: "UserId")
			completion(true)
		}
	}
	
	func fetchUserInfo() {
		email.value = UserDefaults.standard.string(forKey: "userEmail") ?? ""
		userName.value = UserDefaults.standard.string(forKey: "userName") ?? ""
	}
	
	
}
