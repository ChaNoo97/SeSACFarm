//
//  MainViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/03.
//

import Foundation
import UIKit

class MainViewModel {
	
	var posts = Observable(Boards())
	var writer: Observable<String> = Observable("")
	
	func postsGet(completion: @escaping () -> Void) {
		APIService.fetchPosts { posts, error in
			guard let posts = posts else {
				UserDefaults.standard.removeObject(forKey: "jwt")
				guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
				windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: InitialViewController())
				windowScene.windows.first?.makeKeyAndVisible()
				return
			}
			self.posts.value = posts
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

extension MainViewModel: TableViewCellRepresentable {
	var numberOfSection: Int {
		return 1
	}
	
	var numberOfRowsInSection: Int {
		return posts.value.count
	}
	
	
	func cellForRowAt(_ tableview: UITableView, indexPath: IndexPath) -> Board {
		let row = indexPath.row
		return posts.value[row]
	}
}
