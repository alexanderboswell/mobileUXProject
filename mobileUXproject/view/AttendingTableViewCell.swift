//
//  AttendingTableViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/16/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AttendingTableViewCell: UITableViewCell {

	@IBOutlet weak var courseTitleLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var view: UIView!
	@IBOutlet weak var monthLabel: UILabel!
	@IBOutlet weak var dayLabel: UILabel!
	
	
	var session: StudySession! {
		didSet {
			setLabels()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		configureShadowAndBorder()
	}
	
	private func setLabels() {
		courseTitleLabel.text =  session.courseTitle
		timeLabel.text = session.date
		locationLabel.text =  "\(session.roomNumber) \(session.building)"
		dayLabel.text = session.day
		monthLabel.text = session.month
		
	}
	
	func configureShadowAndBorder() {
		view.addBorder(color: .accentColor)
		view.addShadow()
	}
}
