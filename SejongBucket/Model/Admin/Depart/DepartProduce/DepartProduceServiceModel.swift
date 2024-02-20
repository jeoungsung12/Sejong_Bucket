//
//  DepartProduceServiceModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct DepartProduceServiceModel : Codable {
    let code: String
    let status: Int
    let message : String?
    let result: DepartProduceData?
    let time : String
}
struct DepartProduceData: Codable {
    let majorName : String
    let majorId : Int
}
