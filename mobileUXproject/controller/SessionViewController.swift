//
//  SessionViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit
import MapKit

protocol ResponseToSessionProtocol {
	func reloadCell(session: StudySession)
}

class SessionViewController: UIViewController, MKMapViewDelegate {

	//MARK: Outlets
	
	@IBOutlet private weak var courseTitleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var respondButton: UIButton!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var confirmedView: UIView!
	@IBOutlet weak var maybeView: UIView!
	@IBOutlet weak var canceledView: UIView!
	@IBOutlet weak var confirmedLabel: UILabel!
	@IBOutlet weak var maybeLabel: UILabel!
	@IBOutlet weak var canceledLabel: UILabel!
	@IBOutlet weak var confirmedImageView: UIImageView!
	@IBOutlet weak var maybeImageView: UIImageView!
	@IBOutlet weak var canceledImageView: UIImageView!
	
	var session: StudySession!
	var slideInTransitioningDelegate: SlideInPresentationManager!
	var delegate: ResponseToSessionProtocol?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
	}
	
	//MARK: Actions
	 
	@IBAction func confirmed(_ sender: Any) {
		confirmedImageView.image = UIImage(named: "check")
		maybeImageView.image = UIImage(named: "questionGrey")
		canceledImageView.image = UIImage(named: "xGrey")
		
		if session.currentResponse == nil || session.currentResponse != .confirmed {
			session.numberConfirmed += 1
			
			if session.currentResponse == .maybe {
				session.numberMaybe -= 1
			} else if session.currentResponse == .canceled {
				session.numberCanceled -= 1
			}
			
			session.currentResponse = .confirmed
			delegate?.reloadCell(session: session)
		}
		setNumbers()
	}
	
	@IBAction func maybe(_ sender: Any) {
		confirmedImageView.image = UIImage(named: "checkGrey")
		maybeImageView.image = UIImage(named: "question")
		canceledImageView.image = UIImage(named: "xGrey")
		
		if session.currentResponse == nil || session.currentResponse != .maybe {
			session.numberMaybe += 1
			
			if session.currentResponse == .confirmed {
				session.numberConfirmed -= 1
			} else if session.currentResponse == .canceled {
				session.numberCanceled -= 1
			}
			
			session.currentResponse = .maybe
			delegate?.reloadCell(session: session)
		}
		setNumbers()
		
	}
	
	@IBAction func canceled(_ sender: Any) {
		confirmedImageView.image = UIImage(named: "checkGrey")
		maybeImageView.image = UIImage(named: "questionGrey")
		canceledImageView.image = UIImage(named: "x")
		
		if session.currentResponse == nil || session.currentResponse != .canceled {
			session.numberCanceled += 1
			
			if session.currentResponse == .confirmed {
				session.numberConfirmed -= 1
			} else if session.currentResponse == .maybe {
				session.numberMaybe -= 1
			}
			session.currentResponse = .canceled
			delegate?.reloadCell(session: session)
		}
		setNumbers()
	}
	
	@IBAction func close(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@objc func mapTap(_ sender: UITapGestureRecognizer) {
		let coordinate = CLLocationCoordinate2DMake(session.latitude, session.longitude)
		let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.01))
		let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
		let mapItem = MKMapItem(placemark: placemark)
		let options = [
			MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
			MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
		mapItem.name = session.building
		mapItem.openInMaps(launchOptions: options)
	}
	
	@objc func confirmedStudentsTap(_ sender: UITapGestureRecognizer) {
		performSegue(withIdentifier: "showStudents", sender: session.confirmedStudents)
	}
	
	@objc func maybeStudentsTap(_ sender: UITapGestureRecognizer) {
		performSegue(withIdentifier: "showStudents", sender: session.maybeStudents)
	}
	
	@objc func canceledStudentsTap(_ sender: UITapGestureRecognizer) {
		performSegue(withIdentifier: "showStudents", sender: session.canceledStudents)
	}
	
	//MARK: Private methods
	
	private func centerMapOnLocation(location: CLLocation) {
		let regionRadius: CLLocationDistance = 250
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: false)
	}
	
	private func setupUI() {
		courseTitleLabel.text = session.courseTitle
		dateLabel.text = session.date
		locationLabel.text = "\(session.roomNumber) \(session.building)"
		setNumbers()
		
		let mapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.mapTap(_:)))
		mapView.addGestureRecognizer(mapTapRecognizer)
		centerMapOnLocation(location: CLLocation(latitude: session.latitude, longitude: session.longitude))
		mapView.addAnnotation(session)
		
		if let response = session.currentResponse {
			if response == .confirmed {
				maybeImageView.image = UIImage(named: "questionGrey")
				canceledImageView.image = UIImage(named: "xGrey")
			} else if response == .maybe {
				confirmedImageView.image = UIImage(named: "checkGrey")
				canceledImageView.image = UIImage(named: "xGrey")
			} else if response == .canceled {
				maybeImageView.image = UIImage(named: "questionGrey")
				confirmedImageView.image = UIImage(named: "checkGrey")
			}
		}
	}
	
	private func setNumbers() {
		confirmedLabel.text = "\(session.numberConfirmed)"
		maybeLabel.text = "\(session.numberMaybe)"
		canceledLabel.text = "\(session.numberCanceled)"
	}
}
