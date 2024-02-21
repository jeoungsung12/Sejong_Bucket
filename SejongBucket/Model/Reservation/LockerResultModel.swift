//
//  LockerResultModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/22.
//

import Foundation

struct LockerResultModel : Codable {
    let code : String
    let message : String
    let result : reservData?
    let status : Int
    let time : String
}
struct reservData : Codable{
    let lockerDetailNum : String
    let lockerName : String
    let studentNum : String
}
