import UIKit

class SpacingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setStyling()
    }
    func setStyling() {
        background.backgroundColor = .secondary
        
        
    }
}
