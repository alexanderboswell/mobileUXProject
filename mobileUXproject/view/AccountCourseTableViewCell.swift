//
//  AccountCourseTableViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/2/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AccountCourseTableViewCell: UITableViewCell {

	@IBOutlet weak var courseLabel: UILabel!
	@IBOutlet weak var sectionInfoLabel: UILabel!
	@IBOutlet weak var infoView: UIView!
	
	override func layoutSubviews() {
		super.layoutSubviews()
		configureShadowAndBorder()
	}
	
	func configureShadowAndBorder() {
		self.infoView.layer.cornerRadius = 10.0
		
		self.infoView.layer.shadowColor = UIColor.black.cgColor
		self.infoView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
		self.infoView.layer.shadowRadius = 8
		self.infoView.layer.shadowOpacity = 0.08
		self.infoView.layer.masksToBounds = false
		self.infoView.layer.shadowPath = UIBezierPath(rect: self.infoView.bounds).cgPath
	}
}

