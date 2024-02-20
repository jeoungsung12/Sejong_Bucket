//
//  DepartManagementViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DepartManagementViewModel {
    private let disposeBag = DisposeBag()
    
    let DepartInput = PublishRelay<Void>()
    let DepartResult : BehaviorRelay<[DepartInquiryModel]> = BehaviorRelay(value: [])
    let errorOccured = PublishSubject<Error>()
    init() {
        setBinding()
    }
    func setBinding(){
        DepartInput.subscribe(onNext: {[weak self] in
            DepartInquiryService.requestInquiry()
                .subscribe(onNext: { [weak self] data in
                    if let majorInfoList = data.result?.majorInfoList {
                        let departModels = majorInfoList.map { DepartInquiryModel(title: $0.majorName, id: $0.majorId) }
                        self?.DepartResult.accept(departModels)
                    } else {}
                }, onError: { error in
                    self!.errorOccured.onNext(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
        })
        .disposed(by: disposeBag)
    }
}
