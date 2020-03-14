import UIKit

class PowerSetTableViewCell: UITableViewCell {
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var exercise1CircleView: UIView!
    @IBOutlet weak var exercise2CircleView: UIView!
    @IBOutlet weak var exercise3CircleView: UIView!
    @IBOutlet weak var playIconImageView: UIImageView!
    @IBOutlet weak var exercise1Name: UILabel!
    @IBOutlet weak var exercise1Time: UILabel!
    @IBOutlet weak var exercise2Name: UILabel!
    @IBOutlet weak var exercise2Time: UILabel!
    @IBOutlet weak var exercise3Name: UILabel!
    @IBOutlet weak var exercise3Time: UILabel!
    @IBOutlet weak var playButtonArrowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background.backgroundColor = .primary
        background.layer.cornerRadius = 10
        playButtonArrowView.backgroundColor = .primary
        
        exercise1CircleView.layer.cornerRadius = exercise1CircleView.frame.size.width/2
        exercise1CircleView.clipsToBounds = true
        
        exercise2CircleView.layer.cornerRadius = exercise2CircleView.frame.size.width/2
        exercise2CircleView.clipsToBounds = true
        
        exercise3CircleView.layer.cornerRadius = exercise3CircleView.frame.size.width/2
        exercise3CircleView.clipsToBounds = true
        
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = .containerSecondary
        self.selectedBackgroundView = myCustomSelectionColorView
        
    }
    
    func setup(exercise1:Activity, exercise2:Activity, exercise3:Activity) {
        exercise1Name.text = exercise1.name
        exercise1Time.text = calculateUnitOfTime(seconds: exercise1.length)
        exercise2Name.text = exercise2.name
        exercise2Time.text = calculateUnitOfTime(seconds: exercise2.length)
        exercise3Name.text = exercise3.name
        exercise3Time.text = calculateUnitOfTime(seconds: exercise3.length)

    }
    
}
