class NotificationCenterX: NSObject {

	//---------------------------------------------
	class func addObserver(target: Any, selector: Selector, name: String) {

	   NotificationCenter.default.addObserver(target, selector: selector, name: NSNotification.Name(name), object: nil)
	}

	//----------------------------------------------
	class func removeObserver(target: Any) {

		NotificationCenter.default.removeObserver(target)
	}

	//---------------------------------------------
	class func post(notification: String) {

		NotificationCenter.default.post(name: NSNotification.Name(notification), object: nil)
	}

	//----------------------------------------------
	class func post(notification: String, delay: TimeInterval) {

		DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
			self.post(notification: notification)
		}
	}
}
