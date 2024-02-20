//
//  DetailProduceServiceModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct DetailProduceServiceModel : Codable {
    let code: String
    let status: Int
    let message : String?
    let result: DetailProduceData?
    let time : String
}
struct DetailProduceData: Codable {
    let savedMjorDetailName : String
}
