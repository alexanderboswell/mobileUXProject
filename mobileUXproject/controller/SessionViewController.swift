//
//  SessionViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit
import MapKit

class SessionViewController: UIViewController, MKMapViewDelegate {

	//MARK: Outlets
	
	@IBOutlet private weak var courseTitleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var confirmedMembersLabel: UILabel!
	@IBOutlet weak var maybeMembersLabel: UILabel!
	@IBOutlet weak var canceledMembersLabel: UILabel!
	@IBOutlet weak var respondButton: UIButton!
	@IBOutlet weak var mapView: MKMapView!
	
	var session: StudySession!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		courseTitleLabel.text = session.courseTitle
		dateLabel.text = session.date
		locationLabel.text = "\(session.roomNumber) \(session.building)"
		confirmedMembersLabel.text = session.comfirmedStudents.joined(separator: ", ")
		maybeMembersLabel.text = session.maybeStudents.joined(separator: ", ")
		canceledMembersLabel.text = session.canceledStudents.joined(separator: ", ")
		
		let mapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.mapTap(_:)))
		mapView.addGestureRecognizer(mapTapRecognizer)
		
		centerMapOnLocation(location: CLLocation(latitude: session.latitude, longitude: session.longitude))
		mapView.addAnnotation(session)
	}
	
	//MARK: Actions
	
	@IBAction func response(_ sender: UIButton) {
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
	
	//MARK: Private methods
	
	func centerMapOnLocation(location: CLLocation) {
		let regionRadius: CLLocationDistance = 250
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: false)
	}
}
