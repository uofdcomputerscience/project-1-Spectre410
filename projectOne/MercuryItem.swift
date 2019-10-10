//
//  MercuryItem.swift
//  projectOne
//
//  Created by Matt Pritchett on 10/8/19.
//  Copyright © 2019 Matt Pritchett. All rights reserved.
//

import Foundation

struct MercuryItem: Codable {
    let name: String
    let type: String
    let url: String
    
    var imageURL: URL {
        return URL(string: url)!
    }
}
