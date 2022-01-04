//
//  APIService.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/02.
//

import Foundation

class APIService {
	
	static func signUP(userName: String, email: String, password: String, completion: @escaping (UserInfo?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.signUp.url)
		request.httpMethod = Methood.POST.rawValue
		request.httpBody = "username=\(userName)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func logIn(identifier: String, password: String, completion: @escaping (UserInfo?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.logIn.url)
		request.httpMethod = Methood.POST.rawValue
		request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func fetchPosts(completion: @escaping (Boards?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.posts.url)
		request.httpMethod = Methood.GET.rawValue
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
			return
		}
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func fetchCommetns(postId: Int, completion: @escaping (BoardComments?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.comments(id: postId).url)
		request.httpMethod = Methood.GET.rawValue
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
			return
		}
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
//	static func writePost(completion: @escaping (Posts?, APIError?) -> Void) {
//		var request = URLRequest(url: Endpoint.posts.url)
//		request.httpMethod = Methood.GET.rawValue
//		//request.httpBody =
//		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
//			return
//		}
//		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
//		URLSession.request(endpoint: request, completion: completion)
//	}
}
