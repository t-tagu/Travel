//
//  LoadingViewController.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/20.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(durationInSeconds: 2.0) {
            self.showInitialView()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //２秒間ディレイする
//            self.showInitialView()
//        }
    }
    
    private func showInitialView() {
        
        if authManager.isUserLoggedIn() {
            PresenterManager.shared.show(vc: .mainTabBarController)
            
//            //ログインしていたらタブバーコントローラーをルートにセットする
//            let mainTabBarController = UIStoryboard(name: K.StoryboardID.main, bundle: nil).instantiateViewController(identifier: K.StoryboardID.mainTabBarController)
//            //安全性を考えてif letを使って書く
//            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
//               let window = sceneDelegate.window {
//                window.rootViewController = mainTabBarController
//            }
            
        } else {
            performSegue(withIdentifier: K.segue.showOnboarding, sender: nil)
        }
        
    }
}
