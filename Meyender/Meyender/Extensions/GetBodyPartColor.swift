import Foundation
import UIKit

func getBodyPartColor(bodyPart: BodyPart) -> UIColor {
    switch bodyPart {
    case .back:
        return UIColor.back ?? UIColor.white
    case .neck:
        return UIColor.neck ?? UIColor.white
    case .legs:
        return UIColor.legs ?? UIColor.white
    case .eyes:
        return UIColor.eyes ?? UIColor.white
    case .hands:
        return UIColor.hands ?? UIColor.white
    case .arms:
        return UIColor.arms ?? UIColor.white
    default:
        return UIColor.white
    }
}
