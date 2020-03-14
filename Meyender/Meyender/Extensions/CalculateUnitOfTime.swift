import Foundation



/// Work out whether the number of seconds should be written as minutes or seconds
/// - Parameter seconds: how long a certain activity is
/// - Returns: a string with the time given in its correct form alongside its appropriate unit of time
func calculateUnitOfTime(seconds:Double) -> String {
    if seconds > 60 {
        
        return String(format: "%.0f", (seconds/60).rounded()) + " MINS"
    } else if seconds == 60 {
        return String(format: "%.0f", (seconds/60).rounded()) + " MIN"

    } else {
        
        return String(format: "%.0f", seconds.rounded()) + " SECS"
    }
}

