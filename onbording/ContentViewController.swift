//
//  ContentViewController.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 02.04.23.
//

import UIKit
import AVFoundation
import AVKit

class ContentViewController: UIViewController {

    @IBOutlet weak var poweredButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var continueView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet var videoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    
    var delegat: NextOnboard?
    var nameText = ""
    var infoText = ""
    var linkForVideo = ""
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
        homeView.backgroundColor = .blue
        continueView.clipsToBounds = true
        continueView.isHidden = true
        continueView.layer.cornerRadius = 30
        skipButton.layer.cornerRadius = 15
        skipButton.clipsToBounds = true
        nameLabel.text = nameText
        infoLabel.text = infoText
        if currentPage > 0 {
            skipButton.isHidden = true
        }
        let clickGesture = UITapGestureRecognizer(target: self, action:  #selector(self.onUiViewClick))
        continueView.addGestureRecognizer(clickGesture)
    }
    
    
    private func setupVideo() {
        let videoURL = URL(string: linkForVideo)
        player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        player.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                let t1 = CMTimeMake(value: 5, timescale: 100)
                self.player.seek(to: t1)
                self.player.play()
            }
        })
        videoView.backgroundColor = .black
        videoView.clipsToBounds = true
        videoView.layer.cornerRadius = 30
    }
    
    @objc func onUiViewClick(sender : UITapGestureRecognizer) {
        delegat?.continueButton()
    }
}
extension CGRect {
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        
        self.init(x:x, y:y, width:w, height:h)
    }
}
