//
//  InitialView.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2021/12/31.
//

import UIKit
import SnapKit

class InitialView: UIView, ViewProtocol{
	let imageView = UIImageView()
	let titleLable = UILabel()
	let subTitleLabel = UILabel()
	let button = MainButton()
	let label = UILabel()
	
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
		
		imageView.backgroundColor = .blue
		
		
		titleLable.text = "당신 근처의 새싹농장"
		titleLable.font = .boldSystemFont(ofSize: 20)
		titleLable.textAlignment = .center
		
		subTitleLabel.text = "iOS 지식부터 바람의 나라까지 지금 SeSAC에서 함께해보세요!"
		subTitleLabel.numberOfLines = 2
		subTitleLabel.textAlignment = .center
		subTitleLabel.font = .systemFont(ofSize: 15)
		
		button.backgroundColor = .green
		button.setTitle("시작하기", for: .normal)
		
		label.text = "이미 계정이 있나요? 로그인"
		label.textColor = .placeholderText
		let attributedStr = NSMutableAttributedString(string: label.text!)
		attributedStr.addAttribute(.foregroundColor, value: UIColor.green, range: (label.text! as NSString).range(of: "로그인"))
		label.attributedText = attributedStr
		
		label.font = .systemFont(ofSize: 15)
		label.textAlignment = .center
		
	}
	
	func setUpConstranits() {
		[imageView, titleLable, subTitleLabel, button, label].forEach {
			addSubview($0)
		}
		
		imageView.snp.makeConstraints {
			$0.center.equalTo(self)
			$0.width.height.equalTo(self.snp.width).multipliedBy(0.3)
		}
		
		titleLable.snp.makeConstraints {
			$0.top.equalTo(imageView.snp.bottom)
			$0.centerX.equalTo(self)
			$0.width.equalTo(label.snp.width)
			$0.height.equalTo(30)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.top.equalTo(titleLable.snp.bottom)
			$0.centerX.equalTo(self)
			$0.width.equalTo(titleLable.snp.width)
			$0.height.equalTo(40)
		}
		
		button.snp.makeConstraints {
			$0.bottom.equalTo(self.safeAreaLayoutGuide).inset(60)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
			$0.height.equalTo(44)
		}
		
		label.snp.makeConstraints {
			$0.top.equalTo(button.snp.bottom).offset(20)
			$0.centerX.equalTo(self)
			$0.width.equalTo(button.snp.width).multipliedBy(0.5)
		}
		
	}
	
}
