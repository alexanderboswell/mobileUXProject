//
//  AccountPreferenceTableViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/2/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AccountPreferenceTableViewCell: UITableViewCell {

	@IBOutlet weak var preferenceSwitch: UISwitch!
	@IBOutlet weak var preferenceLabel: UILabel!
	
	var preference: NotificationPreference? {
		didSet {
			preferenceLabel.text = preference?.description
			preferenceSwitch.isOn = preference?.checked ?? true
		}
	}
	
	
	@IBAction func setPreference(_ sender: UISwitch) {
		preference?.checked = sender.isOn
	}
	@IBAction func onFilterChange(_ sender: UISwitch) {
	}
}
