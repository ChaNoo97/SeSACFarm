//
//  ModifyPostViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/06.
//

import UIKit
import SnapKit

class ModifyPostViewController: BaseViewController {
	
	let mainView = EdtingView()
	let viewModel = ModifyPostViewModel()
	
	var previousPost: String?
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mainView.textView.text = previousPost ?? "" 
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mainView.textView.delegate = self
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(modifyButtonClicked))
	}
	
	@objc func modifyButtonClicked() {
		if mainView.textView.text == "" {
			let alert = UIAlertController(title: "죄송합니다.", message: "빈값은 저장할수 없습니다.", preferredStyle: .alert)
			
			let destructive = UIAlertAction(title: "확인", style: .default) { action in
				
			}
			alert.addAction(destructive)
			present(alert, animated: true, completion: nil)
		}
		
		viewModel.modifyPost {
			let alert = UIAlertController(title: "수정", message: "수정되었습니다.", preferredStyle: .alert)
			let confirm = UIAlertAction(title: "확인", style: .default) { action in
				self.navigationController?.popViewController(animated: true)
			}
			alert.addAction(confirm)
			self.present(alert, animated: true, completion: nil)

		}
	}
	
}

extension ModifyPostViewController: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		viewModel.modifyPost = mainView.textView.text
	}
}
