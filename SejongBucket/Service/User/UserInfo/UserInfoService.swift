//
//  UserInfoService.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftKeychainWrapper
class UserInfoService {
    static func requestUserInfo() -> Observable<UserInfoModel> {
        return Observable.create { observer in
//            ReissueService.requestReissue().subscribe(onNext: { result in
//                if result == false {
//                    let error = NSError(domain: "ReissueError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to reissue token"])
//                    observer.onError(error)
//                }
//            })
//            .dispose()
            if let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken"), let userId = UserDefaults.standard.string(forKey: "userId"){
                let url = "http://ime-locker.shop:8083/api/v2/users/\(userId)"
                AF.request(url,method: .get ,encoding: JSONEncoding.default, headers: ["AccessToken": "\(accessToken)"])
                    .validate()
                    .responseDecodable(of: UserInfoModel.self){ response in
                        switch response.result {
                        case .success(let data):
                            observer.onNext(data)
                            observer.onCompleted()
                        case .failure(let error):
                            print("userInfo - \(error)")
//                            observer.onError(error)
                        }
                    }
            }else{
                print("UserInfo-error")
            }
            return Disposables.create()
        }
    }
}
