import UIKit

class PlayExerciseVC: UIViewController {

    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextActivityButton: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    /// set of activities to go through
    var sessions: [Activity] = []
    
    /// the activity that is currently being played
    var currentSession: Activity? = focusSession

    /// index of current sessions array element that is being played
    var currentSessionIndex: Int = 0
    
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

    }
    
    deinit {
        stopwatch = nil
        stopwatch?.stop()
    }
    
    func setup(exercises:[Activity]) {
        currentSession = exercises[currentSessionIndex]
        sessions = exercises
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
        if currentSessionIndex < (sessions.count - 1)  {
            currentSessionIndex = currentSessionIndex + 1
            updateCurrentSession(newSession: sessions[currentSessionIndex + 1])
        } else {
            currentSessionIndex = 0
            updateCurrentSession(newSession: sessions[currentSessionIndex])
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
        closeButton.tintColor = .primary
        nextActivityButton.isHidden = true
        nextActivityButton.isEnabled = false
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
        let hours = Int(timeInterval / 3600)
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }
}

