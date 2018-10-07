//
//  AccountInfo.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class Account {

	var name: String
	var profileImage: UIImage?
	var courses: [Course]
	var studyPreferences = [StudyPreference]()
	
	//MARK: Preferences
	var sectionOnly = false
	var weekends = false
	var smallerThan4 = false
	var quietPlace = false
    var backgroundMusic = false
	
	init(name: String, courses: [Course]) {
		self.name = name
		self.courses = courses
		self.studyPreferences = [
			StudyPreference(description: "Working with only students in my section"),
			StudyPreference(description: "Available on the weekend"),
			StudyPreference(description: "Group sizes of 4+"),
			StudyPreference(description: "Prefer to study in a no shhhh zone"),
			StudyPreference(description: "Study with background music")
		]
	}
	
}
