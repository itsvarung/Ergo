import UIKit

class HomeVC: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex: IndexPath?
    var selectedBodyPart: BodyPart?
    
    struct Section {
        var sectionTitle:String
        var sectionDescription: String
    }
    
    let sections: [Section] =  [Section(sectionTitle: "Todays power set", sectionDescription: "A set of whole body exercises to get the blood flowing and most importantly, the muscles stretched!"),
                                Section(sectionTitle: "Recommended", sectionDescription: "A couple of personalised exercises to help help relieve your every day pains and aches"),
                                Section(sectionTitle: "Where's the pain?", sectionDescription: "Help target your pain points with our body part specific exercises")]
    
    var powerSetExercises: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 300
        
        //Register Header
        let headerNib = UINib(nibName: "HomeVCSectionHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HomeVCSectionHeader")
        
        //Register PowerSet
        let powerSetNib = UINib(nibName: "PowerSetTableViewCell", bundle: nil)
        tableView.register(powerSetNib, forCellReuseIdentifier: "PowerSetTableViewCell")
        
        //Register Recommended
        let recommendedNib = UINib(nibName: "RecommendedTableViewCell", bundle: nil)
        tableView.register(recommendedNib, forCellReuseIdentifier: "RecommendedTableViewCell")
        
        //Register Body Parts Grid
        let bodyPartsNib = UINib(nibName: "BodyPartsTableViewCell", bundle: nil)
        tableView.register(bodyPartsNib, forCellReuseIdentifier: "BodyPartsTableViewCell")
        
        //Stop the table view sticky header
        let dummyViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)

        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.primary]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        powerSetExercises = generatePowerSet(exercises: exercises)

        setStyling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showExerciseVCCV",
            let destination = segue.destination as? ExerciseVC,
            let selectedExerciseIndex = selectedIndex
        {
            destination.exercise = exercises[selectedExerciseIndex.row]
        } else if segue.identifier == "ShowBodyPartExercisesVC", let destination = segue.destination as? BodyPartVC, let bodyPart = selectedBodyPart {
            destination.bodyPart = bodyPart
            destination.bodyPartExercises = exercises.filter { $0.bodyPart == bodyPart}
        }

    }
    func setStyling() {
        view.backgroundColor = UIColor.containerSecondary
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PowerSetTableViewCell") as? PowerSetTableViewCell else {
                return UITableViewCell()
            }
                    
            if powerSetExercises.count == 3 {
                cell.setup(exercise1: powerSetExercises[0], exercise2: powerSetExercises[1], exercise3: powerSetExercises[2])
                return cell
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 1 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "RecommendedTableViewCell") as? RecommendedTableViewCell else {
                return UITableViewCell()
            }
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            return cell
        }else if indexPath.section == 2 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "BodyPartsTableViewCell") as? BodyPartsTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let playActivityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayExerciseVC") as! PlayExerciseVC

            playActivityVC.setup(exercises: powerSetExercises)
            self.present(playActivityVC, animated: true, completion: nil)
        }
    }
}

 
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath as IndexPath) as? RecommendedCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.setup(exercise: exercises[indexPath.row])
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

extension HomeVC: BodyPartsTableViewCellDelegate {
    func selectedBodyPart(bodyPart: BodyPart) {
        selectedBodyPart = bodyPart
        performSegue(withIdentifier: "ShowBodyPartExercisesVC", sender: self)
    }
}
