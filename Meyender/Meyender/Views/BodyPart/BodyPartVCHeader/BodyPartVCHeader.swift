import UIKit

protocol BodyPartVCHeaderDelegate:class {
    func onPressBack()
}
class BodyPartVCHeader: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    weak var delegate: BodyPartVCHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        initialise()
    }
    
    private func initialise() {
        Bundle.main.loadNibNamed("BodyPartVCHeader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        titleLabel.textColor = .primary
        backButton.tintColor = .primary
    }
    
    func setup(bodyPart: BodyPart) {
        backgroundView.backgroundColor = UIColor.containerPrimary
        cardView.backgroundColor = UIColor.containerSecondary
        cardView.layer.cornerRadius = 30
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        titleLabel.text = bodyPart.rawValue.uppercased()
    }
    
    @IBAction func onPressBack(_ sender: Any) {
        delegate?.onPressBack()
    }
}
