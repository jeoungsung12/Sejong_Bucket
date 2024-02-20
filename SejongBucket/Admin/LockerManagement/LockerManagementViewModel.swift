//
//  LockerManagementViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import RxSwift
import RxCocoa

class LockerManagementViewModel {
    private let disposeBag = DisposeBag()
    let inputTrigger = PublishSubject<CreateLockerServiceModel>()
    let outputResult : PublishSubject<CreateLockerModel> = PublishSubject()
    let errorOccured = PublishSubject<Error>()
    init() {
        setBinding()
    }
    private func setBinding() {
        inputTrigger.flatMapLatest { lockerInfo in
            return CreateLockerService.createLocker(lockerInfo: lockerInfo)
                .catch { error in
                    self.errorOccured.onNext(error)
                    return Observable.empty()
                }
        }
        .bind(to: outputResult)
        .disposed(by: disposeBag)
    }
}
