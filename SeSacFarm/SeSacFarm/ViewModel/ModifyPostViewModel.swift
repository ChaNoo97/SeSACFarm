//
//  ModifyPostViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/06.
//

import Foundation

class ModifyPostViewModel {
	
	var postId: Int?
	var modifyPost: String?
	
	func modifyPost(completion: @escaping() -> Void) {
		guard let postId = postId else { return }
		guard let modifyPost = modifyPost else { return }
		APIService.modifyPost(postId: postId, modifyPost: modifyPost) { board, error in
			guard let board = board else {
				print(#function,"ERROR")
				return
			}
			completion()
		}
	}
}
