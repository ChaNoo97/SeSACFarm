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
		var request = URLRequest(url: Endpoint.featchPosts.url)
		request.httpMethod = Methood.GET.rawValue
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
			return
		}
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func fetchCommetns(postId: Int, completion: @escaping (BoardComments?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.fetchComments(id: postId).url)
		request.httpMethod = Methood.GET.rawValue
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
			return
		}
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func writePost(text: String, completion: @escaping (Board?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.posts.url)
		request.httpMethod = Methood.POST.rawValue
		request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
			return
		}
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func writeComment(text: String, postID: Int,completion: @escaping (BoardComment?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.writeComment.url)
		request.httpMethod = Methood.POST.rawValue
		request.httpBody = "comment=\(text)&post=\(postID)".data(using: .utf8, allowLossyConversion: false)
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
			return
		}
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func modifyComment(commentId: Int, modifyComment: String, postId: Int, completion: @escaping (BoardComment?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.modifyComment(id: commentId).url)
		request.httpMethod = Methood.PUT.rawValue
		request.httpBody = "comment=\(modifyComment)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {
			return
		}
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func modifyPost(postId: Int, modifyPost: String, completion: @escaping (Board?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.modifyPost(id: postId).url)
		request.httpMethod = Methood.PUT.rawValue
		request.httpBody = "text=\(modifyPost)".data(using: .utf8, allowLossyConversion: false)
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else { return }
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func deleteComment(commentId: Int,completion: @escaping (BoardComment?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.deleteComment(id: commentId).url)
		request.httpMethod = Methood.DELETE.rawValue
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else { return }
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func deletePost(postId:Int, completion: @escaping (Board?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.deletePost(id: postId).url)
		request.httpMethod = Methood.DELETE.rawValue
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else { return }
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
	
	static func fetchPost(postId: Int, completion: @escaping (Board?, APIError?) -> Void) {
		var request = URLRequest(url: Endpoint.deletePost(id: postId).url)
		request.httpMethod = Methood.GET.rawValue
		guard let jwt = UserDefaults.standard.string(forKey: "jwt") else { return }
		request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
		URLSession.request(endpoint: request, completion: completion)
	}
}
