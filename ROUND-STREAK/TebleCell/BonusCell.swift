//
//  BonusCell.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.
//

import UIKit
import QuartzCore

class BonusCell: UITableViewCell {

    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var bgFirst: UIImageView!
    @IBOutlet weak var bgSecond: UIImageView!
    @IBOutlet weak var bgThird: UIImageView!
    @IBOutlet weak var bgFourth: UIImageView!
    @IBOutlet weak var bgFifth: UIImageView!
    @IBOutlet weak var bgGiftView: UIImageView!
    @IBOutlet weak var bgGiftTopView: UIImageView!
    
    @IBOutlet weak var numFirst: UILabel!
    @IBOutlet weak var numSecond: UILabel!
    @IBOutlet weak var numThird: UILabel!
    @IBOutlet weak var numFive: UILabel!
    @IBOutlet weak var numFour: UILabel!
    @IBOutlet weak var bonusNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func makeRoundedCornersToFirstView() {
        
        firstView.layer.masksToBounds = true
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: firstView.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: firstView.frame.size.width/2, height: firstView.frame.size.height/2)).cgPath
        firstView.layer.mask = maskLayer
    }
    
    private func makeRoundedCornersToFifthView() {
        
        fifthView.layer.masksToBounds = true
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: fifthView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: fifthView.frame.size.width/2, height: fifthView.frame.size.height/2)).cgPath
        fifthView.layer.mask = maskLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    override func draw(_ rect: CGRect) {
        makeRoundedCornersToFirstView()
        makeRoundedCornersToFifthView()
    }
    
    class func getCellIdentifier() -> String
    {
        return "BonusCell"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

