//
//  MainButton.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2021/12/31.
//

import UIKit

class MainButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setUpView()
	}
	
	func setUpView() {
		self.setTitleColor(.white, for: .normal)
		self.layer.cornerRadius = 5
		self.clipsToBounds = true
	}
}


