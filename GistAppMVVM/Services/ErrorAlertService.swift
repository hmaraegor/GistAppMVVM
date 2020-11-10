//
//  ErrorAlertService.swift
//  GistAppMVVM
//
//  Created by Egor on 10.11.2020.
//

import UIKit

class ErrorAlertService {
    
    
    
    static func showAlert(error: NetworkErrorService) {
        var errorMessage = String()
        switch error{
        case .badURL:
            errorMessage = "URL has incorrect format"
        case .noData:
            errorMessage = "Data was not received"
        case .jsonDecoding:
            errorMessage = "Data decoding error"
        case .badResponse:
            errorMessage = "Response returned an error"
        @unknown default:
            errorMessage = "Network Service error"
        }
        
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            var rootViewController = UIApplication.shared.keyWindow?.rootViewController
            if let navigationController = rootViewController as? UINavigationController {
                rootViewController = navigationController.viewControllers.first
            }
            if let tabBarController = rootViewController as? UITabBarController {
                rootViewController = tabBarController.selectedViewController
            }
            
            rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
