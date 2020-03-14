import Foundation

struct Activity {
    var name : String
    var benifits: String
    var bodyPart: BodyPart
    var helpsWith: [Improvement]
    var length : Int
    var steps : [Step]
}

struct Step {
    var instruction: String
    var animation: String
}

enum Improvement: String {
    case focus = "Focus"
    case bluryVision = "Blury Vision"
    case eyeFatigue = "Eye Fatigue"
    case muscleStrength = "Muscle Strength"
    case muscleFlexibility = "Muscle Flexibility"
}

enum BodyPart {
    case neck
    case back
    case shoulder
    case eyes
    case hand
}
