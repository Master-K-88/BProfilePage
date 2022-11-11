//
//  AlertExtension.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import UIKit

extension UIViewController {
    
    func showAlertWithResId(title: String, message: String, positiveBt: String? = nil,negativeBt: String? = nil , completion: (() -> Void)? = nil, cancel: (() -> Void)? = nil) {
        return showAlertWith(title: title, message: message, positive: positiveBt, negative: negativeBt , completion: completion, cancel:cancel)
    }
    
    func showAlertWith(title: String, message: String,  positive: String? = nil,negative: String? = nil,
                       completion: (() -> Void)? = nil, cancel: (() -> Void)? = nil){
        showFullAlertWith(title: title, message: message, positive: positive ?? "", negavite: negative ?? "", completion: completion, cancel: cancel)
        
    }
    
    func showAndReturnAlertWith(title: String,message: String,  positive: String, negavite: String? = nil, completion: (() -> Void)? = nil, cancel: (() -> Void)? = nil) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: positive, style: .default, handler: { action in
            if completion != nil {
                completion!()
            }
        }))
        if negavite != nil && !negavite!.isEmpty {
            ac.addAction(UIAlertAction(title: negavite, style: .default, handler: { action in
                if cancel != nil {
                    cancel!()
                }
            }))
        }
        self.present(ac, animated: true)
        return ac
    }
    
    func showFullAlertWith(title: String, message: String, positive: String, negavite: String? = nil, completion: (() -> Void)? = nil, cancel: (() -> Void)? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if negavite != nil && !negavite!.isEmpty {
            ac.addAction(UIAlertAction(title: negavite, style: .default, handler: { action in
                if cancel != nil {
                    cancel!()
                }
            }))
        }
        ac.addAction(UIAlertAction(title: positive, style: .default, handler: { action in
            if completion != nil {
                completion!()
            }
        }))
        self.present(ac, animated: true)
    }
}
