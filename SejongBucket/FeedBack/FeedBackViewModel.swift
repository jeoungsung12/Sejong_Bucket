//
//  FeedBackViewModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FeedBackViewModel {
    private let disposeBag = DisposeBag()
    let input = PublishSubject<Void>()
    let output : PublishSubject<Void> = PublishSubject()
    
    init() {
        openGoogleFormInSafari()
    }
    private func openGoogleFormInSafari() {
        input.subscribe(onNext: { _ in
            guard let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdANAEyc7AqrhruRz8C-al3zVoM092HOkWyBpRsFJI5ubLeRA/viewform") else {
                        return
                    }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        .disposed(by: disposeBag)
    }
}
