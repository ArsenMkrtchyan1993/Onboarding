//
//  OnboardCollectionViewController.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 01.04.23.
//

import UIKit

private let reuseIdentifier = "cellId"

class OnboardCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        // Configure the cell
        
        return cell
    }
}
