//
//  File.swift
//  SeSacFarm
//
//  Created by Hoo's MacBookPro on 2022/01/04.
//

import Foundation
import UIKit

protocol TableViewCellRepresentable {
	var numberOfSection: Int { get }
	var numberOfRowsInSection: Int { get }
	var heightOfRowAt: CGFloat { get }

}
