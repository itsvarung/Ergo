import Foundation

var exercises: [Activity] = [
    zooming,
    nearAndFar,
    figureEight,
    palming,
    blinking
]

var focusSession = Activity(name: "Focus Session", type: .focusSession, image: #imageLiteral(resourceName: "exercise-image1"), length: 10)

var shortBreak = Activity(name: "Short Break",type: .shortBreak, image: #imageLiteral(resourceName: "exercise-image2"), length: 11)

var zooming = Activity(name: "Zooming",
                       type: .exercise,
                       image: #imageLiteral(resourceName: "exercise-image1"),
                       benifits: "Zooming is a great eye exercise for focusing and strengthening eye muscles. This exercises helps relax fatigued eyes and blurry vision.",
                       bodyPart: BodyPart.eyes,
                       helpsWith: Improvement.eyeFatigue,
                       length: 60,
                       noOfRepeats: 2,
                       steps: [
                        Step(instruction: "Hold your pointer finger a few inches away from your eye & focus on it", animation: ""),
                        Step(instruction: "Slowly move your finger away from your face, holding your focus.", animation: ""),
                        Step(instruction: "Look away for a moment, into the distance.", animation: ""),
                        Step(instruction: "Focus on your outstretched finger and slowly bring it back toward your eye.", animation: ""),
                        Step(instruction: "Look away for a moment, into the distance.", animation: ""),
                        Step(instruction: "Repeat.", animation: "")
])

var nearAndFar = Activity(name: "Near and far focus",
                          type: .exercise,
                          image: #imageLiteral(resourceName: "exercise-image2"),
                          benifits: "Focusing is a great eye exercise for focusing and strengthening eye muscles. The added strength helps your eyes perform all the movements necessary to increase your reading speed and expand their peripheral vision.",
                          bodyPart: BodyPart.eyes,
                          helpsWith:Improvement.bluryVision,
                          length: 60,
                          noOfRepeats: 3,
                          steps: [
                            Step(instruction: "Hold your thumb about 10 inches from your face and focus on it for 15 seconds.", animation: ""),
                            Step(instruction: "Find an object roughly 10 to 20 feet away, and focus on it for 15 seconds.", animation: ""),
                            Step(instruction: "Return your focus to your thumb.", animation: ""),
                            Step(instruction: "Repeat.", animation: "")])

var figureEight = Activity(name: "Figure eight",
                           type: .exercise,
                           image: #imageLiteral(resourceName: "exercise-image1"),
                           benifits: "This is a great exercise for the flexibility of the eye muscles. The added strength and flexibility helps your eyes perform all the movements necessary to increase your reading speed and expand their peripheral vision.",
                           bodyPart: BodyPart.eyes,
                           helpsWith: Improvement.focus,
                           length: 60,
                           noOfRepeats: 4,
                           steps: [
                            Step(instruction: "Pick a point on the floor about 10 feet in front of you and focus on it", animation: ""),
                            Step(instruction: "Trace an imaginary figure eight with your eyes.", animation: ""),
                            Step(instruction: "Switch directions.", animation: ""),
                            Step(instruction: "Repeat.", animation: "")])


var palming =  Activity(name: "Palming",
                        type: .exercise,
                        image: #imageLiteral(resourceName: "exercise-image3"),
                        benifits: "This simple exercise can help relieve eye strain and stress.",
                        bodyPart: BodyPart.eyes,
                        helpsWith: Improvement.eyeFatigue,
                        length: 120,
                        noOfRepeats: 1,
                        steps: [
                            Step(instruction: "Close your eyes and place both your hands on them. The palm of your hands should cover the eyes, the fingers on the forehead and the base of the palm resting on the cheekbone.", animation: ""),
                            Step(instruction: "Apply a slight amount of pressure onto your eyes, ensuring that your eyes can blink freely.", animation: ""),
                            Step(instruction: "Repeat.", animation: "")])

var blinking = Activity(name: "Blinking",
                        type: .exercise,
                        image: #imageLiteral(resourceName: "exercise-image2"),
                        benifits: "Encourage your eyes to produce more tears, keeping them moist so you can focus for longer. Reduces blury vision & increases focus",
                        bodyPart: BodyPart.eyes,
                        helpsWith: Improvement.focus,
                        length: 60,
                        noOfRepeats: 40,
                        steps: [
                            Step(instruction: "Blink", animation: "")])
