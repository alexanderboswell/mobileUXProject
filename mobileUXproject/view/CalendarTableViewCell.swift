//
//  CalendarTableViewCell.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/16/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

public let ADDED_STUDY_SESSION_NOTIFICATION = NSNotification.Name("AddedStudySession")
public let REMOVED_STUDY_SESSION_NOTIFICATION = NSNotification.Name("RemovedStudySession")

class CalendarTableViewCell: UITableViewCell {

	@IBOutlet weak var confirmView: UIView!
	@IBOutlet weak var confirmImageView: UIImageView!
	@IBOutlet weak var confirmNumberLabel: UILabel!
	
	@IBOutlet weak var cancelView: UIView!
	@IBOutlet weak var cancelImageView: UIImageView!
	@IBOutlet weak var cancelNumberLabel: UILabel!
	
	@IBOutlet weak var courseTitleLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	
	private let impact = UIImpactFeedbackGenerator()
	
	var session: StudySession! {
		didSet {
			
			if let response = session.currentResponse, response == .confirmed {
				cancelView.isHidden = false
				confirmView.isHidden = true
			} else {
				cancelView.isHidden =  true
				confirmView.isHidden = false
			}
//			setNumbers()
			setLabels()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		confirmView.addBorder(color: UIColor.confirmColor)
		cancelView.addBorder(color: UIColor.cancelColor)
		
		let confirmRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleConfirmTap(_:)))
		confirmView.addGestureRecognizer(confirmRecognizer)
		
		let cancelRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCancelTap(_:)))
		cancelView.addGestureRecognizer(cancelRecognizer)
    }
	
	private func setNumbers() {
		confirmNumberLabel.text = "\(session.numberConfirmed)"
	}
	
	private func setLabels() {
		courseTitleLabel.text =  session.courseTitle
		timeLabel.text = session.date
		locationLabel.text =  "\(session.roomNumber) \(session.building)"
	}
	
	@objc private func handleConfirmTap(_ sender: UITapGestureRecognizer) {
		impact.impactOccurred()
		
		confirmView.isHidden = true
		cancelView.isHidden = false
		
		
		if session.currentResponse == nil || session.currentResponse != .confirmed {
			session.numberConfirmed += 1
			
//			if session.currentResponse == .canceled {
//				session.numberCanceled -= 1
//			}
			
			session.currentResponse = .confirmed
		}
//		setNumbers()
		
		NotificationCenter.default.post(name: ADDED_STUDY_SESSION_NOTIFICATION, object: session)
	}
	
	@objc private func handleCancelTap(_ sender: UITapGestureRecognizer) {
		impact.impactOccurred()
		
		confirmView.isHidden = false
		cancelView.isHidden = true

		
		if session.currentResponse == nil || session.currentResponse != .canceled {
//			session.numberCanceled += 1
			
			if session.currentResponse == .confirmed {
				session.numberConfirmed -= 1
			}
			session.currentResponse = .canceled
		}
//		setNumbers()
		
		NotificationCenter.default.post(name: REMOVED_STUDY_SESSION_NOTIFICATION, object: session)
	}
}


