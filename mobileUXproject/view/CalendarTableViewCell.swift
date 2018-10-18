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
			setupConfirmView()
			setupCancelView()
			setNumbers()
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
	
	private func setupConfirmView() {
		if let response = session.currentResponse, response == .confirmed {
			setConfirmViewOpaque()
		} else {
			setConfirmViewTranslucent()
		}
	}
	
	private func setupCancelView() {
		if let response = session.currentResponse, response == .canceled {
			setCancelViewOpaque()
		} else {
			setCancelViewTranslucent()
		}
	}
	
	private func setConfirmViewOpaque() {
		confirmView.backgroundColor = .confirmColor
		confirmNumberLabel.textColor = .white
		if let confirmImage = UIImage(named: "checkWhite") {
			confirmImageView.image = confirmImage
		}
	}
	
	private func setCancelViewOpaque() {
		cancelView.backgroundColor = .cancelColor
		cancelNumberLabel.textColor = .white
		if let cancelImage = UIImage(named: "xWhite") {
			cancelImageView.image = cancelImage
		}
	}
	
	private func setConfirmViewTranslucent() {
		confirmView.backgroundColor = .white
		confirmNumberLabel.textColor = .confirmColor
		if let confirmImage = UIImage(named: "check") {
			confirmImageView.image = confirmImage
		}
	}
	
	private func setCancelViewTranslucent() {
		cancelView.backgroundColor = .white
		cancelNumberLabel.textColor = .cancelColor
		
		if let cancelImage = UIImage(named: "x") {
			cancelImageView.image = cancelImage
		}
	}
	
	private func setNumbers() {
		confirmNumberLabel.text = "\(session.numberConfirmed)"
		cancelNumberLabel.text = "\(session.numberCanceled)"
	}
	
	private func setLabels() {
		courseTitleLabel.text =  session.courseTitle
		timeLabel.text = session.date
		locationLabel.text =  "\(session.roomNumber) \(session.building)"
	}
	
	@objc private func handleConfirmTap(_ sender: UITapGestureRecognizer) {
		impact.impactOccurred()

		setConfirmViewOpaque()
		setCancelViewTranslucent()
		
		if session.currentResponse == nil || session.currentResponse != .confirmed {
			session.numberConfirmed += 1
			
			if session.currentResponse == .canceled {
				session.numberCanceled -= 1
			}
			
			session.currentResponse = .confirmed
		}
		setNumbers()
		
		NotificationCenter.default.post(name: ADDED_STUDY_SESSION_NOTIFICATION, object: session)
	}
	
	@objc private func handleCancelTap(_ sender: UITapGestureRecognizer) {
		impact.impactOccurred()
		
		setCancelViewOpaque()
		setConfirmViewTranslucent()
		
		
		if session.currentResponse == nil || session.currentResponse != .canceled {
			session.numberCanceled += 1
			
			if session.currentResponse == .confirmed {
				session.numberConfirmed -= 1
			}
			session.currentResponse = .canceled
		}
		setNumbers()
		
		NotificationCenter.default.post(name: REMOVED_STUDY_SESSION_NOTIFICATION, object: session)
	}
}


