//
//  ErrorModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//
import Foundation
struct ErrorModel: Codable {
    let code: String
    let time: String
    let message: String
    let status: Int
}
