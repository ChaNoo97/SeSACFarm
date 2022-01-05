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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.commentsGet {
			self.tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		makeConstraints()
		let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width , height: 100))
		footerView.backgroundColor = .black
		tableView.tableFooterView = footerView
		tableView.register(PostWriterCell.self, forCellReuseIdentifier: PostWriterCell.reuseIdentifier)
		tableView.register(PostCommentCell.self, forCellReuseIdentifier: PostCommentCell.reuseIdentifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		
		designLine.backgroundColor = .black
		textView.backgroundColor = .lightGray
		textView.layer.cornerRadius = 3
		sendButton.backgroundColor = .red
	}
	
	func makeConstraints() {
		[tableView, bottomView].forEach {
			view.addSubview($0)
		}
		[commentView, designLine, textView].forEach {
			bottomView.addSubview($0)
		}
		textView.addSubview(sendButton)
	
		tableView.snp.makeConstraints {
			$0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
		}
		bottomView.snp.makeConstraints {
			$0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
			$0.height.equalTo(50)
		}
		designLine.snp.makeConstraints {
			$0.height.equalTo(1)
			$0.leading.trailing.top.equalTo(bottomView)
		}
		textView.snp.makeConstraints {
			$0.top.equalTo(designLine.snp.bottom).offset(4)
			$0.leading.trailing.equalTo(bottomView).inset(10)
			$0.bottom.equalTo(bottomView.snp.bottom).offset(4)
		}
		sendButton.snp.makeConstraints {
			$0.top.bottom.trailing.equalTo(textView).inset(5)
			$0.width.equalTo(sendButton.snp.height)
		}
	}
	
	
}

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
			} else {
				cell1.writerContent.text = viewModel.comments.value[0].post.text
			}
			cell1.writeDate.text = viewModel.dateFormat(viewModel.date)
			cell1.commentStatus.text = "댓글 \(viewModel.comments.value.count)"
			return cell1
		} else {
			let row = indexPath.row
			cell2.commentUserName.text = viewModel.comments.value[row].user.username
			cell2.comment.text = viewModel.comments.value[row].comment
			cell2.settingButton.addTarget(self, action: #selector(settingButtonClicked), for: .touchUpInside)
			return cell2
		}
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if section == 1 {
			return 50
		} else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
		view.backgroundColor = .black
	}
	
	@objc func settingButtonClicked() {
		print(#function)
	}
	
	
}
