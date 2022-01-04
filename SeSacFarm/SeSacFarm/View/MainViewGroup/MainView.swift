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
	let floatingButton = UIButton()
	
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
		floatingButton.backgroundColor = .green
		floatingButton.layer.cornerRadius = 30
	}
	
	func setUpConstranits() {
		
		addSubview(tableView)
		tableView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
		
		//view 에 추가해주고, 순서에따라 위로옴
		//addSubview 순서가 중요
		addSubview(floatingButton)
		floatingButton.snp.makeConstraints {
			$0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
			$0.size.equalTo(60)
		}
	}
	
	
}
