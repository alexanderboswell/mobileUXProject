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

let months  = [1:  "Jan",
			   2: "Feb",
			   3: "Mar",
			   4: "Apr",
			   5: "May",
			   6: "Jun",
			   7: "Jul",
			   8: "Aug",
			   9: "Sept",
			   10: "Oct",
			   11: "Nov",
			   12: "Dec"]

class StudySession: NSObject, MKAnnotation {
	
	
	var courseTitle: String
	var roomNumber: String
	var building: String
	var numberConfirmed: Int
	var latitude: Double
	var longitude: Double
	var startDate: Date
	var endDate: Date
	
	var currentResponse: Response?
	var filterTitles = [String]()
	
	private let formatter = DateFormatter()
	
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
	
	var day: String {
		formatter.dateFormat = "dd"
		return formatter.string(from: startDate)
	}
	
	var month: String {
		formatter.dateFormat = "MM"
		if let monthKey = Int(formatter.string(from: startDate)), let month = months[monthKey] {
		return month
		} else {
			return ""
		}
	}
	
	var startTime: String {
		formatter.dateFormat = "hh:mm"
		return formatter.string(from: startDate)
	}
	
	var endTime: String {
		formatter.dateFormat = "hh:mm a"
		return formatter.string(from: endDate)
	}
	
	var date: String {
		return "\(startTime) - \(endTime)"
	}
	
	init(courseTitle: String, startDateString: String, endDateString: String,
		 roomNumber: String, building: String,
		 numberConfirmed: Int, latitude: Double,
		 longitude: Double, response: Response? = nil, filterTitles: [String]? = nil) {
		
		formatter.dateFormat = "yyyy MM dd hh:mm a"
		
		self.courseTitle = courseTitle
		self.startDate = formatter.date(from: startDateString)!
		self.endDate = formatter.date(from: endDateString)!
		self.roomNumber = roomNumber
		self.building = building
		self.numberConfirmed = numberConfirmed
		self.latitude = latitude
		self.longitude = longitude
		self.currentResponse = response
		self.filterTitles = filterTitles ?? []
	}
}
