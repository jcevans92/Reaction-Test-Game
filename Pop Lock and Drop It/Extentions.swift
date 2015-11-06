//
//  Extentions.swift
//  Pop Lock and Drop It
//
//  Created by Jeremy Evans on 11/5/15.
//  Copyright © 2015 Jeremy Evans. All rights reserved.
//

import Foundation
import SpriteKit

extension CGFloat {
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        
            return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
        
    }
}