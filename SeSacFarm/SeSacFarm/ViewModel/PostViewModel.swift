//
//  PostViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

import Foundation

class PostViewModel {
	
	var id: Int?
	var userId: Int?
	var name = ""
	var date = ""
	var comments = Observable(BoardComments())
	var writeComments: Observable<String> = Observable("")
	var post = Observable("")
	
	func commentsGet(completion: @escaping() -> Void) {
		guard let id = id else {
			return
		}
		APIService.fetchCommetns(postId: id) { boardComments, error in
			guard let boardComments = boardComments else {
				return
			}
			self.comments.value = boardComments
			
			completion()
		}
	}
	
	func writeComment(completion: @escaping() -> Void) {
		var comment = ""
		writeComments.bind { value in
			comment = value
		}
		APIService.writeComment(text: writeComments.value, postID: self.id!) { comment, error in
			guard let comment = comment else {
				return
			}
			completion()
		}
	}
	
	func dateFormat(_ updateAt: String) -> String {
		let dateFormatter = DateFormatter()
		let splitDate = String(updateAt.split(separator: "T")[0])
		dateFormatter.dateFormat = "yyyy-MM-dd"
		guard let convertDate = dateFormatter.date(from: splitDate) else {
			return updateAt
		}
		dateFormatter.dateFormat = "MM/dd"
		let convertStr = dateFormatter.string(from: convertDate)
		return convertStr
	}
	
	func deleteComment(commentId: Int, completion: @escaping () -> Void) {
		APIService.deleteComment(commentId: commentId) { comment, error in
			guard let comment = comment else {
				return
			}
			completion()
		}
	}
	
	func deletePost(postId: Int, completion: @escaping () -> Void) {
		APIService.deletePost(postId: postId) { board, error in
			guard let board = board else {
				return
			}
			completion()
		}
	}
	
	func featchPost(completion: @escaping () -> Void) {
		guard let id = id else {
			return
		}
		APIService.fetchPost(postId: id) { board, error in
			guard let board = board else {
				return
			}
			self.userId = board.user.id
			self.post.value = board.text
			completion()
		}
	}
	
}

extension PostViewModel: TableViewCellRepresentable {
	var numberOfSection: Int {
		return 2
	}
	
	var numberOfRowsInSection: Int {
		return 1
	}
	
	
	
}
