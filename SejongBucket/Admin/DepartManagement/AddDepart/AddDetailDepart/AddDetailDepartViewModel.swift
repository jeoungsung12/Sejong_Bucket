//
//  AddDetailDepartViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AddDetailDepartViewModel {
    private let disposeBag = DisposeBag()
    let nameInputTrigger = PublishSubject<DetailProduceModel>()
    let outputResult : PublishSubject<DetailProduceServiceModel> = PublishSubject()
    
    init() {
        setBinding()
    }
    func setBinding() {
        nameInputTrigger.flatMapLatest { [weak self] detailMajorInfo -> Observable<DetailProduceServiceModel> in
            guard self != nil else { return Observable.empty() }
            return DetailDepartProduceService.requestProduce(detailMajor: detailMajorInfo)
        }
        .subscribe(onNext: {[weak self] data in
            self?.outputResult.onNext((data))
        })
        .disposed(by: disposeBag)
    }
}
