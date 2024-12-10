//
//  ServiceDetailViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/11/24.
//

import Foundation

class ServiceDetailViewModel {
    
    var arrayServiceDetail: Res_ServiceDetails?
    var fetchedSuccessfully:(() -> Void)?
    var arrayRatingReview: [Rating_review] = []
    var arrayOfImages: [String] = []
    
    var service_ID: String = ""
    
    func fetchServiceDetail(vC: UIViewController)
    {
        var paramDetail: [String : AnyObject] = [:]
        paramDetail["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDetail["service_id"] = service_ID as AnyObject
        
        print(paramDetail)
        
        Api.shared.requestToServiceDetail(vC, paramDetail) { responseData in
            self.arrayServiceDetail = responseData
            
            if let image1 = responseData.image1, Router.BASE_IMAGE_URL != image1 {
                self.arrayOfImages.append(image1)
            }
            
            if let image2 = responseData.image2, Router.BASE_IMAGE_URL != image2 {
                self.arrayOfImages.append(image2)
            }
            
            if let image3 = responseData.image3, Router.BASE_IMAGE_URL != image3 {
                self.arrayOfImages.append(image3)
            }
            
            if let objRatingReview = responseData.rating_review {
                if objRatingReview.count > 0 {
                    self.arrayRatingReview = objRatingReview
                } else {
                    self.arrayRatingReview = []
                }
            }
            self.fetchedSuccessfully?()
        }
    }
    
    func navigateToRatingReviewViewController(from navigationController: UINavigationController?)
    {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        navigationController?.pushViewController(vC, animated: true)
    }
}
