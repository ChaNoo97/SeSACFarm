//
//  CommentModifyViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/06.
//

import Foundation

class CommentModifyViewModel {
	
	var modifiedComment: String?
	
	//코멘트 아이디 변수
	var commentId: Int?
	var postId: Int?
	
	func modifyComment(completion: @escaping () -> Void) {
		guard let modifiedComment = modifiedComment else {
			return
		}
		guard let commentId = commentId else {
			return
		}
		guard let postId = postId else {
			return
		}
		//코멘트 아이디는 어디서 가져오나? 버튼 누르면 전달
		//포스트 아이디는 전 뷰의 뷰 모델에서 값전달.
		APIService.modifyComment(commentId: commentId, modifyComment: modifiedComment, postId: postId) { comment, Error in
			guard let comment = comment else {
				print("comment return")
				return
			}
			completion()
		}
	}
}
