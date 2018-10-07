//
//  SessionsTableViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/27/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

public let LOGIN_NOTIFICATION = NSNotification.Name("LoggedIn")
public let LOGOUT_NOTIFICATION = NSNotification.Name("LoggedOut")

class SessionsTableViewController: UITableViewController {
	
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	private var storedOffsets = [Int: CGFloat]()
	private var sessionsByWeek = [(String, [StudySession])]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadSessions()
		NotificationCenter.default.addObserver(self, selector: #selector(loadSessions), name: LOGIN_NOTIFICATION, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(clearSessions), name: LOGOUT_NOTIFICATION, object: nil)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? SessionViewController,
		   let session = sender as? StudySession {
			slideInTransitioningDelegate.direction = .bottom
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			
			vc.session = session
		}
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sessionsByWeek.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SessionsTableViewCell else {
			return UITableViewCell()
		}
		
		cell.selectionStyle = .none
		cell.sessionsLabel.text = sessionsByWeek[indexPath.row].0
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200.0
	}
	
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let tableViewCell = cell as? SessionsTableViewCell else { return }
		
		tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
		tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
	}
	
	override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let tableViewCell = cell as? SessionsTableViewCell else { return }
		
		storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
	}
	
	//MARK: Private Methods
	
	@objc private func loadSessions() {
		Client.getSessionsByWeek { (response) in
			if let sessionsByWeek = response {
				self.sessionsByWeek = sessionsByWeek
				self.tableView.reloadData()
			} else {
				
			}
		}
	}
	
	@objc private func  clearSessions() {
		sessionsByWeek = []
		self.tableView.reloadData()
	}

}
extension SessionsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SessionCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let session = sessionsByWeek[collectionView.tag].1[indexPath.row]
		cell.courrseTitleLabel.text = session.courseTitle
		cell.dateLabel.text = session.date
		cell.locationLabel.text = "\(session.roomNumber) \(session.building)"
		cell.confirmedLabel.text = "\(session.numberConfirmed)"
		cell.maybeLabel.text = "\(session.numberMaybe)"
		cell.canceledLabel.text = "\(session.numberCanceled)"
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SessionCollectionViewCell else {
			return
		}
		
		cell.configureShadowAndBorder()
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sessionsByWeek[collectionView.tag].1.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showSession", sender: sessionsByWeek[collectionView.tag].1[indexPath.row])
	}
}

