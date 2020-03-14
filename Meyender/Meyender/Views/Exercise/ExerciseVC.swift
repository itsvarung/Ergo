import UIKit

class ExerciseVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var exercise: Activity?
    var headerView: ExerciseVCHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ExerciseVCTableViewCell", bundle: nil), forCellReuseIdentifier: "ExerciseVCTableViewCell")
        tableView.register(UINib(nibName: "SpacingTableViewCell", bundle: nil), forCellReuseIdentifier: "SpacingTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
        
        //Stop the table view sticky header
        let dummyViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        createHeader()
        setStyling()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = tableView.tableHeaderView {

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    func setStyling() {
        tableView.backgroundColor = UIColor.containerSecondary
        view.backgroundColor = UIColor.containerSecondary

        self.navigationController?.navigationBar.barTintColor = UIColor.containerSecondary
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.tintColor = UIColor.accent
    }
    
    func createHeader() {
        headerView = ExerciseVCHeaderView()
        guard let headerView = headerView, let exercise = exercise else { return }
        headerView.descriptionLabel.text = exercise.benifits
        headerView.titleLabel.text = exercise.name
        headerView.timeLabel.text = calculateUnitOfTime(seconds: exercise.length)
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        sizeHeaderToFit()
    }
}

extension ExerciseVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let steps = exercise?.steps else {
            return 0
        }
        
        return (steps.count * 2) - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //If its an even row number, create a cell to show an instruction
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseVCTableViewCell", for: IndexPath(row: indexPath.row/2, section: 0)) as! ExerciseVCTableViewCell
            cell.numberLabel.text = String((indexPath.row/2) + 1) + "."
            guard let steps = exercise?.steps else {
                return UITableViewCell()
            }
            cell.instructionlabel.text = steps[indexPath.row/2].instruction
            return cell
            
        //Else create a spacer cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpacingTableViewCell", for: indexPath) as! SpacingTableViewCell
            return cell
        }
    }
}

extension ExerciseVC: ExerciseVCHeaderViewDelegate {
    func onPressBack() {
        guard let navController = navigationController else {return}
        navController.popViewController(animated: true)
    }
    
    func onPressPlay() {
        print("hi")
        let playActivityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FocusSessionVC") as! FocusSessionVC

        guard let exercise = exercise else {return}
        playActivityVC.setup(exercise: exercise)
        self.present(playActivityVC, animated: true, completion: nil)

    }
}

extension ExerciseVC {
    func sizeHeaderToFit() {
        if let headerView = tableView.tableHeaderView {
            
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = headerView.frame
            frame.size.height = height
            headerView.frame = frame
            
            tableView.tableHeaderView = headerView
        }
    }
}
