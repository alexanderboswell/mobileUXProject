//
//  SessionCollectionViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class SessionCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var courrseTitleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var confirmedLabel: UILabel!
	@IBOutlet weak var maybeLabel: UILabel!
	@IBOutlet weak var canceledLabel: UILabel!
	
	override func layoutSubviews() {
		super.layoutSubviews()
		configureShadowAndBorder()
	}
	
	func configureShadowAndBorder() {
		self.contentView.layer.cornerRadius = 10.0
		self.contentView.layer.borderWidth = 1.5
		self.contentView.layer.borderColor = UIColor.accentColor.cgColor
		self.contentView.layer.masksToBounds = true
		
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
		self.layer.shadowRadius = 8.0
		self.layer.shadowOpacity = 0.075
		self.layer.masksToBounds = false
		self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
	}
}

