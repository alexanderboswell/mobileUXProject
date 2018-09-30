//
//  Client.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

class Client {

	
	static func getSessionsByWeek(callback: @escaping ([(String, [StudySession])]?) -> Void) {
		callback([
			("9/24 - 9/30", [
				StudySession(courseTitle: "MATH 334", date: "9/24 1 - 2 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 3, numberMaybe: 2, numberCanceled: 4, latitude: 40.249801, longitude: -111.6508399),
			 	StudySession(courseTitle: "CS 356", date: "9/25 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399),
				StudySession(courseTitle: "CS 455", date: "9/27 3 - 4 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, numberMaybe: 6, numberCanceled: 2, latitude: 40.249801, longitude: -111.6508399)
				]
			),
			("10/1 - 10/7", [
				StudySession(courseTitle: "MATH 334", date: "10/1 3 - 4 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 0, numberMaybe: 5, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399)
				]
			)
		
		
		])
	}
	
	
}
