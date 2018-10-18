//
//  CalendarViewController.swift
//  mobileUXproject
//
//  Created by alexander boswell on 10/15/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController, FilterProtocol {

	@IBOutlet private weak var calendarView: JTAppleCalendarView!
	@IBOutlet private weak var monthYearLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var noSessionsLabel: UILabel!
	
	let formatter = DateFormatter()
	var savedDates = [String: Date]()
	var filters = [String]()
	var sessions = [StudySession]()
	
	var courseTitles: [String] {
		var courseTitles:Set = Set<String>()
		for key in sessionsForDate.keys {
			for session in sessionsForDate[key] ?? [] {
				courseTitles.insert(session.courseTitle)
			}
		}
		
		return Array(courseTitles)
	}
	
	var sessionsForDate = [Date: [StudySession]]()
	lazy var slideInTransitioningDelegate = SlideInPresentationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupCalendarView()
		tableView.tableFooterView = UIView()
		loadData()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		loadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? FilterViewController {
			slideInTransitioningDelegate.screenAmount = .Ratio3_6
			vc.transitioningDelegate = slideInTransitioningDelegate
			vc.modalPresentationStyle = .custom
			
			vc.slideInTransitioningDelegate = slideInTransitioningDelegate
			vc.filters = filters
			vc.courseTitles = courseTitles
			vc.delegate = self
		}
	}
	
	//MARK: FilterProtocol
	
	func addFilter(courseTitle: String) {
		filters.append(courseTitle)
		loadData()
	}
	
	func removeFilter(courseTitle: String) {
		filters.removeAll { (filter) -> Bool in
			return filter == courseTitle
		}
		loadData()
	}
	
	private func setupCalendarView() {
		// setup collection view cell insets
		calendarView.minimumLineSpacing = 0
		calendarView.minimumInteritemSpacing = 0
		calendarView.allowsMultipleSelection = false
		
		// setup year and month labels
		calendarView.visibleDates { (visibleDates) in
			self.setYearAndMonthLabels(visibleDates: visibleDates)
			let selectedDate = self.getSelectedDate(visibleDates: visibleDates)
			self.calendarView.selectDates([selectedDate])
			self.loadDataForDate(date: selectedDate)
		}
	}
	
	private func saveSelectedDate(date: Date) {
		savedDates[getKey(date: date)] = date
	}
	
	private func getKey(date: Date) -> String {
		formatter.dateFormat = "yyyy"
		let year =  formatter.string(from: date)
		formatter.dateFormat = "MMMM"
		let month = formatter.string(from: date)
		return "\(month)-\(year)"
	}
	
	private func getSelectedDate(visibleDates: DateSegmentInfo) -> Date {
		if let firstDayOfMonth = visibleDates.monthDates.first?.date {
			if let date = savedDates[getKey(date: firstDayOfMonth)] {
				return date
			} else {
				saveSelectedDate(date: firstDayOfMonth)
				return firstDayOfMonth
				
			}
		} else {
			return Date()
		}
	}
	
	private func handleTextSelected(cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarCollectionViewCell else { return }
		
		if cellState.isSelected {
			cell.selectedView.isHidden = false
			cell.sessionsIndictatorView.backgroundColor = .white
		} else {
			cell.selectedView.isHidden = true
			cell.sessionsIndictatorView.backgroundColor = .black
		}
	}
	
	private func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarCollectionViewCell else { return }
		
		if cellState.isSelected {
			cell.dateLabel.textColor = .white
			cell.sessionsIndictatorView.backgroundColor = .white
		} else {
			if cellState.dateBelongsTo == .thisMonth {
				cell.dateLabel.textColor = .black
				cell.sessionsIndictatorView.backgroundColor  = .black
			} else {
				cell.dateLabel.textColor = .gray
				cell.sessionsIndictatorView.backgroundColor = .gray
			}
		}
	}
	
	private func handleSessionIndicatorHidden(cell: CalendarCollectionViewCell, date: Date) {
		if let sessions = sessionsForDate[date], sessions.count != 0 {
			cell.sessionsIndictatorView.isHidden = false
		} else {
			cell.sessionsIndictatorView.isHidden = true
		}
	}
	
	private func setYearAndMonthLabels(visibleDates: DateSegmentInfo) {
		if let date = visibleDates.monthDates.first?.date {
			formatter.dateFormat = "yyyy"
			let year =  formatter.string(from: date)
			formatter.dateFormat = "MMMM"
			monthYearLabel.text = "\(formatter.string(from: date)) \(year)"
		}
	}
	
	private func loadData() {
		Client.getSessions { (sessionsForDate) in
//			self.sessionsForDate = self.checkFilters(sessionsForDate: sessionsForDate)
			self.sessionsForDate = sessionsForDate
			
			self.calendarView.visibleDates { (visibleDates) in
				self.loadDataForDate(date: self.getSelectedDate(visibleDates: visibleDates))
				self.calendarView.reloadData()
			}
		}
	}
	
//	private func checkFilters(sessionsForDate: [Date: [StudySession]]) -> [Date: [StudySession]] {
//		var newSessionsForDate = sessionsForDate
//		for key in newSessionsForDate.keys {
//			for (i, session) in (newSessionsForDate[key] ?? []).enumerated() {
//				if filters.contains(session.courseTitle) {
//					newSessionsForDate[key]?.remove(at: i)
//				}
//			}
//		}
//		return newSessionsForDate
//	}
	
	private func loadDataForDate(date: Date) {
		if let sessions = sessionsForDate[date] {
			self.sessions = sessions
			self.noSessionsLabel.isHidden = true
		} else {
			self.sessions = []
			self.noSessionsLabel.isHidden = false
		}
		
		UIView.animate(withDuration: 0.3, animations: {
			self.tableView.reloadData()
		})
		tableView.scrollToTop(animated: false)
	}

}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sessions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "calendarTableCell", for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }
		
		cell.session = sessions[indexPath.row]
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 88.0
	}
	
}

extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCollectionViewCell else { return }
		
		handleTextSelected(cell: cell, cellState: cellState)
		handleCellTextColor(cell: cell, cellState: cellState)
		handleSessionIndicatorHidden(cell: cell, date: date)
		cell.dateLabel.text = cellState.text
	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCollectionViewCell else {
			return JTAppleCell()
		}
		
		handleTextSelected(cell: cell, cellState: cellState)
		handleCellTextColor(cell: cell, cellState: cellState)
		handleSessionIndicatorHidden(cell: cell, date: date)
		cell.dateLabel.text = cellState.text
		return cell
	}
	
	
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		if cellState.dateBelongsTo == .previousMonthOutsideBoundary || cellState.dateBelongsTo == .followingMonthWithinBoundary {
			calendarView.deselect(dates: [date])
		} else {
			handleTextSelected(cell: cell, cellState: cellState)
			handleCellTextColor(cell: cell, cellState: cellState)
			saveSelectedDate(date: date)
			
			loadDataForDate(date: date)
		}
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		handleTextSelected(cell: cell, cellState: cellState)
		handleCellTextColor(cell: cell, cellState: cellState)
	}
	
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		formatter.locale = Calendar.current.locale
		
		let startDate = formatter.date(from: "2018 10 01")
		let endDate = formatter.date(from: "2018 12 31")
		
		let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!, generateInDates: .forAllMonths, generateOutDates: .tillEndOfRow)
		return parameters
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
		setYearAndMonthLabels(visibleDates: visibleDates)
		calendarView.selectDates([getSelectedDate(visibleDates: visibleDates)])
	}
}
