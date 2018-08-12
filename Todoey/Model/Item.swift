//
//  Item.swift
//  Todoey
//
//  Created by Anton on 11.08.18.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation

class Item {
    var title : String
    var done : Bool
    
    init(_ title : String, _ done : Bool) {
        self.title = title
        self.done = done
    }
}
