//
//  EdtingPostView.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/05.
//

import UIKit
import SnapKit

class EdtingView: UIView, ViewProtocol {
	
	let textView = UITextView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setUpConstranits()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		print("Error.Init",#function)
	}
	
	func configure() {
		textView.layer.borderWidth = 2
		textView.layer.borderColor = UIColor.systemGray3.cgColor
		textView.layer.cornerRadius = 3
		textView.font = .systemFont(ofSize: 18)
	}
	
	func setUpConstranits() {
		addSubview(textView)
		textView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(20)
			$0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
			$0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.55)
		}
	}
	
	
}
