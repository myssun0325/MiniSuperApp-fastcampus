//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by YoungsunMoon on 2022/03/06.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
