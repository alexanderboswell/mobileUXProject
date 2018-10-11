//
//  AddCourseViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/9/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

protocol AddCourseProtocol {
	func addCourse(course: Course)
}
class AddCourseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	//MARK: Outlets
	@IBOutlet weak var courseAbbrPickerView: UIPickerView!
	@IBOutlet weak var courseNumberPickerView: UIPickerView!
	@IBOutlet weak var sectionPickerView: UIPickerView!
	@IBOutlet weak var addButton: ActionButton!
	
	//MARK: Private methods
	private var availableCourses = [String:[Int: [(String, Int)]]]()
	var courseAbbrs: [String] = [String]()
	var courseAbbrRow = 0
	var courseNumbers: [String] = [String]()
	var courseNumberRow = 0
	var sections: [(String, Int)] = [(String, Int)]()
	var sectionRow = 0
	var delegate: AddCourseProtocol?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        loadPickerData()
    }
	
	//MARK: Actions
	@IBAction func cancel(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func add(_ sender: Any) {
		delegate?.addCourse(course: Course(courseAbbr: courseAbbrs[courseAbbrRow], courseNumber: Int(courseNumbers[courseNumberRow]) ?? 0, professor: sections[sectionRow].0, section: sections[sectionRow].1))
		self.dismiss(animated: true, completion: nil)
	}
	
	//MARK: UIPickerview delegate and datasource
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView == courseAbbrPickerView {
			return courseAbbrs.count
		} else if pickerView == courseNumberPickerView {
			return courseNumbers.count
		} else {
			return sections.count
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView == courseAbbrPickerView {
			return courseAbbrs[row]
		} else if pickerView == courseNumberPickerView {
			return courseNumbers[row]
		} else {
			return "\(sections[row].0), \(sections[row].1)"
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if pickerView == courseAbbrPickerView {
			
			courseAbbrRow = row
			
			setCourseNumbers(courseAbbr: courseAbbrs[row])
			setSections(courseAbbr: courseAbbrs[row], courseNumber: Int(courseNumbers[0]) ?? 0)
			
			courseNumberPickerView.selectRow(0, inComponent: 0, animated: true)
			sectionPickerView.selectRow(0, inComponent: 0, animated: true)
			
			courseNumberPickerView.reloadAllComponents()
			sectionPickerView.reloadAllComponents()
			
		} else if pickerView == courseNumberPickerView {
			
			courseNumberRow = row
			
			setSections(courseAbbr: courseAbbrs[courseAbbrRow], courseNumber: Int(courseNumbers[row]) ?? 0)
			
			sectionPickerView.selectRow(0, inComponent: 0, animated: true)
			
			sectionPickerView.reloadAllComponents()
		}
		
		enableDisableButton()
	}
	
	//MARK: Private methods
	private func enableDisableButton() {
		if courseAbbrs.count == 0 || courseNumbers.count == 0 || sections.count == 0 {
			addButton.isEnabled = false
		} else {
			addButton.isEnabled = true
		}
	}
	
	private func setCourseNumbers(courseAbbr: String) {
		courseNumbers = []
		if let coursesInAbbr = availableCourses[courseAbbr] {
			for key in coursesInAbbr.keys {
				courseNumbers.append("\(key)")
			}
		}
	}
	private func setSections(courseAbbr: String ,courseNumber: Int) {
		sections = []
		if let coursesInAbbr = availableCourses[courseAbbr] {
			if let sections = coursesInAbbr[courseNumber] {
				for section in sections {
					self.sections.append(section)
				}
			}
		}
	}
	
	private func loadPickerData() {
		Client.getAvailableCourses { (availableCourses) in
			if let availableCourses = availableCourses {
				self.availableCourses = availableCourses
				for (i, course) in availableCourses.enumerated() {
					self.courseAbbrs.append(course.key)
					if i == 0 {
						for (j, courseNumber) in course.value.enumerated() {
							self.courseNumbers.append("\(courseNumber.key)")
							
							if j == 0 {
								for section in courseNumber.value {
									self.sections.append(section)
								}
							}
						}
					}
				}
				self.courseNumberPickerView.reloadAllComponents()
				self.courseAbbrPickerView.reloadAllComponents()
				self.sectionPickerView.reloadAllComponents()
				self.enableDisableButton()
			}
		}
	}
}
