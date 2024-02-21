//
//  InquiryLockerService.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SwiftKeychainWrapper
class InquiryLockerService {
    static func InquiryLocker() -> Observable<LockerInquiryModel>{
        return Observable.create { observer in
            if let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken"),
                let userId = UserDefaults.standard.string(forKey: "userId"){
                let url =  "http://ime-locker.shop:8083/api/v2/users/\(userId)/majors/lockers"
                AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["AccessToken" : accessToken])
                    .validate()
                    .responseDecodable(of : LockerInquiryModel.self) { response in
                        switch response.result {
                        case .success(let data):
                            observer.onNext(data)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            }else{
                print("사물함 조회 에러")
            }
            return Disposables.create()
        }
    }
}
