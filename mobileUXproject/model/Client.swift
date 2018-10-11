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
			Course(courseAbbr: "MATH", courseNumber: 334, professor: "Professor Webb", section: 4),
			Course(courseAbbr: "CS", courseNumber: 356, professor: "Professor Jones", section: 1),
			Course(courseAbbr: "CS", courseNumber: 455, professor: "Professor Egbert", section: 2)
			]),
		Account(name: "User 2", courses: [
			Course(courseAbbr: "ASL", courseNumber: 235, professor: "Professor Smith", section: 2),
			Course(courseAbbr: "ENGL", courseNumber: 220, professor: "Professor Gonzalez", section: 4),
			Course(courseAbbr: "PHIL", courseNumber: 202, professor: "Professor Rockwood", section: 6)
			])
	]
	
	static func getSessionsByWeek(callback: @escaping ([(String, [StudySession])]?) -> Void) {
		if signedInAccount?.name == "User 1" {
			callback([
				("10/15 - 10/21", [
					StudySession(courseTitle: "MATH 334", date: "10/15 1 - 2 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 3, numberMaybe: 2, numberCanceled: 4, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Rolland K.", "Lynda E.", "Daniel T."], maybeStudents: ["Carina Y.", "Shirley Q.", "Bryn W."], canceledStudents: ["Lavena R.", "Lisa T.", "Abbey N.", "Sammi S."]),
					StudySession(courseTitle: "CS 356", date: "10/17 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], maybeStudents: [], canceledStudents: ["Michele M.", "Jack R.", "Kevin P."]),
					StudySession(courseTitle: "CS 455", date: "10/20 3 - 4 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, numberMaybe: 6, numberCanceled: 2, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: ["Daniel T.", "Geoff J.", "Kevin P.", "Shaun D.",  "Vicki C.", "Carina Y."], canceledStudents: ["Alex E.", "Andrew D."])
					]
				),
				("10/22 - 10/28", [
					StudySession(courseTitle: "MATH 334", date: "10/25 3 - 4 pm", roomNumber: "121", building: "TMCB", numberConfirmed: 6, numberMaybe: 2, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], maybeStudents: ["Alex E.", "Andrew D."], canceledStudents: ["Michele M.", "Jack R.", "Kevin P."])
					]
				),
				("10/29 - 11/4", [
					StudySession(courseTitle: "MATH 334", date: "10/30 7 - 9 pm", roomNumber: "3014", building: "HBL LIB", numberConfirmed: 4, numberMaybe: 1, numberCanceled: 4, latitude: 40.2482096, longitude: -111.6501023, confirmedStudents: ["Lavena R.", "Lisa T.", "Abbey N.", "Sammi S."], maybeStudents: ["Geoff R."], canceledStudents: ["Carina Y.", "Shirley Q.", "Bryn W.", "Willam M."]),
					StudySession(courseTitle: "CS 455", date: "11/1 3 - 4 pm", roomNumber: "203", building: "EB", numberConfirmed: 3, numberMaybe: 3, numberCanceled: 0, latitude: 40.2471443, longitude: -111.6483439, confirmedStudents:["Rolland K.", "Lynda E.", "Daniel T."], maybeStudents: ["Lisa T.", "Abbey N.", "Sammi S."], canceledStudents: []),
					StudySession(courseTitle: "CS 455", date: "11/2 9 - 10 am", roomNumber: "1103", building: "JKB", numberConfirmed: 2, numberMaybe: 2, numberCanceled: 6, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Bill T.", "Ralph P."], maybeStudents: ["Crystal T.", "Rusty F."], canceledStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."]),
					StudySession(courseTitle: "CS 455", date: "11/4 5 - 6 pm", roomNumber: "110", building: "JSB", numberConfirmed: 6, numberMaybe: 4, numberCanceled: 5, latitude: 40.2458247, longitude: -111.6536954, confirmedStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], maybeStudents: ["Lavena R.", "Lisa T.", "Abbey N.", "Sammi S."], canceledStudents: ["Daniel T.", "Geoff J.", "Kevin P.", "Shaun D.",  "Vicki C." ])
					]
				),
				("11/5 - 11/11", [
					StudySession(courseTitle: "CS 455", date: "11/10 6:15 - 8 pm", roomNumber: "203", building: "EB", numberConfirmed: 2, numberMaybe: 5, numberCanceled: 1, latitude: 40.2471443, longitude: -111.6483439, confirmedStudents: ["Shaun D.",  "Vicki C." ], maybeStudents: ["Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], canceledStudents: ["Reed. G"])
					]
				)
				
				
				])
		} else if signedInAccount?.name == "User 2" {
			callback([
				("10/15 - 10/21", [
					StudySession(courseTitle: "ASL 235", date: "10/15 1 - 2 pm", roomNumber: "B032", building: "JFSB", numberConfirmed: 3, numberMaybe: 2, numberCanceled: 4, latitude: 40.2483574, longitude: -111.6513684, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
					StudySession(courseTitle: "ENGL 220", date: "10/17 1:45 - 2:30 pm", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
					StudySession(courseTitle: "PHIL 202", date: "10/20 5 - 7 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 1, numberMaybe: 5, numberCanceled: 2, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
					]
				),
				("10/22 - 10/28", [
					StudySession(courseTitle: "ENGL 220", date: "10/23 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 1, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
					StudySession(courseTitle: "ENGL 220", date: "10/26 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 2, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
					StudySession(courseTitle: "ASL 235", date: "10/28 3 - 4 pm", roomNumber: "1101", building: "JFSB", numberConfirmed: 0, numberMaybe: 4, numberCanceled: 3, latitude: 40.2483574, longitude: -111.6513684, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
					]
				),
				("10/29 - 11/4", [
					StudySession(courseTitle: "ASL 235", date: "10/29 8 - 9 pm", roomNumber: "1101", building: "JFSB", numberConfirmed: 0, numberMaybe: 5, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
					StudySession(courseTitle: "PHIL 202", date: "11/3 3 - 4 pm", roomNumber: "5734", building: "HBL LIB", numberConfirmed: 3, numberMaybe: 0, numberCanceled: 2, latitude: 40.2482096, longitude: -111.6501023, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
					StudySession(courseTitle: "PHIL 202", date: "11/4 5 - 6 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 2, numberMaybe: 4, numberCanceled: 0, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
					StudySession(courseTitle: "PHIL 202", date: "11/4 7:30 - 9 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 3, numberMaybe: 1, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
					]
				),
				("11/5 - 11/11", [
						StudySession(courseTitle: "ENGL 220", date: "11/7 1:45 - 2:30 pm", roomNumber: "2111", building: "JKB", numberConfirmed: 4, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
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
	
	static func getAvailableCourses(callback: @escaping ([String:[Int: [(String, Int)]]]?) -> Void)  {
		
		var availableCourses =
			[ "MATH": [ 334: [
				("Professor Webb", 4),
				("Professor Webb", 3)
				],
						314: [
				("Professor Martin", 1),
				("Professor Martin", 2)
				]
			],
			  "ASL": [ 235: [
			    ("Professor Smith", 3),
			    ("Professor Smith", 2)
			    ],
					   150: [
				("Professor Rockwell", 5),
				("Professor Rockwell", 4)
				]

			]
		]
		if let courses = Client.signedInAccount?.courses {
	
			for course in courses {
				if let courseDict = availableCourses[course.courseAbbr],
					let sections = courseDict[course.courseNumber] {
					for (j, section) in sections.enumerated() {
						if section.0 == course.professor, section.1 == course.section {
							availableCourses[course.courseAbbr]?[course.courseNumber]?.remove(at: j)
							break
						}
					}
				}
			}
		}
		
		
		callback(availableCourses)
	}
}
