//
//  CellProtocol.swift
//  iterQR
//
//  Created by Игорь Островский on 12.10.2022.
//

import Foundation
import UIKit
protocol CellProtocol{
    static var reuseId: String {get}
    func configure(with moddel: ItemModel)
}
