import Foundation
import UIKit

struct Activity {
    var name : String
    var type: ActivityType
    var image: UIImage
    var benifits: String? = nil
    var bodyPart: BodyPart? = nil
    var helpsWith: Improvement? = nil
    var length : Double
    var noOfRepeats: Int? = 0
    var steps : [Step]? = []
}

struct Step {
    var instruction: String
    var animation: String
}

enum ActivityType {
    case focusSession
    case shortBreak
    case exercise
}
enum Improvement: String {
    case focus = "Focus"
    case bluryVision = "Blury Vision"
    case eyeFatigue = "Eye Fatigue"
}

enum BodyPart: String {
    case neck = "Neck"
    case back = "Back"
    case shoulder = "Shoulder"
    case legs = "Legs"
    case arms = "Arms"
    case eyes = "Eyes"
    case hands = "Hands"
}
