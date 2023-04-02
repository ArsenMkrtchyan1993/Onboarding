//
//  ContentViewController.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 02.04.23.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var poweredButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var continueView: UIView!
    @IBOutlet var videoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    
    var nameText = ""
    var infoText = ""
    var linkForVideo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoView.backgroundColor = .blue
        videoView.clipsToBounds = true
        videoView.layer.cornerRadius = 30
        continueView.clipsToBounds = true
        continueView.layer.cornerRadius = 30
        skipButton.layer.cornerRadius = 15
        skipButton.clipsToBounds = true
        nameLabel.text = nameText
        infoLabel.text = infoText
        
    }
}
