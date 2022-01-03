//
//  MainViewController.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/03.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
	
	let mainView = MainView()
	let viewModel = MainViewModel()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.postsGet {
			self.mainView.tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
		
		mainView.tableView.delegate = self
		mainView.tableView.dataSource = self
		mainView.tableView.rowHeight = UITableView.automaticDimension
		mainView.tableView.estimatedRowHeight = UITableView.automaticDimension
		
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.numberOfSection
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRowsInSection
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = mainView.tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as! MainTableViewCell
		let data = viewModel.cellForRowAt(mainView.tableView, indexPath: indexPath)
		let count = data.comments.count
		cell.writer.text = data.user.username
		cell.content.text = data.text
		cell.date.text = viewModel.dateFormat(data.updatedAt)
		if count == 0 {
			cell.commentStatus.text = "댓글쓰기"
		} else {
			cell.commentStatus.text = "댓글 \(count)"
		}
		return cell
	}
	
}
