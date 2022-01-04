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
	let textView = UITextView()
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
		tableView.register(PostWriterCell.self, forCellReuseIdentifier: PostWriterCell.reuseIdentifier)
		tableView.register(PostCommentCell.self, forCellReuseIdentifier: PostCommentCell.reuseIdentifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
	}
	
	func makeConstraints() {
		[tableView, textView].forEach {
			view.addSubview($0)
		}
		tableView.snp.makeConstraints {
			$0.edges.equalTo(view.safeAreaLayoutGuide)
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
			return cell2
		}
	}
	
	
}
