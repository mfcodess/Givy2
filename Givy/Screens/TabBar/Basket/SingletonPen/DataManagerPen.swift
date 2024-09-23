//
//  DataManagerPen.swift
//  Givy
//
//  Created by Max on 19.08.2024.
//

import Foundation
import UIKit

class Singleton {
    static let shared = Singleton()
    
    private init() {}
    
    var pens: [Pen] = []
    
    func addPen(pen: Pen) {
        pens.append(pen)
    }
    func removePen(at index: Int) {
        let removedPen = pens.remove(at: index)
        print("Removed pen: \(removedPen)")
    }
    
}

class Pen {
    var image: UIImage
    var name: String
    var price: String
    
    init(image: UIImage, name: String, price: String) {
        self.image = image
        self.name = name
        self.price = price
    }
}


