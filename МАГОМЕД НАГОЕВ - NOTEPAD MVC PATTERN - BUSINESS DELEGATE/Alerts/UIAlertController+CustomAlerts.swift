//
//  UIAlertController+CustomAlerts.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Nargiza Beishekenova on 24/8/22.
//

import Foundation
import UIKit

extension UIAlertController {
    //Alert delet file and open New
    class func getAlertNewFile() -> UIAlertController {
        let alert = UIAlertController(title: "Delete current file?", message: "Are you sure you want to delete the current file and open new?", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Delete", style: .destructive,
                                      handler: {(_: UIAlertAction!) in
                                        print("Test ////// deleting file")
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in })

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        alert.view.addSubview(UIView())
        

        return alert
        
    }

//    ALERT: Saving file name

    class func getAlertNameTheFile(completion: @escaping (_ fileName: String) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Name the file", message: nil, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let txtField = alert.textFields?.first, let text = txtField.text {
                completion(text)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }

        alert.addTextField { (textField) in
            textField.placeholder = "File name"
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        
        return alert
    }
    
    class func createFileMaxSizeErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Max Size Error", message: "The file exceeded maximum size", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(confirmAction)
        
        return alert
    }
    
    class func createFileExtansionErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Type Error", message: "Unsupported file type", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(confirmAction)
        
        return alert
    }
}
