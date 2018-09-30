//
//  SessionsTableViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/27/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

class SessionsTableViewController: UITableViewController {
	
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	private var storedOffsets = [Int: CGFloat]()
	private var sessionsByWeek = [(String, [StudySession])]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadSessions()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let controller = segue.destination as? SessionViewController {
			slideInTransitioningDelegate.direction = .bottom
			controller.transitioningDelegate = slideInTransitioningDelegate
			controller.modalPresentationStyle = .custom
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
	
	private func loadSessions() {
		Client.getSessionsByWeek { (response) in
			if let sessionsByWeek = response {
				self.sessionsByWeek = sessionsByWeek
				self.tableView.reloadData()
			} else {
				
			}
		}
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

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sessionsByWeek[collectionView.tag].1.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showSession", sender: nil)
	}
}

