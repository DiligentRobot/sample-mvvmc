//
//  DetailModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2018 Diligent Robot Ltd. All rights reserved.
//

import Foundation

protocol DetailModel
{
    func detail(_ completionHandler: @escaping (_ item: DataItem?) -> Void)
}
