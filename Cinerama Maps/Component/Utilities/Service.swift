//
//  Service.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation
import Alamofire

class Service {
    
    //MARK: - POST API Request
    class func post(url urlString: String, params Parameters : [String: AnyObject]?,method Method : HTTPMethod,  vc parentVC: UIViewController, successBlock success : @escaping (_ responseData : Data) -> Void, failureBlock failure: @escaping (_ error: Error) -> Void) {
        
        if Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: true) {
            
            var url:String! = ""
            for val in Parameters! {
                url += "\(val.key)=\(val.value)&"
            }
            print("Full_Api_For_Browser/***************************************************************************************/ \(urlString)?\(url ?? "")")
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            manager.session.configuration.requestCachePolicy = .reloadIgnoringCacheData
            //            manager.session.configuration.requestCachePolicy = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
            manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            manager.session.configuration.urlCache = nil
            manager.session.configuration.urlCache?.removeAllCachedResponses()
            manager.session.configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
            manager.request(urlString, method: Method, parameters: Parameters)
            //                .responseData(completionHandler: { (resp) in
            //                    print(resp)
            //                })
                .responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        if((response.result.value) != nil) {
                            if let data = response.data {
                                success(data)
                            }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        if error._code == NSURLErrorTimedOut {
                            print(error.localizedDescription)
                            failure(error)
                        } else {
                            print("\n\nAuth request failed with error:\n \(error)")
                            failure(error)
                        }
                        break
                    }
                }
        } else {
            parentVC.hideProgressBar()
            Utility.showAlertMessage(withTitle: "", message: NETWORK_ERROR_MSG, delegate: nil, parentViewController: parentVC)
        }
    }
    
    //MARK: - APPDELETE POST API Request
    class func kAppDelegatePost(url Url: String, params Parameters : [String: AnyObject]?,method Method : HTTPMethod, successBlock success : @escaping (_ responseData : Data) -> Void, failureBlock failure: @escaping (_ error: Error) -> Void) {
        
        if Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: true) {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            manager.request(Url, method: Method, parameters: Parameters)
                .responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        if((response.result.value) != nil) {
                            if let data = response.data {
                                success(data)
                            }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        if error._code == NSURLErrorTimedOut {
                            print(error.localizedDescription)
                            failure(error)
                        } else {
                            print("\n\nAuth request failed with error:\n \(error)")
                            failure(error)
                        }
                        break
                    }
                }
        }
    }
    
    //MARK: - Multipart API Request for upload multiple photos
    class func postSingleMedia(url urlString: String, params:[String : String]?,imageParam: [String : UIImage?]?,videoParam: [String : Data?]?, parentViewController parentVC: UIViewController, successBlock success : @escaping (_ responseData : Data) -> Void, failureBlock failure: @escaping (_ error: Error) -> Void){
        if Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: true) {
            
            var url:String! = ""
            for val in params! {
                url += "\(val.key)=\(val.value)&"
            }
            print("Full_Api_For_Browser/***************************************************************************************/ \(urlString)?\(url ?? "")")
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                // "Content-type": "multipart/form-data"
                "Content-Type": "application/json"
            ]
            
            Alamofire.upload(multipartFormData: {multipartFormData in
                for (key, value) in params! {
                    if let data = value.data(using: String.Encoding(rawValue:  String.Encoding.utf8.rawValue)) {
                        print("Filed Name : \(key), Value :\(value)")
                        multipartFormData.append(data, withName: key)
                    }
                }
                
                for (key, image) in imageParam! {
                    if let imageData = image!.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: key as String, fileName: "\(key).jpg", mimeType: "image/jpeg")
                    }
                }
                
                for (key, data) in videoParam! {
                    multipartFormData.append(data!, withName: key, fileName: "\(key).mp4", mimeType: "video/mp4")
                }
            },
                             to: urlString, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload
                        .uploadProgress(closure: { (progress) in
                            print("Progress : \(progress)")
                        })
                        .validate()
                        .responseJSON { response in
                            if((response.result.value) != nil) {
                                if let data = response.data {
                                    success(data)
                                }
                            } else {
                                print(response.request?.url)
                                failure(response.result.error! as Error)
                            }
                        }
                case .failure(let error):
                    print(error)
                    if error._code == NSURLErrorTimedOut {
                        //HANDLE TIMEOUT HERE
                        failure(error)
                    } else {
                        failure(error)
                    }
                    break
                }
            })
        } else {
            parentVC.hideProgressBar();
            Utility.showAlertMessage(withTitle: "", message: NETWORK_ERROR_MSG, delegate: nil, parentViewController: parentVC)
        }
    }
    
    //MARK: - Multipart API Request for upload multiple photos
    class func postWithMedia(url urlString: String, params Parameters : [String: String]?, imageParam: [String : Array<Any>?]?,videoParam: [String : Array<Any>?]?,vc parentVC: UIViewController, successBlock success : @escaping (_ responseData : Data) -> Void, failureBlock failure: @escaping (_ error: Error) -> Void){
        if Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: true) {
            
            var url:String! = ""
            for val in Parameters! {
                url += "\(val.key)=\(val.value)&"
            }
            print("Full_Api_For_Browser/***************************************************************************************/ \(urlString)?\(url ?? "")")
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                // "Content-type": "multipart/form-data"
                "Content-Type": "application/json"
            ]
            
            Alamofire.upload(multipartFormData: {multipartFormData in
                for (key, value) in Parameters! {
                    if let data = value.data(using: String.Encoding(rawValue:  String.Encoding.utf8.rawValue)) {
                        multipartFormData.append(data, withName: key)
                    }
                }
                
                for (key, imageArr) in imageParam! {
                    for image in imageArr! {
                        if let imageData = (image as! UIImage).jpegData(compressionQuality: 0.5) {
                            multipartFormData.append(imageData, withName: key as String, fileName: "\(key).jpg", mimeType: "image/jpeg")
                        }
                    }
                }
                
                for (key, videoUrl) in videoParam! {
                    for url in videoUrl! {
                        multipartFormData.append(url as! URL, withName: key, fileName: "\(key).mp4", mimeType: "video/mp4")
                    }
                }
            },
                             to: urlString, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload
                        .uploadProgress(closure: { (progress) in
                            print("Progress : \(progress)")
                        })
                        .validate()
                        .responseJSON { response in
                            print(response)
                            if((response.result.value) != nil) {
                                if let data = response.data {
                                    success(data)
                                }
                            } else {
                                failure(response.result.error! as Error)
                            }
                        }
                case .failure(let error):
                    print(error)
                    if error._code == NSURLErrorTimedOut {
                        //HANDLE TIMEOUT HERE
                        failure(error)
                    } else {
                        failure(error)
                    }
                    break
                }
            })
        } else {
            parentVC.hideProgressBar()
            Utility.showAlertMessage(withTitle: "", message: NETWORK_ERROR_MSG, delegate: nil, parentViewController: parentVC)
        }
    }
    
    //    MARK: - POST API Request SwiftyJson
    class func callPostService(apiUrl urlString: String, parameters params : [String: AnyObject]?,Method method : HTTPMethod,  parentViewController parentVC: UIViewController, successBlock success : @escaping ( _ responseData : AnyObject, _  message: String) -> Void, failureBlock failure: @escaping (_ error: Error) -> Void) {
        
        if Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: true) {
            
            var url:String! = ""
            for val in params! {
                url += "\(val.key)=\(val.value)&"
            }
            print("Full_Api_For_Browser/***************************************************************************************/ \(urlString)?\(url ?? "")")
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            manager.request(urlString, method: method, parameters: params)
                .responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        print(response.request?.url!)
                        if((response.result.value) != nil) {
                            success(response.result.value as AnyObject, "Successfull")
                        }
                        break
                    case .failure(let error):
                        print(response.request?.url)
                        print(error.localizedDescription)
                        if error._code == NSURLErrorTimedOut {
                            //HANDLE TIMEOUT HERE
                            print(error.localizedDescription)
                            failure(error)
                        } else {
                            print("\n\nAuth request failed with error:\n \(error)")
                            failure(error)
                        }
                        break
                    }
                }
        } else {
            parentVC.hideProgressBar();
            Utility.showAlertMessage(withTitle: "", message: NETWORK_ERROR_MSG, delegate: nil, parentViewController: parentVC)
        }
    }
    
    // Post Api With Data
    class func postWithData(url urlString: String, params:[String : String]?,imageParam: [String : Data?]?,videoParam: [String : Data?]?, parentViewController parentVC: UIViewController, successBlock success : @escaping (_ responseData : Data) -> Void, failureBlock failure: @escaping (_ error: Error) -> Void){
        if Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: true) {
            
            var url:String! = ""
            for val in params! {
                url += "\(val.key)=\(val.value)&"
            }
            print("Full_Api_For_Browser/***************************************************************************************/ \(urlString)?\(url ?? "")")
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                // "Content-type": "multipart/form-data"
                "Content-Type": "application/json"
            ]
            
            Alamofire.upload(multipartFormData: {multipartFormData in
                for (key, value) in params! {
                    if let data = value.data(using: String.Encoding(rawValue:  String.Encoding.utf8.rawValue)) {
                        print("Filed Name : \(key), Value :\(value)")
                        multipartFormData.append(data, withName: key)
                    }
                }
                
                for (key, data) in imageParam! {
                    multipartFormData.append(data!, withName: key , fileName: "\(key).pdf", mimeType: "application/pdf")
                }
                
                for (key, data) in videoParam! {
                    multipartFormData.append(data!, withName: key, fileName: "\(key).mp4", mimeType: "video/mp4")
                }
            },
                             to: urlString, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload
                        .uploadProgress(closure: { (progress) in
                            print("Progress : \(progress)")
                        })
                        .validate()
                        .responseJSON { response in
                            if((response.result.value) != nil) {
                                if let data = response.data {
                                    success(data)
                                }
                            } else {
                                print(response.request?.url)
                                failure(response.result.error! as Error)
                            }
                        }
                case .failure(let error):
                    print(error)
                    if error._code == NSURLErrorTimedOut {
                        //HANDLE TIMEOUT HERE
                        failure(error)
                    } else {
                        failure(error)
                    }
                    break
                }
            })
        } else {
            parentVC.hideProgressBar();
            Utility.showAlertMessage(withTitle: "", message: NETWORK_ERROR_MSG, delegate: nil, parentViewController: parentVC)
        }
    }
}
