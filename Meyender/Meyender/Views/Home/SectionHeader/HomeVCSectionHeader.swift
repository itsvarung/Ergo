import UIKit

class HomeVCSectionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        background.backgroundColor = .containerSecondary
        titleLabel.textColor = .primary
        descriptionLabel.textColor = .secondary
    }
}
