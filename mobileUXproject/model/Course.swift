//
//  Course.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class Course {

	var title: String
	var professor: String
	var section: Int
	
	init(title: String, professor: String, section: Int) {
		self.title = title
		self.professor = professor
		self.section = section
	}
}
