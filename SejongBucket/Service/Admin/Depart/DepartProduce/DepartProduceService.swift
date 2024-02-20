//
//  DepartProduceService.swift
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
class DepartProduceService {
    static func requestProduce(majorName : String) -> Observable<DepartProduceServiceModel> {
        return Observable.create { observer in
//            ReissueService.requestReissue().subscribe(onNext: { result in
//                if result == false {
//                    let error = NSError(domain: "ReissueError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to reissue token"])
//                    observer.onError(error)
//                }
//            })
//            .dispose()
            let url = "http://ime-locker.shop:8083/master/api/v2/majors"
            if let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken"){
                let body : [String : Any] = [
                    "majorName" : majorName
                ]
                AF.request(url, method: .post, parameters: body,encoding: JSONEncoding.default ,headers: ["AccessToken" : "\(accessToken)", "Content-Type" : "application/json"])
                    .validate()
                    .responseDecodable(of: DepartProduceServiceModel.self) { response in
                        print("통신결과 : \(response.description)")
                        switch response.result {
                        case .success(let data):
                            observer.onNext(data)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            } else{ print("requestInquiry - Error")}
            return Disposables.create()
        }
    }
}
