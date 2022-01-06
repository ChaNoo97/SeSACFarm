//
//  PostViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

import UIKit
import SnapKit

class PostViewController: BaseViewController {
	
	let tableView = UITableView()
	let bottomView = UIView()
	let designLine = UIView()
	let commentView = UIView()
	let textView = UITextView()
	let sendButton = UIButton()
	let viewModel = PostViewModel()
	let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 100))
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewModel.commentsGet {
			self.tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		makeConstraints()
		tableViewSetting()
		configure()
		
		textView.delegate = self
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(modifyPostClicked))
		
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
		self.tableView.addGestureRecognizer(tap)
		sendButton.isHidden = true
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
	}
	
	@objc func modifyPostClicked() {
		let alert = UIAlertController(title: "게시글 수정/삭제", message: "선택해주세요", preferredStyle: .actionSheet)
		
		let modify = UIAlertAction(title: "수정", style: .default) { action in
			let vc = ModifyPostViewController()
			vc.viewModel.postId = self.viewModel.id
			if self.viewModel.comments.value.count == 0 {
				print(self.viewModel.content)
				vc.previousPost = self.viewModel.content
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
				self.tableView.reloadData()
			}
		}
		textView.text = ""
		viewModel.writeComments.value = ""
		sendButton.isHidden = true
	}
	
	@objc func dismissKeyboard() {
		self.view.endEditing(true)
	}
	
	@objc func keyboardShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			if self.commentView.frame.origin.y == 0 {
				self.commentView.frame.origin.y -= keyboardSize.height-40
				self.footerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: keyboardSize.height+60)
				tableView.tableFooterView = footerView
			}
		}
	}
	
	@objc func keyboardHide(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			if self.commentView.frame.origin.y != 0 {
				self.commentView.frame.origin.y += keyboardSize.height-40
				self.footerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
				tableView.tableFooterView = footerView
			}
		}
	}
	
	func tableViewSetting() {
		tableView.tableFooterView = footerView
		tableView.register(PostWriterCell.self, forCellReuseIdentifier: PostWriterCell.reuseIdentifier)
		tableView.register(PostCommentCell.self, forCellReuseIdentifier: PostCommentCell.reuseIdentifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
	}
	
	override func configure() {
		super.configure()
		designLine.backgroundColor = .black
		sendButton.setImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
		sendButton.tintColor = .systemGray3
		textView.layer.cornerRadius = 3
		textView.font = .systemFont(ofSize: 18)
		
		bottomView.backgroundColor = .white
		textView.backgroundColor = .systemGray3
		
	}
	
	func makeConstraints() {
		[tableView, bottomView].forEach {
			view.addSubview($0)
		}
		bottomView.addSubview(commentView)
		
		[textView, sendButton, designLine].forEach {
			commentView.addSubview($0)
		}
	
		tableView.snp.makeConstraints {
			$0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
		}
		bottomView.snp.makeConstraints {
			$0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.equalTo(view)
			$0.height.equalTo(89)
		}
		designLine.snp.makeConstraints {
			$0.height.equalTo(1)
			$0.leading.trailing.top.equalTo(commentView)
		}
		commentView.snp.makeConstraints {
			$0.top.equalTo(bottomView.snp.top)
			$0.leading.trailing.equalTo(bottomView)
			$0.bottom.equalTo(view.snp.bottom).inset(40)
		}
		textView.snp.makeConstraints {
			$0.top.equalTo(commentView.snp.top).inset(5)
			$0.leading.equalTo(commentView).inset(15)
			$0.bottom.equalTo(commentView).inset(5)
			$0.trailing.equalTo(sendButton.snp.leading)
		}
		sendButton.snp.makeConstraints {
			$0.trailing.equalTo(commentView.snp.trailing).inset(15)
			$0.bottom.equalTo(commentView).inset(5)
			$0.width.equalTo(44)
			$0.height.equalTo(39)
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
			if viewModel.comments.value.count == 0 {
				cell1.writerContent.text = viewModel.content
				viewModel.featchPost {
					self.viewModel.post.bind { value in
						cell1.writerContent.text = value
					}
				}
			} else {
				cell1.writerContent.text = viewModel.comments.value[0].post.text
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
						self.tableView.reloadData()
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
		print(#function)
		if textView.text == "" {
			self.sendButton.isHidden = true
		} else {
			self.sendButton.isHidden = false
			self.sendButton.tintColor = .green
		}
		viewModel.writeComments.value = textView.text ?? ""
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		print(#function)
	}
	
}
