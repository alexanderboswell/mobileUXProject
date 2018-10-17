//
//  Extensions.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/27/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

extension UIColor {
	
	static var accentColor: UIColor {
		return UIColor(red: 84.0/255, green: 116.0/255, blue: 1.0, alpha: 1.0)
	}
	
	static var confirmColor: UIColor {
		return UIColor(red: 88.0/255, green: 174.0/255, blue: 107.0/255, alpha: 1.0)
	}
	
	static var cancelColor: UIColor {
		return UIColor(red: 225.0/255, green: 82.0/255, blue: 66.0/255, alpha: 1.0)
	}
}

extension UITableView {
	func scrollToTop(animated: Bool) {
		DispatchQueue.main.asyncAfter(deadline: .now()) {
			let numberOfSections = self.numberOfSections
			let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
				if numberOfRows > 0 {
					let indexPath = IndexPath(row: 0, section: 0)
					self.scrollToRow(at: indexPath, at: .top, animated: animated)
				}
		}
	}
}
