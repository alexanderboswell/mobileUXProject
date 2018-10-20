//
//  FilterTableViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/17/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

protocol FilterProtocol {
	func filterChanged()
}

class FilterTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var filterSwitch: UISwitch!

	private let impact = UIImpactFeedbackGenerator()
	
	var title: String! {
		didSet {
			titleLabel.text = title
		}
	}
	var isOn: Bool! {
		didSet {
			filterSwitch.isOn = isOn
		}
	}
	
	var delegate: FilterProtocol?
	
	@IBAction func onChange(_ sender: UISwitch) {
		for filter in Client.filters {
			if filter.title == title {
				filter.isOn = sender.isOn
			}
		}
		delegate?.filterChanged()
	}
}
