//
//  LockerInquiryModel.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
struct LockerInquiryModel: Codable {
    let code: String
    let message: String
    let result: LockerResult?
    let status: Int
    let time: String
}

struct LockerResult: Codable {
    let lockersInfo: [LockerInfo]?
}

struct LockerInfo: Codable {
    let locker: Locker?
    let lockerDetail: [LockerDetail]
}

struct Locker: Codable {
    let endReservationTime: String
    let id: Int
    let image: String?
    let name: String
    let permitStates: [String]
    let permitTiers: [String]
    let startReservationTime: String
    let totalColumn: String
    let totalRow: String
}

struct LockerDetail: Codable {
    let column_num: String
    let id: Int
    let locker_num: String
    let row_num: String
    let status: String
}

