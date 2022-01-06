//
//  EdtingPostViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/05.
//

import UIKit
import SnapKit

class EdtingPostViewController: BaseViewController {
	
	let mainView = EdtingView()
	let viewModel = EdtingViewModel()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
		navigationController?.navigationBar.tintColor = .black
		navigationItem.title = "새싹농장 글쓰기"
		viewModel.userText.bind { value in
			self.mainView.textView.text = value
		}
		
	}
	
	@objc func saveButtonClicked() {
		viewModel.userText.value = self.mainView.textView.text
		viewModel.userTextPost {
			let alert = UIAlertController(title: "완료", message: "작성되었습니다.", preferredStyle: .alert)
			
			let destructive = UIAlertAction(title: "allow", style: .default) { action in
				self.navigationController?.popViewController(animated: true)
			}
			alert.addAction(destructive)
			self.present(alert, animated: true, completion: nil)

		}
	}
	
}
 
