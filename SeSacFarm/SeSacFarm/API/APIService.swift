//
//  APIService.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/02.
//

import Foundation

class APIService {
	
	static func signUP(userName: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.signUp.url)
		request.httpMethod = Methood.POST.rawValue
		request.httpBody = "username=\(userName)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static  func logIn(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.logIn.url)
		request.httpMethod = Methood.POST.rawValue
		request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
		URLSession.request(endpoint: request, completion: completion)
	}
}
