//
//  MVVMCAuthenticateModel.swift
//  MVVM-C
//
//  Created by Scotty on 20/05/2016.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import Foundation

class MVVMCAuthenticateModel: AuthenticateModel
{
    func login(email: String, password: String, completionHandler: @escaping (_ error: NSError?) ->())
    {
        
        // Simulate Aysnchronous data access
        DispatchQueue.global().async {
            var error: NSError? = nil
            if email != "scotty@example.com" || password != "password" {
                error = NSError(domain: "MVVM-C",
                                code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Invalid Email or Password"])
            }
            completionHandler(error)
        }
    }
}
