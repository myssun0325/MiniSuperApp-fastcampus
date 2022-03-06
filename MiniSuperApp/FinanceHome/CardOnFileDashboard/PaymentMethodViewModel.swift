//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by YoungsunMoon on 2022/03/06.
//

import UIKit

struct PaymentMethodViewModel {
    let name: String
    let digits: String
    let color: UIColor
    
    init(_ paymentMethod: PaymentMethod) {
        name = paymentMethod.name
        digits = "**** \(paymentMethod.digits)"
        color = UIColor(hex: paymentMethod.color) ?? .systemGray2
        
    }
}
