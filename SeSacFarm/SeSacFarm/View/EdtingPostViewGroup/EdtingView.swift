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
		
	}
	
	func setUpConstranits() {
		addSubview(textView)
		textView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
	}
	
	
}
