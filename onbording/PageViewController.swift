//
//  PageViewController.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 02.04.23.
//

import UIKit

class PageViewController: UIPageViewController {
    let identifier = "ContentViewController"
    let infoTextContent = [
        "Create personalilzed, impressive avatar whit the help powerful Ai technology",
        "It makes professional-looking face retouching available to everyone whit a single tap.No skills are required",
        "It makes professional-looking face retouching available to everyone whit a single tap,",
        "It makes professional-looking face retouching available to everyone whit a single tap",
        "It makes professional-looking face retouching available to everyone whit a single tap"
    ]
    let nameTextContent = [
        "Magic Avatar",
        "Magic Retouch",
        "Smart Eraser",
        "Pro Adjustmentrs",
        "Beat Sync"
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contentViewController = showViewControllerAtIndex(0){
            setViewControllers([contentViewController], direction: .forward, animated: true)
        }
        
    }

    func showViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < nameTextContent.count else { return nil }
        guard let contentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController else { return nil }
        contentViewController.infoText = infoTextContent[index]
        contentViewController.nameText = nameTextContent[index]
        return contentViewController
    }
    
}
