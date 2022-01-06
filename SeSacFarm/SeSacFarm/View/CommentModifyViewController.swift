//
//  CommentModifyController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/06.
//

import UIKit
import SnapKit

class CommentModifyViewController: BaseViewController {
	
	let mainView = EdtingView()
	let viewModel = CommentModifyViewModel()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.textView.delegate = self
		navigationItem.title = "댓글 수정"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정하기", style: .plain, target: self, action: #selector(modifyButtonClicked))
	}
	
	@objc func modifyButtonClicked() {
		viewModel.modifyComment {
			let alert = UIAlertController(title: "댓글수정", message: "수정되었습니다.", preferredStyle: .alert)
			
			let confirm = UIAlertAction(title: "확인", style: .default) { action in
				self.navigationController?.popViewController(animated: true)
			}
			alert.addAction(confirm)
			
			self.present(alert, animated: true, completion: nil)

		}
	}
}

extension CommentModifyViewController: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		viewModel.modifiedComment = textView.text
		print(viewModel.modifiedComment)
	}
}
