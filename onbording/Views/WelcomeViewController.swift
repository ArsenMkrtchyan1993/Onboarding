//
//  ViewController.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 31.03.23.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var allInLabel: UILabel!
    @IBOutlet weak var ligiImageView: UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var agreeLabel: UITextView!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var viewForButton: UIView!
    @IBOutlet weak var agreeView: UIView!
    var isAgree = false
    let agreeMessage = "I agree to the Terms of use and acknowledge I have read the Privacy Policy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let clickGesture = UITapGestureRecognizer(target: self, action:  #selector(self.onUiViewClick))
        viewForButton.addGestureRecognizer(clickGesture)
        
    }
    @objc func onUiViewClick(sender : UITapGestureRecognizer) {
        if isAgree {
            onClickView()
           
            let onboardVC = OnboardCollectionViewController()
            onboardVC.modalPresentationStyle = .fullScreen
            self.present(onboardVC, animated: true)
        }else {
            agreeView.shake()
        }
    }
    
    func startOnboardVc() {
        let onboardVC = OnboardCollectionViewController()
        onboardVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
        {
            self.present(onboardVC, animated: true)
        }
    }
    
    
    func onClickView() {
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.ligiImageView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.ligiImageView.alpha = 0
                self.ligiImageView.transform = self.ligiImageView.transform.translatedBy(x: 0, y: -200)
            }, completion: nil)
        }
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.allInLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.allInLabel.alpha = 0
                self.allInLabel.transform = self.allInLabel.transform.translatedBy(x: 0, y: -200)
            }, completion: nil)
        }
        UIView.animate(withDuration: 0.7, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.nameLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.nameLabel.alpha = 0
                self.nameLabel.transform = self.nameLabel.transform.translatedBy(x: 0, y: -200)
            }, completion: nil)
        }
        
    
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.agreeView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.agreeView.alpha = 0
                self.agreeView.transform = self.agreeView.transform.translatedBy(x:0, y:200)
            }, completion: nil)
        }
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.viewForButton.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.viewForButton.alpha = 0
                self.viewForButton.transform = self.viewForButton.transform.translatedBy(x:0, y:200)
            }, completion: nil)
        }
        
    }
    
    func setupUI() {
        view.backgroundColor = .black
        allInLabel.numberOfLines = 2
        agreeLabel.text = agreeMessage
        let attributedStringColor = [NSAttributedString.Key.foregroundColor :UIColor.white,
                                     NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 13)  ]
        let attributedString = NSMutableAttributedString(string: agreeMessage, attributes: attributedStringColor)
        attributedString.addAttribute(.link, value: "https://google.com", range: agreeMessage.createRangeinaLink(of: "Terms of use"))
        attributedString.addAttribute(.link, value: "https://google.com", range: agreeMessage.createRangeinaLink(of: "Privacy Policy"))
        
        let applyColor:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .underlineColor: UIColor.white,
            .underlineStyle:NSUnderlineStyle.thick.rawValue,
            
        ]
        viewForButton.clipsToBounds = true
        viewForButton.layer.cornerRadius = 35
        agreeLabel.linkTextAttributes = applyColor
        agreeLabel.attributedText = attributedString
        let gradient = getGradientLayer(bounds: allInLabel.bounds)
        allInLabel.textColor = gradientColor(bounds: allInLabel.bounds, gradientLayer: gradient)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    
    @IBAction func checkBoxBtnTapped(_ sender: UIButton) {
        if checkBoxBtn.isSelected {
            checkBoxBtn.setImage(UIImage(named: "checkboxoff"), for: .normal)
            continueLabel.textColor = #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1)

            isAgree = false
        } else {
            checkBoxBtn.setImage(UIImage(named: "checkboxon"), for: .normal)
            continueLabel.textColor = .white
            isAgree = true
        }
        checkBoxBtn.isSelected = !checkBoxBtn.isSelected
    }
    
    
    func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: -1)
        return gradient
    }
    func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
}
