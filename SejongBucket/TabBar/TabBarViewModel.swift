//
//  TabBarViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TabBarViewModel {
    private let disposeBag = DisposeBag()
    let inputTrigger = PublishSubject<Int>()
    let outputResult : Driver<String>
    let settingTrigger = PublishSubject<Void>()
    let logoutResult : PublishSubject<LogoutModel> = PublishSubject()
    let errorOccured = PublishSubject<Error>()
    let reissue = PublishSubject<Void>()
    let reissueError = PublishSubject<Bool>()
    init() {
        outputResult = inputTrigger
            .map { index in
                switch index {
                case 0: return "메인"
                case 1: return "예약"
                case 2: return "피드백"
                case 3: return "어드민"
                default: return ""
                }
            }
            .asDriver(onErrorJustReturn: "")
        settingTrigger.flatMapLatest { logout in
            return LogoutService.requestLogout()
                .catch { error in
                    self.errorOccured.onNext(error)
                    return Observable.empty()
                }
        }
        .bind(to: logoutResult)
        .disposed(by: disposeBag)
//        reissue.subscribe(onNext: { result in
//            ReissueService.requestReissue().subscribe(onNext: { bool in
//                if bool == false{
//                    self.reissueError.onNext(false)
//                }
//            })
//            .disposed(by: self.disposeBag)
//        })
//        .disposed(by: disposeBag)
        
    }
}
