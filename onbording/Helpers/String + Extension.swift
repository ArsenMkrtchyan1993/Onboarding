//
//  String + Extension.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 10.04.23.
//

import UIKit


extension String {
    func createRangeinaLink(of findWord: String) -> NSRange {
        let range = (self as NSString).range(of: findWord, options: .caseInsensitive)
        return range
    }
}
