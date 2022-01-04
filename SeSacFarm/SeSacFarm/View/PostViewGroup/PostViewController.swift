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
	let viewModel = PostViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		makeConstraints()
		tableView.register(PostWriterCell.self, forCellReuseIdentifier: PostWriterCell.reuseIdentifier)
		tableView.register(PostCommentCell.self, forCellReuseIdentifier: PostCommentCell.reuseIdentifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.delegate = self
		tableView.dataSource = self
		
	}
	
	func makeConstraints() {
		view.addSubview(tableView)
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
			return 5
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell1 = tableView.dequeueReusableCell(withIdentifier: PostWriterCell.reuseIdentifier)!
		let cell2 = tableView.dequeueReusableCell(withIdentifier: PostCommentCell.reuseIdentifier)!
		if indexPath.section == 0 {
			return cell1
		} else {
			return cell2
		}
	}
	
	
}
