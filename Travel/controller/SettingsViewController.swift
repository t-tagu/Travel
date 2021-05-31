//
//  SettingsViewController.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import UIKit
import MBProgressHUD
import Loaf

class SettingsViewController: UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    } 
    
    private func setupNavigationBar() {
        self.title = K.NavigationTitle.setting
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 0.5) { [weak self] in
            guard let this = self else { return }
            let result = this.authManager.logoutUser()
            switch result {
            case .success:
                MBProgressHUD.hide(for: this.view, animated: true)
                PresenterManager.shared.show(vc: .onboarding)
            case .failure(let error):
                //ここでユーザーにエラ〜メッセージを表示した方が良い
                print(error.localizedDescription)
                Loaf(error.localizedDescription, state: .error, location: .top, sender: this).show()
                MBProgressHUD.hide(for: this.view, animated: true)
            }
        }
    }
    
    
}
