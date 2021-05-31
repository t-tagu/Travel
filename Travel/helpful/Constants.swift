//
//  Constants.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import Foundation

struct K {
    
    struct ReuseIdentifier {
        static let onboardingCollectionViewCell = "cellId"
    }
    
    struct NavigationTitle {
        static let setting = "Settings"
        static let home = "Home"
    }
    
    struct segue {
        static let showOnboarding = "showOnboarding"
        static let showLoginSignup = "showLoginSignup"
    }
    
    struct StoryboardID {
        static let main = "Main"
        static let mainTabBarController = "MainTabBarController"
        static let onboardingViewController = "OnboardingViewController"
    }
}
