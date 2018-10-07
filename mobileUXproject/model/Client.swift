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
		if signedInAccount?.name == "User 1" {
			callback([
				("10/15 - 10/21", [
					StudySession(courseTitle: "MATH 334", date: "10/15 1 - 2 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 3, numberMaybe: 2, numberCanceled: 4, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "CS 356", date: "10/17 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "CS 455", date: "10/20 3 - 4 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, numberMaybe: 6, numberCanceled: 2, latitude: 40.249801, longitude: -111.6508399)
					]
				),
				("10/22 - 10/28", [
					StudySession(courseTitle: "MATH 334", date: "10/25 3 - 4 pm", roomNumber: "121", building: "TMCB", numberConfirmed: 6, numberMaybe: 2, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399)
					]
				),
				("10/29 - 11/4", [
					StudySession(courseTitle: "MATH 334", date: "10/30 7 - 9 pm", roomNumber: "3014", building: "HBL LIB", numberConfirmed: 4, numberMaybe: 1, numberCanceled: 4, latitude: 40.2482096, longitude: -111.6501023),
					StudySession(courseTitle: "CS 455", date: "11/1 3 - 4 pm", roomNumber: "203", building: "EB", numberConfirmed: 3, numberMaybe: 3, numberCanceled: 0, latitude: 40.2471443, longitude: -111.6483439),
					StudySession(courseTitle: "CS 455", date: "11/2 9 - 10 am", roomNumber: "1103", building: "JKB", numberConfirmed: 2, numberMaybe: 2, numberCanceled: 6, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "CS 455", date: "11/4 5 - 6 pm", roomNumber: "110", building: "JSB", numberConfirmed: 6, numberMaybe: 4, numberCanceled: 5, latitude: 40.2458247, longitude: -111.6536954)
					]
				),
				("11/5 - 11/11", [
					StudySession(courseTitle: "CS 455", date: "11/10 6:15 - 8 pm", roomNumber: "203", building: "EB", numberConfirmed: 2, numberMaybe: 5, numberCanceled: 1, latitude: 40.2471443, longitude: -111.6483439),
					]
				)
				
				
				])
		} else if signedInAccount?.name == "User 2" {
			callback([
				("10/15 - 10/21", [
					StudySession(courseTitle: "ASL 235", date: "10/15 1 - 2 pm", roomNumber: "B032", building: "JFSB", numberConfirmed: 3, numberMaybe: 2, numberCanceled: 4, latitude: 40.2483574, longitude: -111.6513684),
					StudySession(courseTitle: "ENGL 220", date: "10/17 1:45 - 2:30 pm", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "PHIL 202", date: "10/20 5 - 7 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 1, numberMaybe: 5, numberCanceled: 2, latitude: 40.249801, longitude: -111.6508399)
					]
				),
				("10/22 - 10/28", [
					StudySession(courseTitle: "ENGL 220", date: "10/23 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "ENGL 220", date: "10/26 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "ASL 235", date: "10/28 3 - 4 pm", roomNumber: "1101", building: "JFSB", numberConfirmed: 0, numberMaybe: 5, numberCanceled: 3, latitude: 40.2483574, longitude: -111.6513684)
					]
				),
				("10/29 - 11/4", [
					StudySession(courseTitle: "ASL 235", date: "10/29 8 - 9 pm", roomNumber: "1101", building: "JFSB", numberConfirmed: 0, numberMaybe: 5, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "PHIL 202", date: "11/3 3 - 4 pm", roomNumber: "5734", building: "HBL LIB", numberConfirmed: 3, numberMaybe: 0, numberCanceled: 2, latitude: 40.2482096, longitude: -111.6501023),
					StudySession(courseTitle: "PHIL 202", date: "11/4 5 - 6 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 6, numberMaybe: 4, numberCanceled: 0, latitude: 40.249801, longitude: -111.6508399),
					StudySession(courseTitle: "PHIL 202", date: "11/4 7:30 - 9 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 3, numberMaybe: 5, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399)
					]
				),
				("11/5 - 11/11", [
						StudySession(courseTitle: "ENGL 220", date: "11/7 1:45 - 2:30 pm", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399)
					]
				)

				])
		} else {
			callback([])
		}
	}
	
	static func login(accountNumber: Int) {
			Client.signedInAccount = Client.accounts[accountNumber]
	}
	
	static func logout() {
		Client.signedInAccount = nil
	}
}
