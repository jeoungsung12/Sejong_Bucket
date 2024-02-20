//
//  MainViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MainViewModel {
    private let disposeBag = DisposeBag()
    let UserInfoInput = PublishSubject<Void>()
    let UserInfoResult : PublishSubject<UserInfoModel> = PublishSubject()
    let AccountInput = PublishSubject<Void>()
    let AccountResult : PublishSubject<AccountModel> = PublishSubject()
    let errorOccured = PublishSubject<Error>()
    init() {
        setBinding()
    }
    func setBinding(){
        UserInfoInput.flatMapLatest({ _ in
            return UserInfoService.requestUserInfo()
                .catch { error in
                    self.errorOccured.onNext(error)
                    return Observable.empty()
                }
        })
        .bind(to: UserInfoResult)
        .disposed(by: disposeBag)
        AccountInput.flatMapLatest({ _ in
            return AccountService.requestAccount()
                .catch { error in
                    self.errorOccured.onNext(error)
                    return Observable.empty()
                }
        })
        .bind(to: AccountResult)
        .disposed(by: disposeBag)
    }
}
