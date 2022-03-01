//
//  PostView.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/08.
//

import UIKit
import SnapKit

class PostView: UIView, ViewProtocol {
	
	let tableView = UITableView()
	let designLine = UIView()
	let commentView = UIView()
	let textView = UITextView()
	let sendButton = UIButton()
	let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 100))
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setUpConstranits()
		tableViewSetting()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		print("PostView"+#function+"Error")
	}
	
	func tableViewSetting() {
		tableView.tableFooterView = footerView
		tableView.register(PostWriterCell.self, forCellReuseIdentifier: PostWriterCell.reuseIdentifier)
		tableView.register(PostCommentCell.self, forCellReuseIdentifier: PostCommentCell.reuseIdentifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.separatorStyle = .none
	}
	
	func configure() {
		designLine.backgroundColor = .black
		sendButton.setImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
		sendButton.tintColor = .systemGray3
		textView.layer.cornerRadius = 3
		textView.font = .systemFont(ofSize: 18)
		commentView.backgroundColor = .white
		textView.backgroundColor = .systemGray3
	}
	
	func setUpConstranits() {
		[tableView, commentView].forEach {
			addSubview($0)
		}
		
		[textView, sendButton, designLine].forEach {
			commentView.addSubview($0)
		}
	
		tableView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
	
		designLine.snp.makeConstraints {
			$0.height.equalTo(1)
			$0.leading.trailing.top.equalTo(commentView)
		}
		commentView.snp.makeConstraints {
			$0.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
			$0.height.greaterThanOrEqualTo(50)
		}
		textView.snp.makeConstraints {
			$0.top.equalTo(commentView.snp.top).inset(5)
			$0.leading.equalTo(commentView).inset(15)
			$0.bottom.equalTo(commentView).inset(5)
			$0.height.equalTo(40)
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
