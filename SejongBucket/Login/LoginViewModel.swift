//
//  LoginViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import RxSwift
import SnapKit
import UIKit

class LoginViewModel {
    private let disposeBag = DisposeBag()
    private let loginService : LoginService
    let inputTrigger = PublishSubject<LoginServiceModel>()
    let outputResult : PublishSubject<LoginModel> = PublishSubject()
    let errorOccured = PublishSubject<Error>()
    let findTrigger = PublishSubject<Void>()
    init(loginService: LoginService) {
        self.loginService = loginService
        inputTrigger
            .flatMapLatest { userInfo in
                return LoginService.requestLogin(userInfo: userInfo)
                    .catch { error in
                        self.errorOccured.onNext(error)
                        return Observable.empty()
                    }
            }
            .bind(to: outputResult)
            .disposed(by: disposeBag)
        findTrigger.subscribe(onNext: { _ in
            guard let url = URL(string: "https://portal.sejong.ac.kr/jsp/inquiry/idconf.jsp") else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        .disposed(by: disposeBag)
    }
}
