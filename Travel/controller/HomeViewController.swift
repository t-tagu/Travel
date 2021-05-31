//
//  HomeViewController.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        seutpViews()
    }
    
    private func setupNavigationBar() {
        self.title = K.NavigationTitle.home
    }
    
    private func seutpViews() {
        
        if let email = Auth.auth().currentUser?.email {
            emailLabel.text = email
        } else {
            emailLabel.text = "Something is terribly wrong!"
        }
    }
    
}
