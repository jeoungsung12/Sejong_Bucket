//
//  ReservationViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import RxSwift
import RxCocoa
class ReservationViewModel {
    private let disposeBag = DisposeBag()
    let LockerInquiry = PublishSubject<Void>()
    let LockerResult : PublishSubject<LockerInquiryModel> = PublishSubject()
    init() {
        setBinding()
    }
    private func setBinding() {
        LockerInquiry.flatMapLatest { _ in
            return InquiryLockerService.InquiryLocker()
                .catch { error in
                    Observable.empty()
                }
        }
        .bind(to: LockerResult)
        .disposed(by: disposeBag)
    }
}
