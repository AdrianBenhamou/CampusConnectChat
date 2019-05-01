
class Statuses: NSObject {

	private var timer: Timer?
	private var refreshUIStatuses = false
	private var firebase: DatabaseReference?

	//-----------------------------------------------
	static let shared: Statuses = {
		let instance = Statuses()
		return instance
	} ()

	//-----------------------------------------------
	override init() {

		super.init()

		NotificationCenterX.addObserver(target: self, selector: #selector(initObservers), name: NOTIFICATION_APP_STARTED)
		NotificationCenterX.addObserver(target: self, selector: #selector(initObservers), name: NOTIFICATION_USER_LOGGED_IN)
		NotificationCenterX.addObserver(target: self, selector: #selector(actionCleanup), name: NOTIFICATION_USER_LOGGED_OUT)

		timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(refreshUserInterface), userInfo: nil, repeats: true)
	}

	// MARK: - Backend methods
	//----------------------------------------------
	@objc func initObservers() {

		if (FUser.currentId() != "") {
			if (firebase == nil) {
				createObservers()
			}
		}
	}

	//----------------------------------------------
	func createObservers() {

		let lastUpdatedAt = DBStatus.lastUpdatedAt()

		firebase = Database.database().reference(withPath: FSTATUS_PATH).child(FUser.currentId())
		let query = firebase?.queryOrdered(byChild: FSTATUS_UPDATEDAT).queryStarting(atValue: lastUpdatedAt + 1)

		query?.observe(DataEventType.childAdded, with: { snapshot in
			let status = snapshot.value as! [String: Any]
			if (status[FSTATUS_CREATEDAT] as? Int64 != nil) {
				DispatchQueue(label: "Statuses").async {
					self.updateRealm(status: status)
					self.refreshUIStatuses = true
				}
			}
		})

		query?.observe(DataEventType.childChanged, with: { snapshot in
			let status = snapshot.value as! [String: Any]
			if (status[FSTATUS_CREATEDAT] as? Int64 != nil) {
				DispatchQueue(label: "Statuses").async {
					self.updateRealm(status: status)
					self.refreshUIStatuses = true
				}
			}
		})
	}

	//----------------------------------------------
	func updateRealm(status: [String: Any]) {

		do {
			let realm = RLMRealm.default()
			realm.beginWriteTransaction()
			DBStatus.createOrUpdate(in: realm, withValue: status)
			try realm.commitWriteTransaction()
		} catch {
			ProgressHUD.showError("Realm commit error.")
		}
	}

	// MARK: - Cleanup methods
	//-----------------------------------------------
	@objc func actionCleanup() {

		firebase?.removeAllObservers()
		firebase = nil
	}

	// MARK: - Notification methods
	//----------------------------------------------
	@objc func refreshUserInterface() {

		if (refreshUIStatuses) {
			NotificationCenterX.post(notification: NOTIFICATION_REFRESH_STATUSES)
			refreshUIStatuses = false
		}
	}
}
