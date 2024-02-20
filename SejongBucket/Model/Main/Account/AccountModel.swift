//
//  AccountModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
struct AccountModel : Codable {
    let code: String
    let status: Int
    let message : String?
    let result: AccountData?
    let time : String
}
struct AccountData : Codable {
    let accountNum: String?
    let bank : String?
    let ownerName : String?
}
