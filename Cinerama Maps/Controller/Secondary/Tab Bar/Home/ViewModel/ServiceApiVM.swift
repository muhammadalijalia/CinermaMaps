//
//  ServiceApiViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

class ServiceApiViewModel {
 
    var arrayOfServices: [Res_Services] = []
    var fetchedSuccesfully:(() -> Void)?
    var arrayOfImages: [String] = []
    
    func requestToServices(vC: UIViewController) {
        Api.shared.requestAllServices(vC) { responseData in
            if responseData.count > 0 {
                self.arrayOfServices = responseData
                
                if let image1 = responseData.first?.image1, Router.BASE_IMAGE_URL != image1 {
                    self.arrayOfImages.append(image1)
                }
                
                if let image2 = responseData.first?.image2, Router.BASE_IMAGE_URL != image2 {
                    self.arrayOfImages.append(image2)
                }
                
                if let image3 = responseData.first?.image3, Router.BASE_IMAGE_URL != image3 {
                    self.arrayOfImages.append(image3)
                }
                
            } else {
                self.arrayOfServices = []
            }
            self.fetchedSuccesfully?()
        }
    }
}
