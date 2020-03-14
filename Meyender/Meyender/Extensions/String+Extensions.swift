//
//  String+Extensions.swift
//  Meyender
//
//  Created by Varun Gupta on 07/03/2020.
//  Copyright © 2020 Varun Gupta. All rights reserved.
//

import Foundation
import UIKit
extension String {
    
    /// Calculate the height of a label that would hold a specific string, given a certain font
    /// - Parameters:
    ///   - width: the fixed width of the component you are placing the string within
    ///   - font: the font you want the string in, ensure you specifiy the text size and the thickness of the font
    /// - Returns: the height of a component holding the string
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
        
    /// Calculate the width of a label that would hold a specific string, given a certain font
    /// - Parameters:
    ///   - height: the fixed height of the component you are placing the string within
    ///   - font: the font you want the string in, ensure you specifiy the text size and the thickness of the font
    /// - Returns: the width of a component holding the string
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
