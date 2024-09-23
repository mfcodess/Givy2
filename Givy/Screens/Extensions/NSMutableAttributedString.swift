//
//  NSMutableAttributedString.swift
//  Givy
//
//  Created by Max on 21.07.2024.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func setTextColor(color: UIColor, toSubstring : String) {
        if let range = self.string.range(of: toSubstring) {
            let nsRange = NSRange(range, in: self.string)
            
            self.addAttributes([NSAttributedString.Key.foregroundColor: color], range: nsRange)
        }
    }
    
    func strikeThrough(thickness: Int, subString: String)  {
        if let range = self.string.range(of: subString) {
            self.strikeThrough(thickness: thickness, onRange: NSRange(range, in: self.string))
        }
    }
    
    func strikeThrough(thickness: Int, onRange: NSRange)  {
        self.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.thick.rawValue], range: onRange)
    }
}
