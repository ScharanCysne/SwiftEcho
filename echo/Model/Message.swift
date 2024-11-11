//
//  Message.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//


import Foundation
import SwiftUI

struct Message: Hashable, Codable, Identifiable {
    var id: Int
    var from: String
    var message: String
    
    var hour: Int
    var minute: Int
}
