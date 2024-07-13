//
//  ViewController+AlertExtensions.swift
//  About-You
//
//  Created by Prateek on 2024/07/13.
//

import UIKit

extension UIViewController {
    
    enum DestructiveAlertType: String {
        
        case ok = "OK"
        case cancel = "Cancel"
        case close = "Close"
    }
    
    
    func showAlert(with title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        self.show(alertController, sender: self)
    }
    
    func showDestructiveAlert(with title: String,
                              message: String,
                              type: DestructiveAlertType,
                              onCompletion handler: ((UIAlertAction) -> Void)? = nil) {
        let alertAction = UIAlertAction(title: type.rawValue, style: .destructive, handler: handler)
        showAlert(with: title, message: message, actions: [alertAction])
    }
}
