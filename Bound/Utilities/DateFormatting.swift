import Foundation

extension Date {
    var boundFormatted: String {
        let calendar = Calendar.current
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let timeString = timeFormatter.string(from: self)

        if calendar.isDateInToday(self) {
            return "Today, \(timeString)"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday, \(timeString)"
        } else {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "MMM d"
            return "\(dayFormatter.string(from: self)), \(timeString)"
        }
    }
}
