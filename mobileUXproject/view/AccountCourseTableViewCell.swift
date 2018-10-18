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
	
	var course: Course? {
		didSet {
			if let course = course {
				courseLabel.text = course.title
				sectionInfoLabel.text = "Section \(course.section), \(course.professor)"
			}
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		infoView.addBorder(color: .accentColor)
		infoView.addShadow()
	}
}

