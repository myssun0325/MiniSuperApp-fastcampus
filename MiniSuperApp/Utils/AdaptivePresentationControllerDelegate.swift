//
//  AdaptivePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by mason on 2022/03/23.
//

import UIKit

protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}

final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    
    weak var delegate: AdaptivePresentationControllerDelegate?
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}
