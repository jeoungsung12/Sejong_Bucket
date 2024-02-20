//
//  CreateLockerModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
struct CreateLockerModel : Codable {
    let code : String
    let message : String
    let status : Int
    let result : CreateLockerData?
    let time : String
}
struct CreateLockerData : Codable {
    let createdLockerName : String
}
