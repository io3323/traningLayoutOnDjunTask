//
//  ModelSection.swift
//  iterQR
//
//  Created by Игорь Островский on 12.10.2022.
//

import Foundation
import UIKit
struct ModelSection:Decodable, Hashable{
    var type:String
    var title:String
    var items:[ItemModel]
}
