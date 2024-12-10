//
//  GuidelineTipApiViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

class GuidelineTipApiViewModel {
    
    var arrayGuidelinesTip: [Res_GuidelineTips] = []
    var fethcedSuccessfully:(() -> Void)?
    
    func fetchGuidelineTips(vC: UIViewController)
    {
        Api.shared.requestGuidelineTips(vC) { responseData in
            if responseData.count > 0 {
                self.arrayGuidelinesTip = responseData
            } else {
                self.arrayGuidelinesTip = []
            }
            self.fethcedSuccessfully?()
        }
    }
}
