//
//  MainTableViewCell.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/03.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell, ViewProtocol {
	
	let writer = UILabel()
	let content = UILabel()
	let date = UILabel()
	let commentStatus = UILabel()
	let designView = UIView()
	let lineView = UIView()
	let commentImage = UIImageView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setUpConstranits()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		print("dd")
	}
	
	func configure() {
		writer.backgroundColor = .systemGray5
		writer.textColor = .gray
		
		lineView.backgroundColor = .systemGray3
		designView.backgroundColor = .systemGray3
		
		content.numberOfLines = 0
		
		writer.font = .systemFont(ofSize: 15)
		writer.textColor = .systemGray2
		
		date.font = .systemFont(ofSize: 15)
		date.textColor = .systemGray2
		
		commentImage.image = UIImage(systemName: "bubble.left")
		commentImage.tintColor = .systemGray2
	}
	
	func setUpConstranits() {
		[writer, content, date, commentStatus, designView, lineView, commentImage].forEach {
			contentView.addSubview($0)
		}
		writer.snp.makeConstraints {
			$0.leading.top.equalTo(contentView).inset(10)
			$0.height.equalTo(20)
		}
		content.snp.makeConstraints {
			$0.top.equalTo(writer.snp.bottom).offset(10)
			$0.leading.equalTo(writer.snp.leading)
			$0.trailing.equalTo(contentView).inset(10)
		}
		
		date.snp.makeConstraints {
			$0.top.equalTo(content.snp.bottom).offset(10)
			$0.leading.equalTo(writer.snp.leading)
			$0.height.equalTo(20)
		}
		
		lineView.snp.makeConstraints {
			$0.top.equalTo(date.snp.bottom).offset(10)
			$0.leading.width.equalTo(contentView)
			$0.height.equalTo(1)
		}
		
		commentImage.snp.makeConstraints {
			$0.top.equalTo(lineView.snp.bottom).offset(5)
			$0.leading.equalTo(writer.snp.leading)
			$0.size.equalTo(20)
		}
		commentStatus.snp.makeConstraints {
			$0.top.equalTo(commentImage)
			$0.leading.equalTo(commentImage.snp.trailing)
			$0.height.equalTo(20)
		}
		
		designView.snp.makeConstraints {
			$0.leading.width.equalTo(contentView)
			$0.top.equalTo(commentStatus.snp.bottom).offset(10)
			$0.height.equalTo(5)
			$0.bottom.equalTo(contentView.snp.bottom)
		}
	}
}
