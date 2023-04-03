//
//  PageViewController.swift
//  onbording
//
//  Created by Arsen Mkrtchyan on 02.04.23.
//

import UIKit

protocol NextOnboard {
    func continueButton()
}

class PageViewController: UIPageViewController {
    let identifier = "ContentViewController"
    var pageNumber = 0
    let infoTextContent = [
        "Create personalilzed, impressive avatar whit the help powerful Ai technology",
        "It makes professional-looking face retouching available to everyone whit a single tap.No skills are required",
        "It makes professional-looking face retouching available to everyone whit a single tap,",
        "It makes professional-looking face retouching available to everyone whit a single tap",
        "It makes professional-looking face retouching available to everyone whit a single tap"
    ]
    let nameTextContent = [
        "Magic Avatars",
        "Magic Retouch",
        "Smart Eraser",
        "Pro Adjustmentrs",
        "Beat Sync"
    
    ]
    let videoLink = [
        "https://cdn.getglam.app/onboarding/onboarding_270323/3_small5_new.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/2_small_new.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/1_small_new.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/5_small_new_compressed.mp4",
        "https://cdn.getglam.app/onboarding/onboarding_270323/3_small5_new.mp4"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let contentViewController = showViewControllerAtIndex(0){
            setViewControllers([contentViewController], direction: .forward, animated: true)
        }
        //self.view.frame = CGRect(x: 50, y: 50, width: self.view.frame.width - (5.0 * 20.0), height: self.view.frame.height - (2.0 * 50.0))
        

        
    }

    func showViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        self.pageNumber = index
        guard index >= 0 else { return nil }
        guard index < nameTextContent.count else { return nil }
        guard let contentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController else { return nil }
        contentViewController.infoText = infoTextContent[index]
        contentViewController.nameText = nameTextContent[index]
        contentViewController.linkForVideo = videoLink[index]
        contentViewController.currentPage = index
        contentViewController.delegat = self
        return contentViewController
    }
    
}
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber -= 1
        self.pageNumber = pageNumber
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber += 1
        self.pageNumber = pageNumber
        return showViewControllerAtIndex(pageNumber)
    }
    
    
}
extension PageViewController: NextOnboard {
    func continueButton() {
        print("helo")
        self.pageNumber += 1
        if let contentViewController = showViewControllerAtIndex(pageNumber){
            setViewControllers([contentViewController], direction: .forward, animated: true)
        }
        
    }
    
    
}
