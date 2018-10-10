//
//  SlideInPresentationManager.swift
//  mobileUXproject
//
//  Created by alexander boswell on 9/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import UIKit

enum PresentationAmount {
	case Ratio2_6
	case Ratio3_6
	case Ratio4_6
	case Ratio5_6
}

class SlideInPresentationManager: NSObject {
	
	var screenAmount = PresentationAmount.Ratio5_6
	
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
	func presentationController(forPresented presented: UIViewController,
								presenting: UIViewController?,
								source: UIViewController) -> UIPresentationController? {
		let presentationController = SlideInPresentationController(presentedViewController: presented,
																   presenting: presenting,
																   amount: screenAmount)
		return presentationController
	}
}
