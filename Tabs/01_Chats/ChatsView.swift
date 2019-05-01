
class ChatsView: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, SelectUserDelegate {

	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var tableView: UITableView!

	private var timer: Timer?
	private var dbchats: RLMResults = DBChat.objects(with: NSPredicate(value: false))

	//----------------------------------------------
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		tabBarItem.image = UIImage(named: "tab_chats")
		tabBarItem.title = "Chats"

		NotificationCenterX.addObserver(target: self, selector: #selector(actionCleanup), name: NOTIFICATION_USER_LOGGED_OUT)
		NotificationCenterX.addObserver(target: self, selector: #selector(refreshTableView), name: NOTIFICATION_USER_LOGGED_IN)
		NotificationCenterX.addObserver(target: self, selector: #selector(refreshTabCounter), name: NOTIFICATION_USER_LOGGED_IN)
		NotificationCenterX.addObserver(target: self, selector: #selector(refreshTableView), name: NOTIFICATION_REFRESH_CHATS)
		NotificationCenterX.addObserver(target: self, selector: #selector(refreshTabCounter), name: NOTIFICATION_REFRESH_CHATS)
		NotificationCenterX.addObserver(target: self, selector: #selector(refreshTableView), name: NOTIFICATION_REFRESH_STATUSES)
		NotificationCenterX.addObserver(target: self, selector: #selector(refreshTabCounter), name: NOTIFICATION_REFRESH_STATUSES)
	}

	//----------------------------------------------
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
	}

	//----------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Chats"

	
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(actionCompose))

		timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(refreshTableView), userInfo: nil, repeats: true)

		tableView.register(UINib(nibName: "ChatsCell", bundle: nil), forCellReuseIdentifier: "ChatsCell")

		tableView.tableFooterView = UIView()

		loadChats()
	}

	//-----------------------------------------------
	override func viewDidAppear(_ animated: Bool) {

		super.viewDidAppear(animated)

		if (FUser.currentId() != "") {
			if (FUser.isOnboardOk()) {
				refreshTableView()
			} else {
				OnboardUser(target: self)
			}
		} else {
			LoginUser(target: self)
		}
	}

	// MARK: - Realm methods
	//----------------------------------------------
	func loadChats() {

		var predicate = NSPredicate(format: "isArchived == NO AND isDeleted == NO")

		if let text = searchBar.text {
			if (text.count != 0) {
				predicate = NSPredicate(format: "isArchived == NO AND isDeleted == NO AND details CONTAINS[c] %@", text)
			}
		}

		dbchats = DBChat.objects(with: predicate).sortedResults(usingKeyPath: "lastMessageDate", ascending: false)

		refreshTableView()
		refreshTabCounter()
	}

	// MARK: - Refresh methods
	//----------------------------------------------
	@objc func refreshTableView() {

		tableView.reloadData()
	}

	//-----------------------------------------------
	@objc func refreshTabCounter() {

		var total: Int = 0

		for i in 0..<dbchats.count {
			let dbchat = dbchats[i] as! DBChat
			
			let lastRead = Status.lastRead(chatId: dbchat.chatId)
			if (lastRead < dbchat.lastIncoming) { total += 1 }
		}

		let item = tabBarController?.tabBar.items?[0]
		item?.badgeValue = (total != 0) ? "\(total)" : nil

		UIApplication.shared.applicationIconBadgeNumber = total
	}

	@objc func actionCompose() {
		
		let selectUserView = SelectUserView()
		selectUserView.delegate = self
		let navController = NavigationController(rootViewController: selectUserView)
		present(navController, animated: true)
	}


	func actionNewChat() {

		if (tabBarController?.tabBar.isHidden ?? true) { return }

		tabBarController?.selectedIndex = 0

		actionCompose()
	}

	//-----------------------------------------------
	func actionRecentUser(userId: String) {

		if (tabBarController?.tabBar.isHidden ?? true) { return }

		tabBarController?.selectedIndex = 0

		actionChatPrivate(recipientId: userId)
	}

	//----------------------------------------------
	func actionChatPrivate(recipientId: String) {

		let chatPrivateView = ChatPrivateView()
		chatPrivateView.myInit(recipientId: recipientId)
		chatPrivateView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(chatPrivateView, animated: true)
	}


	func actionDelete(index: Int) {

		let dbchat = dbchats[UInt(index)] as! DBChat

		Chat.deleteItem(dbchat: dbchat)
		refreshTabCounter()

		let indexPath = IndexPath(row: index, section: 0)
		tableView.deleteRows(at: [indexPath], with: .fade)

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
			self.refreshTableView()
		}
	}

	// MARK: - SelectUserDelegate
	//-----------------------------------------------
	func didSelectUser(dbuser: DBUser) {

		actionChatPrivate(recipientId: dbuser.objectId)
	}

	// MARK: - Cleanup methods
	//-----------------------------------------------
	@objc func actionCleanup() {

		refreshTableView()
		refreshTabCounter()
	}

	// MARK: - UIScrollViewDelegate
	//----------------------------------------------
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

		view.endEditing(true)
	}

	// MARK: - Table view data source
	//-----------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}

	//----------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return Int(dbchats.count)
	}

	//----------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsCell", for: indexPath) as! ChatsCell

		cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.red)]

		cell.delegate = self
		cell.tag = indexPath.row

		let dbchat = dbchats[UInt(indexPath.row)] as! DBChat
		cell.bindData(dbchat: dbchat)
		cell.loadImage(dbchat: dbchat, tableView: tableView)

		return cell
	}

	// MARK: - MGSwipeTableCellDelegate
	//-----------------------------------------------
	func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {

		if (index == 0) { actionDelete(index: cell.tag) }

		return true
	}

	// MARK: - Table view delegate
	//----------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		let dbchat = dbchats[UInt(indexPath.row)] as! DBChat

		if (dbchat.recipientId.count != 0)	{	actionChatPrivate(recipientId: dbchat.recipientId)	}
	}

	// MARK: - UISearchBarDelegate
	//----------------------------------------------
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

		loadChats()
	}

	//----------------------------------------------
	func searchBarTextDidBeginEditing(_ searchBar_: UISearchBar) {

		searchBar.setShowsCancelButton(true, animated: true)
	}

	//----------------------------------------------
	func searchBarTextDidEndEditing(_ searchBar_: UISearchBar) {

		searchBar.setShowsCancelButton(false, animated: true)
	}

	//-----------------------------------------------
	func searchBarCancelButtonClicked(_ searchBar_: UISearchBar) {

		searchBar.text = ""
		searchBar.resignFirstResponder()
		loadChats()
	}

	//-----------------------------------------------
	func searchBarSearchButtonClicked(_ searchBar_: UISearchBar) {

		searchBar.resignFirstResponder()
	}
}
