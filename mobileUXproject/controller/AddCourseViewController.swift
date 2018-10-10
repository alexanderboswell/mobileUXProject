//
//  AddCourseViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/9/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	//MARK: Outlets
	@IBOutlet weak var courseAbbrPickerView: UIPickerView!
	@IBOutlet weak var courseNumberPickerView: UIPickerView!
	@IBOutlet weak var sectionPickerView: UIPickerView!
	
	//MARK: Private methods
	private var availableCourses = [String:[Int: [(String, Int)]]]()
	private var courseAbbr = [String]()
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        loadPickerData()
    }
	
	//MARK: Actions
	@IBAction func cancel(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	//MARK: UIPickerview delegate and datasource
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView == courseAbbrPickerView {
			
		} else if pickerView == courseNumberPickerView {
			
		} else {
			
		}
		
		return 0
	}
	
//	override func viewDidLoad() {
//		self.listOfMakes = Array(carDictionary.keys)
//		let firstCar = listOfMakes[0]
//		let modelsDictionary = carList[firstCar]! as  Dictionary<String, Dictionary<String, String>>
//		self.listOfModels = Array(modelsDictionary.keys).sort()
//		let firstModel = listOfModels[0]
//		let yearsDictionary = modelsDictionary[firstModel]! as Dictionary<String, String>
//		self.listOfYears = Array(yearsDictionary.keys).sort()
//
//	}
	
	//MARK: Private methods
	private func loadPickerData() {
		Client.getAvailableCourses { (availableCourses) in
			if let availableCourses = availableCourses {
				self.availableCourses = availableCourses
			} else {
				//error
			}
		}
	}
}
