//
//  RMBaseViewController.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import UIKit

// MARK: RMBaseViewController

class RMBaseViewController: UIViewController {
    
    let child = RMSpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: RMBaseViewController - Mannage Spinner

extension RMBaseViewController {
    
    func showSpinner() {
        DispatchQueue.main.async {
            self.addChild(self.child)
            self.child.view.frame = self.view.frame
            self.view.addSubview(self.child.view)
            self.child.didMove(toParent: self)
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
}
