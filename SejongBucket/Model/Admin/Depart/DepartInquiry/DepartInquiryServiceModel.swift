//
//  DepartInquiryServiceModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct DepartInquiryServiceModel : Codable{
    let code: String
    let status: Int
    let message : String?
    let result: DepartData?
    let time : String
}
struct DepartData: Codable {
    let majorInfoList: [MajorInfo]
}
struct MajorInfo: Codable {
    let majorName : String
    let majorId : Int
}
