//
//  OnboardCell.swift
//  CollectionViewOnboarding
//
//  Created by Arsen Mkrtchyan on 04.04.23.
//

import UIKit
import AVFoundation
import AVKit

class OnboardCell: UICollectionViewCell {
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    weak var titelLabel: UILabel!
    weak var skipButton: UIButton!
    weak var infoTextLabel: UILabel!
    weak var videoView: UIView!
    weak var continueView: UIView!
    weak var poweredByButton: UIButton!
    var nameText = ""
    var infoText = ""
    var linkForVideo = ""
    var currentPage = 0
    var continueButtonDidTap: (()->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        let clickGesture = UITapGestureRecognizer(target: self, action:  #selector(self.tapOnContinue))
        continueView.addGestureRecognizer(clickGesture)
    }
    
    
    @objc func tapOnContinue(sender : UITapGestureRecognizer) {
        continueButtonDidTap?()
    }
    
    
    func setupElements() {
        
        let videView = UIView()
        videView.translatesAutoresizingMaskIntoConstraints = true
        contentView.addSubview(videView)
        self.videoView = videView
        NSLayoutConstraint.activate([
            videView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            videView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        
        let continueView = UIView()
        let continueLabel = UILabel()
        continueLabel.text = "Continue"
        continueLabel.textAlignment = .center
        continueView.backgroundColor = .lightGray
        continueView.translatesAutoresizingMaskIntoConstraints = false
        continueLabel.translatesAutoresizingMaskIntoConstraints = false
        continueView.addSubview(continueLabel)
        NSLayoutConstraint.activate([
            continueLabel.topAnchor.constraint(equalTo: continueView.topAnchor, constant: 20),
            continueLabel.centerXAnchor.constraint(equalTo: continueView.centerXAnchor)
       
        ])
        self.continueView = continueView
        contentView.addSubview(continueView)
        NSLayoutConstraint.activate([
            continueView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            continueView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            continueView.widthAnchor.constraint(equalToConstant:contentView.frame.width)
            
        ])
        let skipBt = UIButton()
        skipBt.translatesAutoresizingMaskIntoConstraints = false
        skipBt.setTitle("Skip", for: .normal)
        skipBt.backgroundColor = .lightGray
        skipBt.clipsToBounds = true
        skipBt.layer.cornerRadius = 15
        skipButton = skipBt
        contentView.addSubview(skipBt)
        NSLayoutConstraint.activate([
            skipBt.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            skipBt.heightAnchor.constraint(equalToConstant: 35),
            skipBt.widthAnchor.constraint(equalToConstant: 70),
            skipBt.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        let poweredByButton = UIButton()
        poweredByButton.translatesAutoresizingMaskIntoConstraints = false
        poweredByButton.setTitle(" Powered by IA ", for: .normal)
        poweredByButton.setTitleColor(.black, for: .normal)
        poweredByButton.backgroundColor = .yellow
        poweredByButton.clipsToBounds = true
        poweredByButton.layer.cornerRadius = 10
        self.poweredByButton = poweredByButton
        contentView.addSubview(poweredByButton)
        NSLayoutConstraint.activate([
            poweredByButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150),
            poweredByButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: +20)
        ])
        
        let titelLabel = UILabel()
        titelLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titelLabel = titelLabel
        titelLabel.textColor = .white
        titelLabel.font = UIFont.systemFont(ofSize: 29.0)
        contentView.addSubview(titelLabel)
        NSLayoutConstraint.activate([
            titelLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
            titelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: +20)
        ])
        
        let infoTextLabel = UILabel()
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoTextLabel = infoTextLabel
        infoTextLabel.textColor = .lightGray
        infoTextLabel.font = UIFont.systemFont(ofSize: 14.0)
        infoTextLabel.numberOfLines = 3
        contentView.addSubview(infoTextLabel)
        NSLayoutConstraint.activate([
            infoTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
            infoTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: +20),
            infoTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
    }
    
    func hiddenContinueViewActione(size: Double) {
       var newSize = size
        if size < 0 {
            newSize = -(size)
            continueView.alpha = 1
            continueView.alpha = CGFloat(continueView.alpha - (newSize / 150))
        } else {
            return
        }
        
    }
    
    func addVideoInView(_ url: String) {
        let videoURL = URL(string: url)
        player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = contentView.bounds
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
       
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                let t1 = CMTimeMake(value: 5, timescale: 100)
                self.player.seek(to: t1)
                self.player.play()
            }
        })
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
