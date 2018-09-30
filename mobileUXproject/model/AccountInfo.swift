//
//  AccountInfo.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AccountInfo {

	var name: String
	var profileImage: UIImage?
	var courses = [Course]()
	
	//MARK: Preferences
	var sectionOnly = false
	var weekends = false
	var smallerThan4 = false
	var quietPlace = false
    var backgroundMusic = false
	
	init(name: String) {
		self.name = name
	}
	
}
