//
//  Color + Extension.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit

extension UIColor {
    static var keyColor : UIColor {
        return UIColor(named: "keyColor") ?? .white
    }
    static var pointColor : UIColor {
        return UIColor(named: "pointColor") ?? .white
    }
    static var shadowColor : UIColor {
        return UIColor(named: "shadowColor") ?? .white
    }
}
