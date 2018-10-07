//
//  Client.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

class Client {

	static var signedInAccount: Account?
	
	static let accounts = [
		Account(name: "User 1", courses: [
			Course(title: "MATH 334", professor: "Professor Webb", section: 4),
			Course(title: "CS 356", professor: "Professor Jones", section: 1),
			Course(title: "CS 455", professor: "Professor Egbert", section: 2)
			]),
		Account(name: "User 2", courses: [
			Course(title: "ASL 235", professor: "Professor Smith", section: 2),
			Course(title: "ENGL 220", professor: "Professor Gonzalez", section: 4),
			Course(title: "PHIL 202", professor: "Professor Rockwood", section: 6)
			])
	]
	
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
	
	static func login(accountNumber: Int) {
			Client.signedInAccount = Client.accounts[accountNumber]
	}
	
	static func logout() {
		Client.signedInAccount = nil
	}
}
