//
//  EdtingViewModel.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/05.
//

import Foundation

class EdtingViewModel {
	let userText: Observable<String> = Observable("")
	
	func userTextPost(completion: @escaping () -> Void) {
		APIService.writePost(text: userText.value) { board, error in
			guard let board = board else {
				return
			}
			completion()
		}
	}
}
