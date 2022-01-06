//
//  Endpoint.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/01.
//

import Foundation

enum APIError: Error {
	case invalidResponse
	case noData
	case failed
	case invalidData
}

enum Methood: String {
	case GET
	case POST
	case PUT
	case DELETE
}

enum Endpoint {
	case signUp
	case logIn
	case posts
	case fetchComments(id: Int)
	case writeComment
	case modifyComment(id: Int)
	case modifyPost(id: Int)
}

extension Endpoint {
	var url: URL {
		switch self {
		case .signUp:
			return .makeEndPoint("/auth/local/register")
		case .logIn:
			return .makeEndPoint("/auth/local")
		case .posts:
			return .makeEndPoint("/posts")
		case .fetchComments(id: let id):
			return .makeEndPoint("/comments?post=\(id)")
		case .writeComment:
			return .makeEndPoint("/comments")
		case .modifyComment(id: let id):
			return .makeEndPoint("/comments/\(id)")
		case .modifyPost(id: let id):
			return .makeEndPoint("/posts/\(id)")
		}
	}
}

extension URL {
	static let baseURL = "http://test.monocoding.com:1231"
	
	static func makeEndPoint(_ endpoint: String) -> URL {
		URL(string: baseURL + endpoint)!
	}
}

extension URLSession {
	
	typealias Handler = (Data?, URLResponse?, Error?) -> Void
	
	@discardableResult
	func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
		let task = dataTask(with: endpoint, completionHandler: handler)
		task.resume()
		return task
	}
	
	static func request<T: Decodable> (_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
		session.dataTask(endpoint) { data, response, error in
			DispatchQueue.main.async {
				print("Data", data)
				print("response", response)
				print("error",error)
				guard error == nil else {
					completion(nil, .failed)
					return
				}
				
				guard let data = data else {
					completion(nil, .noData)
					return
				}
				
				guard let response = response as? HTTPURLResponse else {
					completion(nil, .invalidData)
					return
				}
				
				guard response.statusCode == 200 else {
					completion(nil, .failed)
					return
				}
				
				do {
					let decoder = JSONDecoder()
					let userData = try decoder.decode(T.self, from: data)
					completion(userData, nil)
				} catch {
					completion(nil, .invalidData)
				}
			}
		}
	}
}
