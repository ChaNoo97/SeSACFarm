//
//  Comments.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let boardComment = try? newJSONDecoder().decode(BoardComment.self, from: jsonData)

import Foundation

// MARK: - BoardCommentElement
struct BoardComment: Codable {
	let id: Int
	let comment: String
	let user: User
	let post: Post
	let createdAt, updatedAt: String

	enum CodingKeys: String, CodingKey {
		case id, comment, user, post
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

// MARK: - Post
struct Post: Codable {
	let id: Int
	let text: String
	let user: Int
	let createdAt, updatedAt: String

	enum CodingKeys: String, CodingKey {
		case id, text, user
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

typealias BoardComments = [BoardComment]


