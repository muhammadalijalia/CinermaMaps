//
//  OnboardingViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 31/08/24.
//

import Foundation
import UIKit
import LanguageManager_iOS

class OnboardingViewModel {
    
    var currentIndex = 0
    
    var arrayMainHeading =
    [
        "Explore the world with Cinerama Map".localiz(),
        "Create memories that last a lifetime.".localiz(),
        "Plan your dream trip with Tourbliss".localiz()
    ]
    
    var arraySubHeading =
    [
    "Lorem Ipsum dolor sit amet consectetur. My ultricies luctus fermentum a. Duis nec quam lectus varius ac sit amet Lorem.",
    "Lorem Ipsum dolor sit amet consectetur. My ultricies luctus fermentum a. Duis nec quam lectus varius ac sit amet Lorem.",
    "Lorem Ipsum dolor sit amet consectetur. My ultricies luctus fermentum a. Duis nec quam lectus varius ac sit amet Lorem."
    ]

    var arrayImageList =
    [
        R.image.slide1(),
        R.image.slide2(),
        R.image.slide3()
    ]
    
    var numberOfItems: Int {
        return arrayImageList.count
    }
    
    var currentSlide: (image: UIImage?, mainHeading: String, subHeading: String) {
        return (arrayImageList[currentIndex], arrayMainHeading[currentIndex], arraySubHeading[currentIndex])
    }
    
    func updateCurrentIndex(to index: Int) {
        currentIndex = index
    }
    
    func incrementIndex() -> Bool {
        if currentIndex < (arrayImageList.count - 1) {
            currentIndex += 1
            return true
        } else {
            return false
        }
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex
    }
    
    func navigateToLoginViewController(from navigationController: UINavigationController?) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(vC, animated: true)
    }
}
