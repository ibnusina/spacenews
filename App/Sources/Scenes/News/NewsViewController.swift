//
//  OnboardingVC.swift
//  App
//
//  Created by ibnu on 07/09/24.
//

import Foundation
import SwiftUI

class NewsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vc = UIHostingController(
                    rootView:NewsContentView())
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(vc)
        view.addSubview(swiftuiView)
        vc.didMove(toParent: self)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        vc.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
