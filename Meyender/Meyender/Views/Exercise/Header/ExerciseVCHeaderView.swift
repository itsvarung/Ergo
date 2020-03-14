//
//  ExerciseVCHeaderView.swift
//  Meyender
//
//  Created by Varun Gupta on 03/03/2020.
//  Copyright © 2020 Varun Gupta. All rights reserved.
//

import UIKit

protocol ExerciseVCHeaderViewDelegate:class {
    func onPressPlay()
    func onPressBack()
}
class ExerciseVCHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    weak var delegate: ExerciseVCHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        initialise()
    }
    
    private func initialise() {
        Bundle.main.loadNibNamed("ExerciseVCHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        backgroundView.backgroundColor = .containerPrimary
        titleLabel.textColor = .primary
        timeLabel.textColor = .primary
        descriptionLabel.textColor = .primary
        playButton.tintColor = .primary
        backButton.tintColor = .primary


    }
    
    @IBAction func onPressPlay(_ sender: Any) {
        delegate?.onPressPlay()
    }
    
    @IBAction func onPressBack(_ sender: Any) {
        delegate?.onPressBack()
    }
}
