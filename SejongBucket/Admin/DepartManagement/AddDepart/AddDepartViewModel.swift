//
//  AddDepartViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AddDepartViewModel {
    private let disposeBag = DisposeBag()
    let nameInputTrigger = PublishSubject<String>()
    let outputResult : PublishSubject<DepartProduceServiceModel> = PublishSubject()
    let errorOccured = PublishSubject<Error>()
    init() {
        setBinding()
    }
    func setBinding() {
        nameInputTrigger.flatMapLatest { [weak self] majorName -> Observable<DepartProduceServiceModel> in
            guard self != nil else { return Observable.empty() }
            return DepartProduceService.requestProduce(majorName: majorName)
        }
        .subscribe(onNext: {[weak self] data in
            self?.outputResult.onNext((data))
        })
        .disposed(by: disposeBag)
    }
}
