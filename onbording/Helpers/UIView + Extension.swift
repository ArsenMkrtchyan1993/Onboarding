//
//  UIView + Extension.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 10.04.23.
//

import UIKit

extension UIView {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.3
        animation.values = [-10.0, 10.0, -10.0, 10.0, -2.0, 2.0, -0.0, 0.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
