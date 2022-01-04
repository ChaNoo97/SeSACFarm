//
//  Posts.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/03.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let posts = try? newJSONDecoder().decode(Posts.self, from: jsonData)

import Foundation

// MARK: - Post
struct Board: Codable {
	let id: Int
	let text: String
	let user: User
	let createdAt, updatedAt: String
	let comments: [Comment]

	enum CodingKeys: String, CodingKey {
		case id, text, user
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case comments
	}
}

// MARK: - Comment
struct Comment: Codable {
	let id: Int
	let comment: String
	let user, post: Int
	let createdAt, updatedAt: String

	enum CodingKeys: String, CodingKey {
		case id, comment, user, post
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

// MARK: - User
struct User: Codable {
	let id: Int
	let username, email: String
	let provider: Provider
	let confirmed: Bool
	let role: Int
	let createdAt, updatedAt: String

	enum CodingKeys: String, CodingKey {
		case id, username, email, provider, confirmed, role
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

enum Provider: String, Codable {
	case local = "local"
}

typealias Boards = [Board]

