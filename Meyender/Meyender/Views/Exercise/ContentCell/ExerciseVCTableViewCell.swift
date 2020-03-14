import UIKit

class ExerciseVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var instructionlabel: UILabel!
    @IBOutlet weak var actionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyling()
    }
    func setStyling() {
        background.backgroundColor = .containerSecondary
        background.layer.cornerRadius = 10
        background.layer.borderWidth = 0.4
        background.layer.borderColor = UIColor.secondary?.cgColor
        numberLabel.textColor = .secondary
        instructionlabel.textColor = .primary
        
    }
}
