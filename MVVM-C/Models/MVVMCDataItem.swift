//
//  MVVMCDataItem.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import Foundation

struct MVVMCDataItem: DataItem
{
    let name: String
    let role: String
    
    init(name: String, role: String)
    {
        self.name = name
        self.role = role
    }
}
