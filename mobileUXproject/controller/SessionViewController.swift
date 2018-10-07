//
//  SessionViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {

	@IBOutlet private weak var courseTitleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var confirmedMembersLabel: UILabel!
	@IBOutlet weak var maybeMembersLabel: UILabel!
	@IBOutlet weak var canceledMembersLabel: UILabel!
	@IBOutlet weak var respondButton: UIButton!

	var session: StudySession!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		courseTitleLabel.text = session.courseTitle
		dateLabel.text = session.date
		locationLabel.text = "\(session.roomNumber) \(session.building)"
		confirmedMembersLabel.text = session.comfirmedStudents.joined(separator: ", ")
		maybeMembersLabel.text = session.maybeStudents.joined(separator: ", ")
		canceledMembersLabel.text = session.canceledStudents.joined(separator: ", ")
	}
	
	@IBAction func response(_ sender: UIButton) {
	}
	@IBAction func close(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}
