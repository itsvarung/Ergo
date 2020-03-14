import UIKit

class FocusSessionVC: UIViewController {

    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextActivityButton: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var currentSession: Activity? = focusSession
    
    /// is this a focus episode which requires multiple back to back sessions, alternating between focus session, short break and exercise or just a single exercise
    var isFocusEpisode: Bool = true
    
    private lazy var stopwatch: Stopwatch? = Stopwatch(timeUpdated: { [weak self] timeInterval in
        
        //Every second
        guard let self = self, let currentSessionLength = self.currentSession?.length else { return }
        
        //Check if we've reached the end of the session
        if timeInterval < currentSessionLength {
            
            //If not update labels
            self.timeElapsedLabel.text = self.timeString(from: timeInterval)
            self.timeRemainingLabel.text = self.timeString(from: currentSessionLength - timeInterval)
            self.progressBar.progress = Float(timeInterval/currentSessionLength)
            
        //Else reset timer
        } else {
            self.prepareForNextActivity()
        }
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyling()
        
        //Pull last session from memory
        guard let currentSession = currentSession else {return}
        updateCurrentSession(newSession: currentSession)
        
        if isFocusEpisode == true {
            closeButton.isHidden = true
            closeButton.isEnabled = false
        } else {
            closeButton.tintColor = .primary
            
            nextActivityButton.isHidden = true
            nextActivityButton.isEnabled = false
        }
    }
    
    deinit {
        stopwatch = nil
        stopwatch?.stop()
    }
    
    func setup(exercise:Activity) {
        isFocusEpisode = false
        currentSession = exercise
    }
    
    func updateCurrentSession(newSession:Activity) {
        currentSession = newSession
        guard let currentSession = currentSession else {return}
        activityNameLabel.text = currentSession.name
        timeElapsedLabel.text = timeString(from: 0)
        timeRemainingLabel.text = timeString(from: currentSession.length)
    }
    
    func prepareForNextActivity() {
        stopwatch?.stop()
        playPauseButton.setImage(#imageLiteral(resourceName: "play-icon"), for: .normal)
        
        //If this is a one off activity, set up VC with same activity, just restart timer, reset labels etc.
        if isFocusEpisode == false {
            guard let currentSession = currentSession else {return}
            updateCurrentSession(newSession: currentSession)
            
        //Else set up for next activity
        } else {
            switch currentSession?.type {
            case .focusSession:
                guard let exercise = exercises.randomElement() else {return}
                updateCurrentSession(newSession: exercise)
            case .exercise:
                updateCurrentSession(newSession: shortBreak)
            case .shortBreak:
                updateCurrentSession(newSession: focusSession)
            default:
                updateCurrentSession(newSession: focusSession)
            }
        }
        
    }
    
    @IBAction func pressedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: {})

        guard let navController = navigationController else {return}
        navController.popViewController(animated: true)
    }
    
    @IBAction func onPlayPause(_ sender: Any) {
        stopwatch?.toggle()
        
        if stopwatch?.isPaused == true {
            playPauseButton.setImage(#imageLiteral(resourceName: "play-icon"), for: .normal)
        } else {
            playPauseButton.setImage(#imageLiteral(resourceName: "pause-icon"), for: .normal)
        }
        playPauseButton.tintColor = UIColor.primary
    }
    
    @IBAction func onSkip(_ sender: Any) {
        prepareForNextActivity()
    }
    
    func setStyling() {
        background.backgroundColor = UIColor.containerSecondary
        playPauseButton.tintColor = UIColor.primary
        nextActivityButton.tintColor = UIColor.primary
        activityNameLabel.textColor = UIColor.primary
        progressBar.progressTintColor = UIColor.primary
        timeElapsedLabel.textColor = UIColor.primary
        timeRemainingLabel.textColor = UIColor.primary
        timeElapsedLabel.text = "00:00:00"
        timeRemainingLabel.text = "00:00:00"
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
        let hours = Int(timeInterval / 3600)
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }
    
}

