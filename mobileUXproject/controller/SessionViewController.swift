//
//  SessionViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit
import MapKit
import EventKit
import EventKitUI

protocol ResponseToSessionProtocol {
	func reloadCell(session: StudySession)
}

class SessionViewController: UIViewController, MKMapViewDelegate {

	//MARK: Outlets
	
	@IBOutlet private weak var courseTitleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var monthDayLabel: UILabel!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var confirmedLabel: UILabel!
	@IBOutlet weak var canceledLabel: UILabel!
	@IBOutlet weak var addToCalendarView: UIView!
	
	var session: StudySession!
	var slideInTransitioningDelegate: SlideInPresentationManager!
	var delegate: ResponseToSessionProtocol?
	private let impact = UIImpactFeedbackGenerator()
	let store = EKEventStore()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
	}
	
	//MARK: Actions
	
	@IBAction func close(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func leaveSession(_ sender: UIButton) {
		impact.impactOccurred()
		session.currentResponse = .canceled
		delegate?.reloadCell(session: session)
		self.dismiss(animated: true, completion: nil)
	}
	
	
	@objc func mapTap(_ sender: UITapGestureRecognizer) {
		impact.impactOccurred()
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
	
	@objc func addToCalendarTap(_ sender: UITapGestureRecognizer) {
		impact.impactOccurred()
		createEvent(title: "Study Session for \(session.courseTitle)", location: "\(session.roomNumber) \(session.building)", startDate: session.startDate, endDate: session.endDate)
	}
	
	func createEvent(title: String, location: String, startDate: Date, endDate: Date) {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy MM dd hh:mm a"
		// create the event object
		
		let event = EKEvent(eventStore: store)
		event.title = title
		event.location = location
		event.calendar = store.defaultCalendarForNewEvents
		event.startDate = startDate
		event.endDate = endDate
		
		// prompt user to add event (to whatever calendar they want)
		
		let controller = EKEventEditViewController()
		controller.event = event
		controller.eventStore = store
		controller.editViewDelegate = self
		
		store.requestAccess(to: .event) { (answer, error) in
			
			self.present(controller, animated: true, completion: nil)
		}
	}
	
	private func centerMapOnLocation(location: CLLocation) {
		let regionRadius: CLLocationDistance = 250
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: false)
	}
	
	private func setupUI() {
		courseTitleLabel.text = session.courseTitle
		monthDayLabel.text = "\(session.month) \(session.day)"
		dateLabel.text = session.date
		locationLabel.text = "\(session.roomNumber) \(session.building)"
		setNumbers()
		
		let mapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.mapTap(_:)))
		mapView.addGestureRecognizer(mapTapRecognizer)
		centerMapOnLocation(location: CLLocation(latitude: session.latitude, longitude: session.longitude))
		mapView.addAnnotation(session)
		
		let addToCalendarTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.addToCalendarTap(_:)))
		addToCalendarView.addGestureRecognizer(addToCalendarTapRecognizer)
		
	}
	
	private func setNumbers() {
		confirmedLabel.text = "\(session.numberConfirmed)"
		canceledLabel.text = "\(session.numberCanceled)"
	}
}


extension SessionViewController: EKEventEditViewDelegate {
	
	func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
		self.dismiss(animated: true, completion: nil)
	}
}
