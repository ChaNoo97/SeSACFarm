//
//  PostCommentCell.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

import UIKit
import SnapKit

class PostCommentCell: UITableViewCell, ViewProtocol {
	
	let topView = UIView()
	let commentUserName = UILabel()
	let settingButton = UIButton()
	let comment = UILabel()
	let bottomView = UIView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setUpConstranits()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		print("postcommentcell error")
	}
	
	func configure() {
		
		commentUserName.font = .boldSystemFont(ofSize: 18)
		
		comment.numberOfLines = 0
		
		[topView, bottomView].forEach {
			$0.backgroundColor = .white
			$0.layer.borderWidth = 1
			$0.layer.borderColor = UIColor.white.cgColor
		}
		
		settingButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
		
	}
	
	func setUpConstranits() {
		[topView, commentUserName, settingButton ,comment, bottomView].forEach {
			contentView.addSubview($0)
		}
		
		topView.snp.makeConstraints {
			$0.top.leading.trailing.equalTo(contentView)
			$0.height.equalTo(10)
		}
		
		commentUserName.snp.makeConstraints {
			$0.leading.equalTo(contentView.snp.leading).inset(10)
			$0.top.equalTo(topView.snp.bottom)
			$0.height.equalTo(20)
		}
		
		settingButton.snp.makeConstraints {
			$0.top.equalTo(commentUserName.snp.top).offset(5)
			$0.trailing.equalTo(contentView.snp.trailing).inset(10)
			$0.size.equalTo(20)
		}
		
		comment.snp.makeConstraints {
			$0.leading.equalTo(commentUserName.snp.leading)
			$0.top.equalTo(commentUserName.snp.bottom).offset(5)
			$0.bottom.equalTo(bottomView.snp.top)
		}
		
		bottomView.snp.makeConstraints {
			$0.bottom.leading.trailing.equalTo(contentView)
			$0.height.equalTo(10)
		}
	}
	
	
}
