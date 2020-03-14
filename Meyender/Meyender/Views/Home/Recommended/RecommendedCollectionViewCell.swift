import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var helpsWithButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 10
        bodyPartLabel.textColor = .primary
        titleLabel.textColor = .primary
        lengthLabel.textColor = .primary
        helpsWithButton.backgroundColor = .primary
        helpsWithButton.layer.cornerRadius = 5
    }
    
    func setup(exercise: Activity) {
        background.backgroundColor = .containerPrimary
        helpsWithButton.setTitleColor(.containerPrimary, for: .normal)
        titleLabel.text = exercise.name
        bodyPartLabel.text = exercise.bodyPart?.rawValue.uppercased()
        lengthLabel.text = calculateUnitOfTime(seconds: exercise.length)
        helpsWithButton.setTitle(exercise.helpsWith?.rawValue.uppercased(), for: .normal)
    }

}
