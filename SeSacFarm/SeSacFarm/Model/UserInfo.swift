//
//  User.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/02.
//

import Foundation

// MARK: - User
struct UserInfo: Codable {
	let jwt: String
	let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
	let id: Int
	let username, email, provider: String
	let confirmed: Bool
}

