//
//  Item.swift
//  Todoey
//
//  Created by Droege, Karla on 1/23/19.
//  Copyright © 2019 Droege, Karla. All rights reserved.
//

import Foundation

class Item: Codable {
    var title : String
    var done : Bool = false
    
    init(title: String) {
        self.title = title
    }
    
}
