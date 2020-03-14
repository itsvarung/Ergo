//
//  BodyPartsTableViewCell.swift
//  Meyender
//
//  Created by Varun Gupta on 08/03/2020.
//  Copyright © 2020 Varun Gupta. All rights reserved.
//

import UIKit

protocol BodyPartsTableViewCellDelegate: class {
    func selectedBodyPart(bodyPart: BodyPart)
}

class BodyPartsTableViewCell: UITableViewCell {

    @IBOutlet weak var armsView: UIView!
    @IBOutlet weak var armsLabel: UILabel!
    @IBOutlet weak var eyesView: UIView!
    @IBOutlet weak var eyesLabel: UILabel!
    @IBOutlet weak var neckView: UIView!
    @IBOutlet weak var neckLabel: UILabel!
    @IBOutlet weak var handsView: UIView!
    @IBOutlet weak var handsLabel: UILabel!
    @IBOutlet weak var legsView: UIView!
    @IBOutlet weak var legsLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backLabel: UILabel!
    
    weak var delegate : BodyPartsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        armsView.layer.cornerRadius = 5
        eyesView.layer.cornerRadius = 5
        neckView.layer.cornerRadius = 5
        handsView.layer.cornerRadius = 5
        legsView.layer.cornerRadius = 5
        backView.layer.cornerRadius = 5
        
        armsView.backgroundColor = .containerPrimary
        eyesView.backgroundColor = .containerPrimary
        neckView.backgroundColor = .containerPrimary
        handsView.backgroundColor = .containerPrimary
        legsView.backgroundColor = .containerPrimary
        backView.backgroundColor = .containerPrimary
        
        armsLabel.textColor = .primary
        eyesLabel.textColor = .primary
        neckLabel.textColor = .primary
        handsLabel.textColor = .primary
        legsLabel.textColor = .primary
        backLabel.textColor = .primary
        
        neckView.tag = 0
        armsView.tag = 1
        handsView.tag = 2
        eyesView.tag = 3
        legsView.tag = 4
        backView.tag = 5
        
        
        let neckTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.yourFunction))
        let armsTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.yourFunction))
        let handsTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.yourFunction))
        let eyesTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.yourFunction))
        let legsTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.yourFunction))
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.yourFunction))

        neckView.isUserInteractionEnabled = true
        armsView.isUserInteractionEnabled = true
        handsView.isUserInteractionEnabled = true
        eyesView.isUserInteractionEnabled = true
        legsView.isUserInteractionEnabled = true
        backView.isUserInteractionEnabled = true
        
        neckView.addGestureRecognizer(neckTapGesture)
        armsView.addGestureRecognizer(armsTapGesture)
        handsView.addGestureRecognizer(handsTapGesture)
        eyesView.addGestureRecognizer(eyesTapGesture)
        legsView.addGestureRecognizer(legsTapGesture)
        backView.addGestureRecognizer(backTapGesture)
    }
    
    @objc func yourFunction(_ sender: AnyObject) {
        let yourTag = sender.view?.tag
        switch yourTag {
        case 0:
            delegate?.selectedBodyPart(bodyPart: .neck)
        case 1:
            delegate?.selectedBodyPart(bodyPart: .arms)
        case 2:
            delegate?.selectedBodyPart(bodyPart: .hands)
        case 3:
            delegate?.selectedBodyPart(bodyPart: .eyes)
        case 4:
            delegate?.selectedBodyPart(bodyPart: .legs)
        case 5:
            delegate?.selectedBodyPart(bodyPart: .back)
            
        default:
            delegate?.selectedBodyPart(bodyPart: .neck)
        }
        
    }
}
