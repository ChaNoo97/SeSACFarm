//
//  PostViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

import UIKit
import SnapKit

class PostViewController: BaseViewController {
	
	let mainView = PostView()
	let viewModel = PostViewModel()
	
	override func loadView() {
		print("postviewcon",#function)
		self.view = mainView
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.commentsGet {
			self.viewModel.featchPost { [self] in
				if viewModel.userId == Int(UserDefaults.standard.string(forKey: "UserId")!) {
					navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(modifyPostClicked))
						}
				self.mainView.tableView.reloadData()
			}
		}
		viewModel.commentsGet {
			self.mainView.tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mainView.textView.delegate = self
		mainView.tableView.delegate = self
		mainView.tableView.dataSource = self
		
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
		mainView.tableView.addGestureRecognizer(tap)
		mainView.sendButton.isHidden = true
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow),name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		mainView.sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
		
	}
	
	@objc func modifyPostClicked() {
		dismissKeyboard()
		let alert = UIAlertController(title: "게시글 수정/삭제", message: "선택해주세요", preferredStyle: .actionSheet)
		
		let modify = UIAlertAction(title: "수정", style: .default) { action in
			let vc = ModifyPostViewController()
			vc.viewModel.postId = self.viewModel.id
			if self.viewModel.comments.value.count == 0 {
				self.viewModel.post.bind { value in
					vc.previousPost = value
				}
			} else {
				print(self.viewModel.comments.value[0].post.text)
				vc.previousPost = self.viewModel.comments.value[0].post.text
			}
			
			self.navigationController?.pushViewController(vc, animated: true)
		}
		let delete = UIAlertAction(title: "삭제", style: .destructive) { action in
			guard let id = self.viewModel.id else { return }
			self.viewModel.deletePost(postId: id) {
				let alert = UIAlertController(title: "삭제", message: "삭제되었습니다.", preferredStyle: .alert)
				let confirm = UIAlertAction(title: "확인", style: .default) { action in
					self.navigationController?.popViewController(animated: true)
				}
				alert.addAction(confirm)
				self.present(alert, animated: true, completion: nil)
			}
		}
		let cancle = UIAlertAction(title: "취소", style: .cancel)
		alert.addAction(modify)
		alert.addAction(delete)
		alert.addAction(cancle)
		present(alert, animated: true, completion: nil)
	}
	
	@objc func sendButtonClicked() {
		viewModel.writeComment {
			self.viewModel.commentsGet {
				self.mainView.tableView.reloadData()
			}
		}
		mainView.textView.text = ""
		viewModel.writeComments.value = ""
		mainView.sendButton.isHidden = true
	}
	
	@objc func dismissKeyboard() {
		self.view.endEditing(true)
	}
	
	@objc func keyboardShow(notification: NSNotification) {

		print(#function)
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			self.mainView.commentView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height+view.safeAreaInsets.bottom)
			self.mainView.footerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: keyboardSize.height+60)
			mainView.tableView.tableFooterView = mainView.footerView
			
		}
	}
	
	@objc func keyboardHide(notification: NSNotification) {
		print(#function)
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			self.mainView.commentView.transform = .identity
			self.mainView.footerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
			mainView.tableView.tableFooterView = mainView.footerView
			
		}
	}
}

//MARK: TableViewDelegate
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.numberOfSection
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else {
			return viewModel.comments.value.count
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell1 = tableView.dequeueReusableCell(withIdentifier: PostWriterCell.reuseIdentifier) as! PostWriterCell
		let cell2 = tableView.dequeueReusableCell(withIdentifier: PostCommentCell.reuseIdentifier) as! PostCommentCell
		
		if indexPath.section == 0 {
 			cell1.writerName.text = viewModel.name
			
			viewModel.post.bind { value in
				cell1.writerContent.text = value
			}
			cell1.writeDate.text = viewModel.dateFormat(viewModel.date)
			cell1.commentStatus.text = "댓글 \(viewModel.comments.value.count)"
			return cell1
			
		} else {
			let row = viewModel.comments.value[indexPath.row]
			cell2.commentUserName.text = row.user.username
			cell2.comment.text = row.comment
			cell2.settingButton.addTarget(self, action: #selector(settingButtonClicked(_:)), for: .touchUpInside)
			cell2.settingButton.tag = indexPath.row
			return cell2
		}
	}
	
	@objc func settingButtonClicked(_ sender: UIButton) {
		let alert = UIAlertController(title: "댓글수정", message: "선택해주세요", preferredStyle: .actionSheet)
		
		let checkStandard = UIAlertAction(title: "수정", style: .default) { action in
			let vc = CommentModifyViewController()
			vc.viewModel.commentId = self.viewModel.comments.value[sender.tag].id
			vc.viewModel.postId = self.viewModel.id
			self.navigationController?.pushViewController(vc, animated: true)
		}
		let favoriteStandard = UIAlertAction(title: "삭제", style: .destructive) { action in
		let id = self.viewModel.comments.value[sender.tag].id
			self.viewModel.deleteComment(commentId: id) {
			let alert = UIAlertController(title: "", message: "삭제되었습니다.", preferredStyle: .alert)
				
				let confirm = UIAlertAction(title: "확인", style: .default) { action in
					self.viewModel.commentsGet {
						self.mainView.tableView.reloadData()
					}
				}
				alert.addAction(confirm)
				
				self.present(alert, animated: true, completion: nil)
			}
		}
		alert.addAction(checkStandard)
		alert.addAction(favoriteStandard)

		present(alert, animated: true, completion: nil)
	}
	
}

//MARK: TextViewDelegate
extension PostViewController: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		print(textView.contentSize.height)
		print(#function)
		
		if textView.contentSize.height <= 40 {
			DispatchQueue.main.async {
				self.mainView.textView.snp.updateConstraints {
					$0.height.equalTo(40)
				}
			}
				} else if textView.contentSize.height >= 102 {
					DispatchQueue.main.async {
						self.mainView.textView.snp.updateConstraints {
							$0.height.equalTo(102)
						}
					}
				} else {
					let height = textView.contentSize.height
					self.mainView.textView.snp.updateConstraints {
						$0.height.equalTo(height)
					}
				}
		
		
		if textView.text == "" {
			self.mainView.sendButton.isHidden = true
		} else {
			self.mainView.sendButton.isHidden = false
			self.mainView.sendButton.tintColor = .green
		}
		viewModel.writeComments.value = textView.text ?? ""
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		
//		if textView.contentSize.height <= 35 {
//			self.mainView.textView.snp.updateConstraints {
//				$0.height.equalTo(35)
//			}
//		} else if textView.contentSize.height >= 102 {
//				self.mainView.textView.snp.updateConstraints {
//					$0.height.equalTo(102)
//				}
//		}
	}
	
}
