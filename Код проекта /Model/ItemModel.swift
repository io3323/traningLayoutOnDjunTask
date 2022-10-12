//
//  ItemModel.swift
//  iterQR
//
//  Created by Игорь Островский on 12.10.2022.
//

import Foundation
import UIKit
struct ItemModel: Hashable, Decodable{
    var firstImage: String
    var titleLabel:String
    var subTitleLabel:String
    var statusLabel:String
    var secondImage:String
}
