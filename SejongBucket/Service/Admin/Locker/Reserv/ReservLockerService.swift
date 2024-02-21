//
//  ReservLockerService.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/22.
//
import Foundation
import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SwiftKeychainWrapper
class ReservLockerService {
    static func reservLocker(lockerId : LockerRequestModel) -> Observable<LockerResultModel>{
        return Observable.create { observer in
            if let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken"),
                let userId = UserDefaults.standard.string(forKey: "userId"),
            let majorId =  UserDefaults.standard.string(forKey: "majorId"){
                let url =  "http://ime-locker.shop:8083/api/v2/users/\(userId)/majors/\(majorId)/lockerDetail/\(lockerId.lockerDetailId)/reservations"
                print("주소 \(url)")
                AF.request(url, method: .post, encoding: JSONEncoding.default, headers: ["AccessToken" : accessToken])
                    .validate()
                    .responseDecodable(of : LockerResultModel.self) { response in
                        print("예약 결과 \(response.description)")
                        switch response.result {
                        case .success(let data):
                            observer.onNext(data)
                            observer.onCompleted()
                        case .failure(let error):
                            print("예약 에러 \(error)")
                            observer.onError(error)
                        }
                    }
            }else{
                print("사물함 예약 에러")
            }
            return Disposables.create()
        }
    }
}
