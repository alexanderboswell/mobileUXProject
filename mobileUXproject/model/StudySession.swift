//
//  StudySession.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit
import MapKit

enum Response {
	case confirmed, maybe, canceled
}

class StudySession: NSObject, MKAnnotation {
	
	
	var courseTitle: String
	var date: String
	var roomNumber: String
	var building: String
	var numberConfirmed: Int
	var confirmedStudents: [String]
	var numberMaybe: Int
	var maybeStudents: [String]
	var numberCanceled: Int
	var canceledStudents: [String]
	var latitude: Double
	var longitude: Double
	
	var currentResponse: Response?
	
	//MARK: MKAnnotation
	
	var coordinate: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	var title: String? {
		return building
	}
	
	var subtitle: String? {
		return nil
	}
	
	init(courseTitle: String, date: String,
		 roomNumber: String, building: String,
		 numberConfirmed: Int, numberMaybe: Int,
		 numberCanceled: Int, latitude: Double,
		 longitude: Double,  confirmedStudents: [String],
		 maybeStudents: [String], canceledStudents: [String]) {
		self.courseTitle = courseTitle
		self.date = date
		self.roomNumber = roomNumber
		self.building = building
		self.numberConfirmed = numberConfirmed
		self.numberMaybe = numberMaybe
		self.numberCanceled = numberCanceled
		self.latitude = latitude
		self.longitude = longitude
		self.confirmedStudents = confirmedStudents
		self.maybeStudents = maybeStudents
		self.canceledStudents = canceledStudents
	}
}
