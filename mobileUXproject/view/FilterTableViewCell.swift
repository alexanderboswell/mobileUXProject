//
//  FilterTableViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/17/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit


protocol FilterProtocol {
	func addFilter(courseTitle: String)
	func removeFilter(courseTitle: String)
}

class FilterTableViewCell: UITableViewCell {

	@IBOutlet weak var courseTitleLabel: UILabel!
	@IBOutlet weak var selectedView: UIView!
	
	private let impact = UIImpactFeedbackGenerator()
	
	var courseTitle: String!
	
	var isOn: Bool!
	var delegate: FilterProtocol?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		let addFilterRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.addToFilterTap(_:)))
		selectedView.addGestureRecognizer(addFilterRecognizer)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		selectedView.layer.borderWidth = 1.5
		selectedView.layer.borderColor = UIColor.accentColor.cgColor
		selectedView.layer.masksToBounds = true
	}
	
	@objc func addToFilterTap(_ sender: UITapGestureRecognizer) {
		impact.impactOccurred()
		if isOn {
			selectedView.backgroundColor = .white
			delegate?.removeFilter(courseTitle: courseTitle)
		} else {
			selectedView.backgroundColor = .accentColor
			delegate?.addFilter(courseTitle: courseTitle)
		}
		
		isOn = !isOn
	}
}
