func Date2Short(date: Date) -> String {

	return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
}

//-----------------------------------------------
func Date2Medium(date: Date) -> String {

	return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
}

//----------------------------------------------
func Date2MediumTime(date: Date) -> String {

	return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
}

//----------------------------------------------
func TimeElapsed(timestamp: Int64) -> String {

	var elapsed = ""

	let date = Date.date(timestamp: timestamp)
	let seconds = Date().timeIntervalSince(date)

	if (seconds < 60) {
		elapsed = "Just now"
	} else if (seconds < 60 * 60) {
		let minutes = Int(seconds / 60)
		let text = (minutes > 1) ? "mins" : "min"
		elapsed = "\(minutes) \(text)"
	} else if (seconds < 24 * 60 * 60) {
		let hours = Int(seconds / (60 * 60))
		let text = (hours > 1) ? "hours" : "hour"
		elapsed = "\(hours) \(text)"
	} else if (seconds < 7 * 24 * 60 * 60) {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE"
		elapsed = formatter.string(from: date)
	} else {
		elapsed = Date2Short(date: date)
	}

	return elapsed
}
