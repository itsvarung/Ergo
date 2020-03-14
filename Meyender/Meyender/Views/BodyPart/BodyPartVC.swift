import UIKit

class BodyPartVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var headerView: BodyPartVCHeader?
    var bodyPart: BodyPart? = .eyes
    var bodyPartExercises: [Activity] = []
    var improvementFilteredExercises: [[Activity]]? = []
    var selectedIndex: IndexPath?
    var selectedTableViewSection: Int?
    var currentTableViewSectionBeingCreated: Int = 0
    var sections: [Section] =  [Section(sectionTitle: "Power Set", sectionDescription: "A set of 3 exercises put together to help relieve discomfort!")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        //Register Header
        let headerNib = UINib(nibName: "HomeVCSectionHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HomeVCSectionHeader")
        
        //Register PowerSet
        let powerSetNib = UINib(nibName: "PowerSetTableViewCell", bundle: nil)
        tableView.register(powerSetNib, forCellReuseIdentifier: "PowerSetTableViewCell")
        
        //Register Recommended
        let recommendedNib = UINib(nibName: "RecommendedTableViewCell", bundle: nil)
        tableView.register(recommendedNib, forCellReuseIdentifier: "RecommendedTableViewCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 300
        
        //Stop the table view sticky header
        let dummyViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        createFilteredExerciseArrays()
        createHeader()
        setStyling()
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
        headerView = BodyPartVCHeader()
        guard let headerView = headerView, let bodyPart = bodyPart else { return }
        headerView.setup(bodyPart: bodyPart)
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        sizeHeaderToFit()
    }
    
    func createFilteredExerciseArrays() {
        var uniqueImprovements = [Improvement]()
        
        for exercise in bodyPartExercises {
            guard let improvement = exercise.helpsWith else {continue}
            if !uniqueImprovements.contains(improvement) {
                uniqueImprovements.append(improvement)
            }
        }
        
        for improvement in uniqueImprovements {
            sections.append(Section(sectionTitle: improvement.rawValue, sectionDescription: ""))
            improvementFilteredExercises?.append(bodyPartExercises.filter { $0.helpsWith == improvement})
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Hello")
        print("Hello tv section" + String(selectedIndex!.row))
        print("Hello exercise index" + String(selectedTableViewSection!))
        if  segue.identifier == "showExerciseVCCV",
            let destination = segue.destination as? ExerciseVC,
            let selectedExerciseIndex = selectedIndex,
            let selectedTableViewSection = selectedTableViewSection
        {
            print("Hello tv section" + String(selectedTableViewSection))
            print("Hello exercise index" + String(selectedExerciseIndex.row))
            guard let section = tableView.indexPathForSelectedRow?.section, let exercises =  improvementFilteredExercises else {return}
            destination.exercise = exercises[selectedTableViewSection - 1][selectedExerciseIndex.row]
        }
    }
}


extension BodyPartVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PowerSetTableViewCell") as? PowerSetTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setup(exercise1: exercises.randomElement()!, exercise2: exercises.randomElement()!, exercise3: exercises.randomElement()!)
            return cell
        } else {
            currentTableViewSectionBeingCreated = indexPath.section
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "RecommendedTableViewCell") as? RecommendedTableViewCell else {
                return UITableViewCell()
            }
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeVCSectionHeader") as? HomeVCSectionHeader else {
            return UIView()
        }
        
        cell.titleLabel.text = sections[section].sectionTitle
        cell.descriptionLabel.text = sections[section].sectionDescription
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTableViewSection = indexPath.section
    }
}
extension BodyPartVC {
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

extension BodyPartVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return improvementFilteredExercises?[currentTableViewSectionBeingCreated-1].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath as IndexPath) as? RecommendedCollectionViewCell, let exercises = improvementFilteredExercises else {
                return UICollectionViewCell()
        }
        cell.setup(exercise: exercises[currentTableViewSectionBeingCreated-1][indexPath.row] )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 270, height: 150)
    }
    
    override func systemLayoutFittingSizeDidChange(forChildContentContainer container: UIContentContainer) {
        tableView.layoutIfNeeded()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "showExerciseVCCV", sender: self)
    }
}

extension BodyPartVC: BodyPartVCHeaderDelegate {
    func onPressBack() {
        guard let navController = navigationController else {return}
        navController.popViewController(animated: true)
    }
}
