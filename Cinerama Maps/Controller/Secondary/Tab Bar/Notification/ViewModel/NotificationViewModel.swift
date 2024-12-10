//
//  NotificationViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 16/11/24.
//

import Foundation

class NotificationViewModel {
    
    var arrayOfNotification: [Res_Notification] = []
    var fetchedSuccessfull:(() -> Void)?
    
    func requestToFetchNotificaiton(vC: UIViewController)
    {
        Api.shared.requestToNotification(vC) { [self] responseData in
            if responseData.count > 0 {
                self.arrayOfNotification = responseData
            } else {
                self.arrayOfNotification = []
            }
            self.fetchedSuccessfull?()
        }
    }
}
