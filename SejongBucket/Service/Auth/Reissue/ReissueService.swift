//
//  Reissue.swift
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
class ReissueService {
    static func requestReissue() -> Observable<Bool>{
        return Observable.create { observer in
            if let refreshToken = KeychainWrapper.standard.string(forKey: "JWTrefreshToken"){
                let url = "http://ime-locker.shop:8083/api/v2/auth/reissue"
                let disposeBag = DisposeBag()
                AF.request(url, method: .post, encoding: JSONEncoding.default, headers: ["refreshToken": refreshToken])
                    .validate()
                    .responseDecodable(of: ReissueModel.self) { response in
                        switch response.result {
                        case .success(let data):
                            if let accessToken = data.result?.accessToken , let refreshToken = data.result?.refreshToken {
                                KeychainWrapper.standard.removeAllKeys()
                                KeychainWrapper.standard.set(accessToken, forKey: "JWTaccessToken")
                                KeychainWrapper.standard.set(refreshToken, forKey: "JWTrefreshToken")
                                observer.onNext(true)
                                observer.onCompleted()
                            }
                        case .failure(let error):
                            print("재발행 error : \(error)")
                            LogoutService.requestLogout().subscribe(onNext: { _ in
                                observer.onNext(false)
                                observer.onCompleted()
                            })
                            .disposed(by: disposeBag)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
