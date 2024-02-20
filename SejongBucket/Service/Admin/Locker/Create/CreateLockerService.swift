//
//  CreateLockerService.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftKeychainWrapper
import Alamofire
class CreateLockerService {
    static func createLocker(lockerInfo: CreateLockerServiceModel) -> Observable<CreateLockerModel> {
        return Observable.create { observer in
//            ReissueService.requestReissue().subscribe(onNext: { result in
//                if result == false {
//                    let error = NSError(domain: "ReissueError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to reissue token"])
//                    observer.onError(error)
//                }
//            })
//            .dispose()
            if let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken"), let majorId = UserDefaults.standard.string(forKey: "majorId"){
                let url = "http://ime-locker.shop:8083/admin/api/v2/majors/\(majorId)/lockers"
                let body : [String : Any] = [
                    "endReservationTime": lockerInfo.endReservationTime,
                    "lockerName": lockerInfo.lockerName,
                    "numberIncreaseDirection": lockerInfo.numberIncreaseDirection,
                    "startReservationTime": lockerInfo.startReservationTime,
                    "totalColumn": lockerInfo.totalColumn,
                    "totalRow": lockerInfo.totalRow,
                    "userTiers": lockerInfo.userTiers
                ]
                AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default ,headers: ["AccessToken" : "\(accessToken)", "Content-Type" : "application/json"])
                    .validate()
                    .responseDecodable(of: CreateLockerModel.self) { response in
                        print("\(response.description)")
                        switch response.result {
                        case .success(let data):
                            observer.onNext(data)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            } else{ print("createLocker - Error")}
            return Disposables.create()
        }
    }
}
