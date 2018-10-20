//
//  Client.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/28/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//
import UIKit

class Client {

	static var signedInAccount: Account?
	
	static var formatter = DateFormatter()
	
	static let accounts = [
		Account(name: "User 1", courses: [
			Course(courseAbbr: "MATH", courseNumber: 334, professor: "Professor Webb", section: 4),
			Course(courseAbbr: "CS", courseNumber: 356, professor: "Professor Jones", section: 1),
			Course(courseAbbr: "CS", courseNumber: 455, professor: "Professor Egbert", section: 2)
			], profileImage: UIImage(named: "user1")!)
	]
	
	static var filters = [
		Filter(title: "CS 455", isOn: true),
		Filter(title: "CS 356", isOn: true),
		Filter(title: "MATH 334", isOn: true),
		Filter(title: "Working with only students in my section", isOn: true),
		Filter(title: "Available on the weekend", isOn: true),
		Filter(title: "Group sizes of 4+", isOn: true),
		Filter(title: "Prefer to study in a no shhhh zone", isOn: true),
		Filter(title: "Study with background music", isOn: true)
	]
	
	
	static var sessionsForDate = [
		formatter.date(from: "2018 10 31")! : [
			StudySession(courseTitle: "CS 455", startDateString: "2018 10 31 04:30 pm", endDateString: "2018 10 31 05:30 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
					"CS 455",
					"Study with background music",
					"Prefer to study in a no shhhh zone"
				])],
		formatter.date(from: "2018 11 05")! : [
			StudySession(courseTitle: "CS 455", startDateString: "2018 11 05 10:30 am", endDateString: "2018 11 05 11:30 am", roomNumber: "3104", building: "JKB", numberConfirmed: 0, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 455",
				"Working with only students in my section"
				])],
		formatter.date(from: "2018 11 09")! : [
			StudySession(courseTitle: "CS 356",startDateString: "2018 11 09 01:30 pm", endDateString: "2018 11 09 02:30 pm", roomNumber: "2111", building: "JKB", numberConfirmed: 6, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 356"
				]),
			StudySession(courseTitle: "CS 455", startDateString: "2018 11 09 04:30 pm", endDateString: "2018 11 09 05:30 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 455",
				"Working with only students in my section"
				])
		],
		formatter.date(from: "2018 10 25")! : [
			StudySession(courseTitle: "CS 356", startDateString: "2018 10 25 10:00 am", endDateString: "2018 10 25 11:00 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 356",
				"Group sizes of 4+"
				]),
			StudySession(courseTitle: "CS 356", startDateString: "2018 10 25 10:30 am", endDateString: "2018 10 25 11:30 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 356",
				"Group sizes of 4+"
				]),
			StudySession(courseTitle: "MATH 334", startDateString: "2018 10 25 01:00 pm", endDateString: "2018 10 25 02:00 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 3, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"MATH 334"
				]),
			StudySession(courseTitle: "CS 455", startDateString: "2018 10 25 04:00 pm", endDateString: "2018 10 25 05:00 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 1, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 455",
				"Working with only students in my section"
				])],
		formatter.date(from: "2018 10 18")! : [
			StudySession(courseTitle: "CS 356", startDateString: "2018 10 18 08:30 am", endDateString: "2018 10 18 09:30 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 356",
				"Group sizes of 4+"
				]),
			StudySession(courseTitle: "CS 356", startDateString: "2018 10 18 10:45 am", endDateString: "2018 10 18 11:45 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 356",
				"Prefer to study in a no shhhh zone",
				"Group sizes of 4+"
				])],
		formatter.date(from: "2018 10 23")! : [
			StudySession(courseTitle: "CS 356", startDateString: "2018 10 23 10:00 am", endDateString: "2018 10 23 11:30 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 356",
				"Prefer to study in a no shhhh zone",
				"Group sizes of 4+"
				]),
			StudySession(courseTitle: "CS 356", startDateString: "2018 10 23 10:45 am", endDateString: "2018 10 23 11:45 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 356",
				"Group sizes of 4+"
				]),
			StudySession(courseTitle: "MATH 334", startDateString: "2018 10 23 01:15 pm", endDateString: "2018 10 23 02:45 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 3, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"MATH 334",
				"Working with only students in my section"
				]),
			StudySession(courseTitle: "CS 455", startDateString: "2018 10 23 04:30 pm", endDateString: "2018 10 23 05:30 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 455",
				"Study with background music"
				])],
		formatter.date(from: "2018 10 27")! : [
			StudySession(courseTitle: "MATH 334", startDateString: "2018 10 27 01:30 pm", endDateString: "2018 10 27 02:30 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 3, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"MATH 334",
				"Available on the weekend"
				]),
			StudySession(courseTitle: "CS 455", startDateString: "2018 10 27 04:30 pm", endDateString: "2018 10 27 05:30 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, latitude: 40.249801, longitude: -111.6508399, filterTitles:[
				"CS 455",
				"Available on the weekend"
				])],
		]
	
	static func getSessions(callback: @escaping ([Date: [StudySession]])  -> Void) {

		formatter.dateFormat = "yyyy MM dd"
		
		callback(sessionsForDate)

	}
	
	static func getAttendingSessions(callback: @escaping ([StudySession])  -> Void)  {
		Client.getSessions { (sessionsForDate) in
			var attendingSessions = [StudySession]()
			for key in sessionsForDate.keys {
				if let sessions = sessionsForDate[key] {
					for session in sessions {
						if session.currentResponse == .confirmed {
							attendingSessions.append(session)
						}
					}
				}
			}
			callback(attendingSessions)
		}
	}
	
	static func getSessionsByWeek(callback: @escaping ([(String, [StudySession])]?) -> Void) {
		if signedInAccount?.name == "User 1" {
			
			callback([
				("10/15 - 10/21", [
//					StudySession(courseTitle: "MATH 334", date: "10/15 1 - 2 pm", roomNumber: "1170", building: "TMCB", numberConfirmed: 3, numberMaybe: 2, numberCanceled: 4, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Rolland K.", "Lynda E.", "Daniel T."], maybeStudents: ["Carina Y.", "Shirley Q.", "Bryn W."], canceledStudents: ["Lavena R.", "Lisa T.", "Abbey N.", "Sammi S."]),
//					StudySession(courseTitle: "CS 356", date: "10/17 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], maybeStudents: [], canceledStudents: ["Michele M.", "Jack R.", "Kevin P."]),
//					StudySession(courseTitle: "CS 455", date: "10/20 3 - 4 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 0, numberMaybe: 6, numberCanceled: 2, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: ["Daniel T.", "Geoff J.", "Kevin P.", "Shaun D.",  "Vicki C.", "Carina Y."], canceledStudents: ["Alex E.", "Andrew D."])
					]
				),
				("10/22 - 10/28", [
//					StudySession(courseTitle: "MATH 334", date: "10/25 3 - 4 pm", roomNumber: "121", building: "TMCB", numberConfirmed: 6, numberMaybe: 2, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], maybeStudents: ["Alex E.", "Andrew D."], canceledStudents: ["Michele M.", "Jack R.", "Kevin P."])
					]
				),
				("10/29 - 11/4", [
//					StudySession(courseTitle: "MATH 334", date: "10/30 7 - 9 pm", roomNumber: "3014", building: "HBL LIB", numberConfirmed: 4, numberMaybe: 1, numberCanceled: 4, latitude: 40.2482096, longitude: -111.6501023, confirmedStudents: ["Lavena R.", "Lisa T.", "Abbey N.", "Sammi S."], maybeStudents: ["Geoff R."], canceledStudents: ["Carina Y.", "Shirley Q.", "Bryn W.", "Willam M."]),
//					StudySession(courseTitle: "CS 455", date: "11/1 3 - 4 pm", roomNumber: "203", building: "EB", numberConfirmed: 3, numberMaybe: 3, numberCanceled: 0, latitude: 40.2471443, longitude: -111.6483439, confirmedStudents:["Rolland K.", "Lynda E.", "Daniel T."], maybeStudents: ["Lisa T.", "Abbey N.", "Sammi S."], canceledStudents: []),
//					StudySession(courseTitle: "CS 455", date: "11/2 9 - 10 am", roomNumber: "1103", building: "JKB", numberConfirmed: 2, numberMaybe: 2, numberCanceled: 6, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: ["Bill T.", "Ralph P."], maybeStudents: ["Crystal T.", "Rusty F."], canceledStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."]),
//					StudySession(courseTitle: "CS 455", date: "11/4 5 - 6 pm", roomNumber: "110", building: "JSB", numberConfirmed: 6, numberMaybe: 4, numberCanceled: 5, latitude: 40.2458247, longitude: -111.6536954, confirmedStudents: ["Alex B.", "Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], maybeStudents: ["Lavena R.", "Lisa T.", "Abbey N.", "Sammi S."], canceledStudents: ["Daniel T.", "Geoff J.", "Kevin P.", "Shaun D.",  "Vicki C." ])
					]
				),
				("11/5 - 11/11", [
//					StudySession(courseTitle: "CS 455", date: "11/10 6:15 - 8 pm", roomNumber: "203", building: "EB", numberConfirmed: 2, numberMaybe: 5, numberCanceled: 1, latitude: 40.2471443, longitude: -111.6483439, confirmedStudents: ["Shaun D.",  "Vicki C." ], maybeStudents: ["Hannah E.", "Geoff J.", "Larry F.", "Mitchell S.", "Josh G."], canceledStudents: ["Reed. G"])
					]
				)
				
				
				])
		} else if signedInAccount?.name == "User 2" {
			callback([
				("10/15 - 10/21", [
//					StudySession(courseTitle: "ASL 235", date: "10/15 1 - 2 pm", roomNumber: "B032", building: "JFSB", numberConfirmed: 3, numberMaybe: 2, numberCanceled: 4, latitude: 40.2483574, longitude: -111.6513684, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
//					StudySession(courseTitle: "ENGL 220", date: "10/17 1:45 - 2:30 pm", roomNumber: "2111", building: "JKB", numberConfirmed: 6, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
//					StudySession(courseTitle: "PHIL 202", date: "10/20 5 - 7 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 1, numberMaybe: 5, numberCanceled: 2, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
					]
				),
				("10/22 - 10/28", [
//					StudySession(courseTitle: "ENGL 220", date: "10/23 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 1, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
//					StudySession(courseTitle: "ENGL 220", date: "10/26 10 - 11 am", roomNumber: "2111", building: "JKB", numberConfirmed: 2, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
//					StudySession(courseTitle: "ASL 235", date: "10/28 3 - 4 pm", roomNumber: "1101", building: "JFSB", numberConfirmed: 0, numberMaybe: 4, numberCanceled: 3, latitude: 40.2483574, longitude: -111.6513684, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
					]
				),
				("10/29 - 11/4", [
//					StudySession(courseTitle: "ASL 235", date: "10/29 8 - 9 pm", roomNumber: "1101", building: "JFSB", numberConfirmed: 0, numberMaybe: 5, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
//					StudySession(courseTitle: "PHIL 202", date: "11/3 3 - 4 pm", roomNumber: "5734", building: "HBL LIB", numberConfirmed: 3, numberMaybe: 0, numberCanceled: 2, latitude: 40.2482096, longitude: -111.6501023, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
//					StudySession(courseTitle: "PHIL 202", date: "11/4 5 - 6 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 2, numberMaybe: 4, numberCanceled: 0, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: []),
//					StudySession(courseTitle: "PHIL 202", date: "11/4 7:30 - 9 pm", roomNumber: "3104", building: "JKB", numberConfirmed: 3, numberMaybe: 1, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
					]
				),
				("11/5 - 11/11", [
//						StudySession(courseTitle: "ENGL 220", date: "11/7 1:45 - 2:30 pm", roomNumber: "2111", building: "JKB", numberConfirmed: 4, numberMaybe: 0, numberCanceled: 3, latitude: 40.249801, longitude: -111.6508399, confirmedStudents: [], maybeStudents: [], canceledStudents: [])
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
				],
						302: [
							("Professor Taylor", 1),
							("Professor Taylor", 2),
							("Professor Taylor", 3),
							("Professor Taylor", 4)
							
				],
						303: [
							("Professor Taylor", 1),
							("Professor Taylor", 2),
							("Professor Taylor", 3),
							("Professor Taylor", 4)
				],
						112: [
							("Professor Lee", 6),
							("Professor Lee", 4),
							("Professor Phong", 1),
							("Professor Phong", 3),
							("Professor Phong", 2),
							("Professor Lee", 5)
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

			],
			  "ENGL": [ 205: [
				("Professor Barker", 5),
				("Professor Barker", 1)
				],
					   316: [
						("Professor Book", 5),
						("Professor Book", 4)
				]
				
				],
			  "PHYSICS": [ 121: [
				("Professor Davis", 1),
				("Professor Davis", 2),
				("Professor Davis", 3),
				("Professor Davis", 4),
				("Professor Davis", 5)
				],
						105: [
							("Professor Book", 5),
							("Professor Book", 4),
							("Professor Davis", 2)
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
