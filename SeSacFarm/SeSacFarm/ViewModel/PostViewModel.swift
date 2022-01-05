//
//  PostViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

import Foundation

class PostViewModel {
	
	var id: Int?
	var name = ""
	var content = ""
	var date = ""
	var comments = Observable(BoardComments())
	
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
	
}

extension PostViewModel: TableViewCellRepresentable {
	var numberOfSection: Int {
		return 2
	}
	
	var numberOfRowsInSection: Int {
		return 1
	}
	
	
	
}
