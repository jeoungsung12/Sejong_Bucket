//
//  LogoutService.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftKeychainWrapper
class LogoutService {
    static func requestLogout() -> Observable<LogoutModel> {
        return Observable.create { observer in
//            ReissueService.requestReissue().subscribe(onNext: { result in
//                if result == false {
//                    print("리이슈 에러\(result)")
//                    let error = NSError(domain: "ReissueError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to reissue token"])
//                    observer.onError(error)
//                }
//            })
//            .dispose()
            let url = "http://ime-locker.shop:8083/api/v2/auth/logout"
            if let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken"){
                AF.request(url, method: .post, encoding: JSONEncoding.default, headers: ["accessToken": "\(accessToken)"])
                    .validate()
                    .responseDecodable(of: LogoutModel.self) { response in
                        switch response.result {
                        case .success(let data):
                            observer.onNext(data)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            }else{
                print("Logout-error")
            }
            return Disposables.create()
        }
    }
}
