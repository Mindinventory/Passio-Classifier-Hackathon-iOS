//
//  YogaListCell.swift
//  YogaPose
//
//  Created by Harsh on 03/10/22.
//

import UIKit

class YogaListCell: UITableViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblYogaPoseName: UILabel!
    @IBOutlet weak var lblYogaDescription: UILabel!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var buttonMore: UIButton!
    @IBOutlet weak var imgYogaPose: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    private func configUI() {
        imgYogaPose.layer.cornerRadius = imgYogaPose.frame.size.height / 2
        viewBackground.layer.cornerRadius = 10.0
        viewBackground.layer.borderWidth = 2.0
        viewBackground.layer.borderColor = UIColor.borderColor.cgColor
        lblYogaDescription.alpha = 0.8
        lblYogaDescription.font = UIFont.custom(name: FontName.DMSansRegular, size: 14)
        btnDetails.setImage(UIImage(named: "ic_arrowDetails"), for: .normal)
        lblYogaPoseName.font = UIFont.custom(name: FontName.DMSansMedium, size: 18)
    }
    func configCell(yoga: YogaList){
        
        self.selectionStyle = .none
        lblYogaPoseName.text = yoga.name
        imgYogaPose.image = UIImage(named: yoga.passioID ?? "")
        lblYogaDescription.numberOfLines = 2
        lblYogaDescription.text = yoga.description
        
        lblYogaDescription.numberOfLines = yoga.isExpanded ?? false ? 0 : 2
        buttonMore.setTitle(yoga.isExpanded ?? false ? "Read less..." : "Read more...", for: .normal)
    }
}
