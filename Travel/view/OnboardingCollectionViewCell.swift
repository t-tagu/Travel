//
//  OnboardingCollectionViewCell.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    func configure(image: UIImage) {
        slideImageView.image = image
    }
}
