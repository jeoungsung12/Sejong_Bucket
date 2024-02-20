//
//  LoginModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
struct LoginModel : Codable {
    let code: String
    let status: Int
    let message : String?
    let result: LoginData?
    let time : String
}
struct LoginData: Codable {
    let accessToken: String
    let refreshToken: String
    let majorId : Int
    let majorName : String
    let role : String
    let userId : Int
}
