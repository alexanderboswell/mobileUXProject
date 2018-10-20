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
	var profileImage: UIImage
	var courses: [Course]
	var notificationPreferences = [NotificationPreference]()
	
	//MARK: Preferences
	var sectionOnly = false
	var weekends = false
	var smallerThan4 = false
	var quietPlace = false
    var backgroundMusic = false
	
	init(name: String, courses: [Course], profileImage: UIImage) {
		self.name = name
		self.courses = courses
		self.notificationPreferences = [
			NotificationPreference(description: "1"),
			NotificationPreference(description: "2"),
			NotificationPreference(description: "3"),
			NotificationPreference(description: "4"),
			NotificationPreference(description: "5")
		]
		self.profileImage = profileImage
	}
	
	func remove(course: Course) {
	
		courses.removeAll { (tempCourse) -> Bool in
			if tempCourse.title == course.title, tempCourse.professor == course.professor,
				tempCourse.section == course.section {
				return true
			} else {
				return false
			}
		}
	}
	
}
