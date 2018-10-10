//
//  CourseViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/8/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {

	//MARK: Outlets
	@IBOutlet private weak var courseLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	
	//MARK: Public variables
	var course: Course!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		courseLabel.text = course.title
		descriptionLabel.text = "Section \(course.section), \(course.professor)"
    }
	
	//MARK: Actions
	@IBAction func dismiss(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
}
