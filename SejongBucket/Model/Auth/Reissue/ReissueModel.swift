//
//  ReissueModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
struct ReissueModel : Codable{
    let code : String
    let message : String
    let result : reissueData?
    let status : Int
    let time : String
    
}

struct reissueData : Codable {
    let accessToken : String
    let refreshToken : String
}
