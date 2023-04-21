//
//  ViewController.swift
//  CollectionViewOnboarding
//
//  Created by Arsen Mkrtchyan on 04.04.23.
//

import UIKit

class OnboardCollectionViewController: UIViewController {

    weak var collectionView: UICollectionView!
    private let infoTextContent = [
        "Create personalilzed, impressive avatar whit the help powerful Ai technology",
        "It makes professional-looking face retouching available to everyone whit a single tap.No skills are required",
        "It makes professional-looking face retouching available to everyone whit a single tap,",
        "It makes professional-looking face retouching available to everyone whit a single tap",
        "It makes professional-looking face retouching available to everyone whit a single tap",
        "It makes professional-looking face retouching available to everyone whit a single tap"
    ]
    private let nameTextContent = [
        "Magic Avatars",
        "Magic Retouch",
        "Smart Eraser",
        "Pro Adjustmentrs",
        "Beat Sync",
        "Beat Sync"
        
    ]
    private let videoLink = [
        "https://cdn.getglam.app/onboarding/onboarding_270323/3_small5_new.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/2_small_new.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/1_small_new.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/5_small_new_compressed.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/3_small5_new.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/3_small5_new.mp4"
    ]
    
    override func loadView() {
        super.loadView()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(continuePanGesture(_:)))
        cv.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
        cv.isScrollEnabled = true
        view.addSubview(cv)
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: view.topAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        self.collectionView = cv
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.register(OnboardCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.isScrollEnabled = true
       
    }
    
    @objc func continuePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        print(translation.y)
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        if indexPath.row == videoLink.count {
            return
        }
        let indexPathPlus = IndexPath(item: indexPath.row + 1, section: 0);
        
        if let cell = collectionView .cellForItem(at: indexPathPlus) as? OnboardCell
        {
            cell.hiddenContinueViewActione(size: translation.y)
            
        }
    }
    
    private func ContinueButtonTap(at indexPath: IndexPath)  {
        if indexPath.item ==  videoLink.count - 1 {
            
        } else {
            let nextItem = indexPath.item
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.isPagingEnabled = false
            self.collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
            let indexPathPlus = IndexPath(item: indexPath.row , section: 0);
            if let cell = collectionView .cellForItem(at: indexPathPlus) as? OnboardCell
            {
                cell.continueView.alpha = 0
                
            }
            collectionView.isPagingEnabled = true
            
        }
    }
}
// MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension OnboardCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoLink.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! OnboardCell
        cell.titelLabel.text = nameTextContent[indexPath.row]
        cell.infoTextLabel.text = infoTextContent[indexPath.row]
        if indexPath.row != 0 {
            cell.skipButton.isHidden = true
        }
        if indexPath.row == 0 {
            cell.continueView.isHidden = true
        }
        if indexPath.row == 3 {
            cell.continueView.isHidden = false
        }
        if indexPath.row == videoLink.count - 1 {
            cell.continueView.backgroundColor = .yellow
            cell.titelLabel.isHidden = true
            cell.infoTextLabel.isHidden = true
            cell.videoView.isHidden = true
        }
        cell.continueButtonDidTap = { [weak self] in
            self?.ContinueButtonTap(at: indexPath)
        }
        cell.addVideoInView(videoLink[indexPath.row])
        cell.layer.cornerRadius = 30
        cell.clipsToBounds = true
        return cell
    }
    
}
// MARK: UICollectionViewDelegateFlowLayout

extension OnboardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width, height: view.frame.height - 150)
        }else if indexPath.row == videoLink.count - 1 {
            return CGSize(width: view.frame.width, height: 150)
        }
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        let indexPathPlus = IndexPath(item: indexPath.row + 1, section: 0);
        if let cell = collectionView .cellForItem(at: indexPathPlus) as? OnboardCell
        {
            cell.continueView.alpha = 1
        }
    }
    
}
// MARK: UIGestureRecognizerDelegate

extension OnboardCollectionViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
