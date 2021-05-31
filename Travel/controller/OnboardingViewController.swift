//
//  OnboardingViewController.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import UIKit

protocol OnboardingDelegate : class {
    func showMainTabBarController()
}

class OnbordingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPageControl()
        setupCollectionView()
        showCaption(atIndex: 0) //これを書かないと最初に表示されるセンテンスがストーリーボードに記述のものになる
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = Slide.collection.count
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground //TODO:これの意味
    }
    
    //ログイン画面へ遷移
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        print("get started button tapped")
        performSegue(withIdentifier: K.segue.showLoginSignup, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segue.showLoginSignup {
            if let destination = segue.destination as? LoginViewController {
                destination.delegate = self
            }
        }
    }
    
    private func showCaption(atIndex index: Int) {
        let slide = Slide.collection[index]
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
}

extension OnbordingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ReuseIdentifier.onboardingCollectionViewCell, for: indexPath) as? OnboardingCollectionViewCell else {
                return UICollectionViewCell()
        }
        let imageName = Slide.collection[indexPath.item].imageName
        let image = UIImage(named: imageName) ?? UIImage()
        cell.configure(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size //セルのサイズをコレクションビューのサイズに合わせている
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //コレクションビューの余白を削除
    }
    
    //スクロールするたびに呼ばれる
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        showCaption(atIndex: index)
        pageControl.currentPage = index
    }
    
    
}

extension OnbordingViewController: OnboardingDelegate {
    
    func showMainTabBarController() {
         //dismiss the login view controller
         //show main tab bar
        
        if let loginViewController = self.presentedViewController as? LoginViewController {
            loginViewController.dismiss(animated: true) {
                PresenterManager.shared.show(vc: .mainTabBarController)
            }
        }
    }
}
