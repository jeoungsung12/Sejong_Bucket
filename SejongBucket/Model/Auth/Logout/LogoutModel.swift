//
//  LogoutModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
struct LogoutModel : Codable{
    let code: String
    let status: Int
    let message : String?
    let result: LogoutData?
    let time : String
}
struct LogoutData: Codable {
    
}
