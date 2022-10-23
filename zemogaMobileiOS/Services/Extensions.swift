//
//  Extensions.swift
//  meliMobileiOS
//
//  Created by Oscar David Myerston Vega on 3/09/22.
//

import Foundation
import UIKit

fileprivate var containerLoading: UIView?


extension Dictionary{
    func parseResponse<T>(_ type: T.Type) -> T? where T: Codable {
        return JSONHelper.deserialize(self, type: type)
    }
}

extension String{
    func parseResponse<T>(_ type: T.Type) -> T? where T: Codable {
        let decoder = JSONDecoder()
        do {
            let jsonData = Data(self.utf8)
            let object = try decoder.decode(type, from: jsonData)
            return object
        } catch {
            print(error)
            return nil
        }
    }
    
    func getCurrancy() -> String{
        return (Int(self.replacingOccurrences(of: ".", with: "")) ?? 0).getCurrency()
    }
    
    func getCurrancyInt() -> Int{
        let value = self.replacingOccurrences(of: ".", with: "")
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        if let number = formater.number(from: value) {
            return number.intValue
        }
        else {return 0}
    }
    
}

extension UIViewController {
    func showLoading () {
        containerLoading = UIView(frame: self.view.bounds)
        containerLoading?.backgroundColor = .lightGray
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = containerLoading!.center
        activityIndicator.startAnimating()
        containerLoading?.addSubview(activityIndicator)
        self.view.addSubview(containerLoading!)
    }
    
    func hideLoading () {
        containerLoading?.removeFromSuperview()
        containerLoading = nil
    }
    
    func alertModal(mensaje: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: "Alerta!", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: completion))
            
        present(alert, animated: true)
    }

    func showLoading (to superView: UIView) {
        containerLoading = UIView(frame: superView.frame)
        containerLoading?.backgroundColor = .systemGray3
        containerLoading?.translatesAutoresizingMaskIntoConstraints = false
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = containerLoading!.center
        activityIndicator.startAnimating()
        containerLoading?.addSubview(activityIndicator)
        superView.addSubview(containerLoading!)
    }
}


extension Int{
    func getCurrency() -> String{
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        formater.locale = Locale.current
        if self == 0 {
            return "0"
        }
        else {
            return formater.string(from: NSNumber(value: self)) ?? "0"
        }
    }
}


extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }

}
