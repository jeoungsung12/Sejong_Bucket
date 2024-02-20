//
//  DetailDepartServiceModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct DetailDepartServiceModel : Codable{
    let code: String
    let status: Int
    let message : String?
    let result: DetailDepartData?
    let time : String
}
struct DetailDepartData: Codable {
    let majordetails: [DetailMajorInfo]
}
struct DetailMajorInfo: Codable {
    let majorDetailName : String
    let majorDetailId : Int
}
