//
//  Course.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class Course {
	
	var title: String {
		get {
			return "\(courseAbbr) \(courseNumber)"
		}
	}
	var professor: String
	var courseAbbr: String
	var courseNumber: Int
	var section: Int
	
	init(courseAbbr: String, courseNumber: Int, professor: String, section: Int) {
		self.courseAbbr = courseAbbr
		self.courseNumber = courseNumber
		self.professor = professor
		self.section = section
	}
}
