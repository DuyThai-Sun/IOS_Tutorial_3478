//
//  CircleUIButton.swift
//  Tutorial3478
//
//  Created by Duy Thái on 13/12/2022.
//

import UIKit

class CircleUIButton: UIButton {

    override  func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }

}
