//
//  DetailDepartViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailDepartViewModel {
    private let disposeBag = DisposeBag()
    
    let DepartInput = PublishRelay<DetailDepartModel>()
    let DepartResult : BehaviorRelay<[DepartInquiryModel]> = BehaviorRelay(value: [])
    let errorOccured = PublishSubject<Error>()
    init() {
        setBinding()
    }
    func setBinding(){
        DepartInput.subscribe(onNext: {[weak self] majorInfo in
            DetailDepartService.requestInquiry(majorId: majorInfo)
                .subscribe(onNext: {[weak self] data in
                    if let majorInfoList = data.result?.majordetails {
                        let detailDepart = majorInfoList.map { DepartInquiryModel(title: $0.majorDetailName, id: $0.majorDetailId) }
                        self?.DepartResult.accept(detailDepart)
                    } else {
                        // 만약 majorInfoList가 nil이면 처리할 로직
                    }
                }, onError: { error in
                    self!.errorOccured.onNext(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
        })
        .disposed(by: disposeBag)
    }
}
