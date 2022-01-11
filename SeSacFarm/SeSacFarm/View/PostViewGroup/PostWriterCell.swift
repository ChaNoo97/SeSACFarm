//
//  PostWriterCell.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

import UIKit
import SnapKit

class PostWriterCell: UITableViewCell, ViewProtocol {
	
	let topView = UIView()
	let writerImage = UIImageView()
	let writerName = UILabel()
	let writeDate = UILabel()
	let designLine1 = UILabel()
	let designLine2 = UILabel()
	let designLine3 = UILabel()
	let writerContent = UILabel()
	let commentImage = UIImageView()
	let commentStatus = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setUpConstranits()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		print("postwriteCell error")
	}
	
	func configure() {
		[designLine1, designLine2, designLine3].forEach {
			$0.backgroundColor = .systemGray3
		}
		writerContent.numberOfLines = 0
		
		writerImage.image = UIImage(systemName: "person.crop.circle.fill")
		writerImage.tintColor = .systemGray3
		
		commentImage.image = UIImage(systemName: "bubble.left")
		commentImage.tintColor = .systemGray3
	}
	
	
	
	
	func setUpConstranits() {
		[topView, designLine1, designLine2, designLine3, writerContent, commentImage, commentStatus].forEach {
			contentView.addSubview($0)
		}
		[writerImage, writerName, writeDate].forEach {
			topView.addSubview($0)
		}
		topView.snp.makeConstraints {
			$0.top.equalTo(contentView.snp.top)
			$0.leading.trailing.equalTo(contentView)
			$0.height.equalTo(80)
		}
		writerImage.snp.makeConstraints {
			$0.top.equalTo(topView.snp.top).inset(20)
			$0.leading.equalTo(topView.snp.leading).inset(10)
			$0.size.equalTo(55)
		}
		writerName.snp.makeConstraints {
			$0.top.equalTo(writerImage.snp.top)
			$0.leading.equalTo(writerImage.snp.trailing).offset(5)
			$0.height.equalTo(20)
		}
		writeDate.snp.makeConstraints {
			$0.bottom.equalTo(writerImage.snp.bottom)
			$0.leading.equalTo(writerName.snp.leading)
			$0.height.equalTo(20)
		}
		designLine1.snp.makeConstraints {
			$0.top.equalTo(topView.snp.bottom).offset(5)
			$0.height.equalTo(1)
			$0.width.equalTo(contentView)
		}
		writerContent.snp.makeConstraints {
			$0.leading.top.equalTo(designLine1).offset(10)
			$0.trailing.equalTo(designLine1).inset(10)
		}
		designLine2.snp.makeConstraints {
			$0.leading.trailing.equalTo(contentView)
			$0.top.equalTo(writerContent.snp.bottom).offset(10)
			$0.height.equalTo(1)
		}
		commentImage.snp.makeConstraints {
			$0.leading.equalTo(contentView).offset(10)
			$0.top.equalTo(designLine2).offset(5)
			$0.size.equalTo(20)
		}
		commentStatus.snp.makeConstraints {
			$0.leading.equalTo(commentImage.snp.trailing).offset(5)
			$0.top.equalTo(commentImage.snp.top)
			$0.height.equalTo(20)
		}
		designLine3.snp.makeConstraints {
			$0.top.equalTo(commentImage.snp.bottom).offset(5)
			$0.height.equalTo(1)
			$0.leading.trailing.equalTo(contentView)
			$0.bottom.equalTo(contentView.snp.bottom).inset(10)
		}
	}
}
