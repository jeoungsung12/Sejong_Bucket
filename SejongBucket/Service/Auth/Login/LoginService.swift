//
//  LoginService.swift
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
class LoginService {
    static func requestLogin(userInfo: LoginServiceModel) -> Observable<LoginModel> {
        return Observable.create { observer in
            let url = "http://ime-locker.shop:8083/api/v2/auth/login"
            let body : [String : Any] = [
                "id" : userInfo.id,
                "pw" :  userInfo.pw
            ]
            AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"])
                .validate()
                .responseDecodable(of: LoginModel.self) { response in
                    print("로그인 \(response.description)")
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
