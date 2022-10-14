//
//  CustomButton.swift
//  YogaPose
//
//  Created by Harsh on 13/10/22.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
    func configUI(){
        self.layer.cornerRadius = 16.0
        self.backgroundColor = .btnColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.custom(name: FontName.DMSansBold, size: 20.0)
    }
}
