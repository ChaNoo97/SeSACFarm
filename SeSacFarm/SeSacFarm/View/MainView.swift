//
//  MainView.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/03.
//

import UIKit
import SnapKit

class MainView: UIView, ViewProtocol {
	
	let tableView = UITableView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setUpConstranits()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
		setUpConstranits()
	}
	
	func configure() {
	}
	
	func setUpConstranits() {
		addSubview(tableView)
		tableView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
	}
	
	
}
