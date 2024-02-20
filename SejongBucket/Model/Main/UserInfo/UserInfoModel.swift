//
//  UserInfoModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
struct UserInfoModel : Codable {
    let code: String
    let status: Int
    let message : String?
    let result: UserData?
    let time : String
}
struct UserData : Codable {
    let majorDetail: String
    let reservedLockerDetailId : Int?
    let reservedLockerDetailNum : String?
    let reservedLockerName : String?
    let studentNum : String
    let userName : String
    let userState : String?
    let userTier : String?
}
