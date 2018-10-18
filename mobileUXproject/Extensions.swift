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

extension UIView {
	func addBorder(color: UIColor) {
		layer.cornerRadius = 10.0
		layer.borderWidth = 1.5
		layer.borderColor = color.cgColor
		layer.masksToBounds = true
	}
	
	func  addShadow() {
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
		layer.shadowRadius = 8
		layer.shadowOpacity = 0.08
		layer.masksToBounds = false
		layer.shadowPath = UIBezierPath(rect: bounds).cgPath
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
