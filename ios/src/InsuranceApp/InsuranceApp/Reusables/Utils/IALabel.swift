//
//  IALabel.swift
//  InsuranceApp
//
//  Created by rupendra on 5/30/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IALabel: LTMorphingLabel {
    var animatedText: String! {
        set {
            self.morphingEffect = LTMorphingEffect.Evaporate
            self.morphingDuration = 1.5
            self.text = newValue
        }
        get {
            return self.text
        }
    }
}
