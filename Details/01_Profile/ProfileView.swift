
class ProfileView: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet var tableView: UITableView!
	@IBOutlet var viewHeader: UIView!
	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelInitials: UILabel!
	@IBOutlet var labelName: UILabel!
	@IBOutlet var labelDetails: UILabel!
	@IBOutlet var cellStatus: UITableViewCell!
	@IBOutlet var cellCountry: UITableViewCell!
	@IBOutlet var cellLocation: UITableViewCell!
	@IBOutlet var cellMedia: UITableViewCell!
	@IBOutlet var cellChat: UITableViewCell!
	@IBOutlet var cellFriend: UITableViewCell!

	private var userId = ""
	private var isChatEnabled = false
	private var timer: Timer?
	private var dbuser: DBUser!

	//---------------------------------------------
	func myInit(userId userId_: String, chat chat_: Bool) {

		userId = userId_
		isChatEnabled = chat_

	}

	//----------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Profile"

		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

		tableView.tableHeaderView = viewHeader

		imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
		imageUser.layer.masksToBounds = true

		loadUser()
	}

	//----------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(loadUser), userInfo: nil, repeats: true)
	}

	//-----------------------------------------------
	override func viewWillDisappear(_ animated: Bool) {

		super.viewWillDisappear(animated)

		timer?.invalidate()
		timer = nil
	}

	// MARK: - Realm methods
	//----------------------------------------------
	@objc func loadUser() {

		let predicate = NSPredicate(format: "objectId == %@", userId)
		dbuser = DBUser.objects(with: predicate).firstObject() as? DBUser

		labelInitials.text = dbuser.initials()
		DownloadManager.image(link: dbuser.picture) { path, error, network in
			if (error == nil) {
				self.imageUser.image = UIImage(contentsOfFile: path!)
				self.labelInitials.text = nil
			}
		}

		labelName.text = dbuser.fullname

		cellStatus.detailTextLabel?.text = dbuser.status
		cellCountry.detailTextLabel?.text = dbuser.country
		cellLocation.detailTextLabel?.text = dbuser.location


		cellFriend.textLabel?.text = Friend.isFriend(userId: userId) ? "Remove Friend" : "Add Friend"

		tableView.reloadData()
	}

	// MARK: - User actions
	//----------------------------------------------
	@IBAction func actionPhoto(_ sender: Any) {

		if let picture = imageUser.image {
			let photoItems = PictureView.photos(picture: picture)
			let pictureView = PictureView(photos: photoItems)
			present(pictureView, animated: true)
		}
	}

	//----------------------------------------------




	func actionMedia() {

		let recipientId = dbuser.objectId
		let chatId = Chat.chatId(recipientId: recipientId)

		let allMediaView = AllMediaView()
		allMediaView.myInit(chatId: chatId)
		navigationController?.pushViewController(allMediaView, animated: true)
	}

	//----------------------------------------------
	func actionChatPrivate() {

		let chatPrivateView = ChatPrivateView()
		chatPrivateView.myInit(recipientId: dbuser.objectId)
		navigationController?.pushViewController(chatPrivateView, animated: true)
	}

	// MARK: - User actions (Friend/Unfriend)
	//----------------------------------------------
	func actionFriendOrUnfriend() {

		Friend.isFriend(userId: userId) ? actionUnfriend() : actionFriend()
	}

	//----------------------------------------------
	func actionFriend() {

		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		alert.addAction(UIAlertAction(title: "Add Friend", style: .default, handler: { action in
			self.actionFriendUser()
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		present(alert, animated: true)
	}

	//----------------------------------------------
	func actionFriendUser() {

		Friend.createItem(userId: userId)
		cellFriend.textLabel?.text = "Remove Friend"
	}

	//----------------------------------------------
	func actionUnfriend() {

		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		alert.addAction(UIAlertAction(title: "Remove Friend", style: .default, handler: { action in
			self.actionUnfriendUser()
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		present(alert, animated: true)
	}

	//----------------------------------------------
	func actionUnfriendUser() {

		Friend.deleteItem(userId: userId)
		cellFriend.textLabel?.text = "Add Friend"
	}


	// MARK: - Table view data source
	//----------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 3
	}

	//----------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (section == 0) {		return 3 }
		if (section == 1) {		return isChatEnabled ? 2 : 1	}
		if (section == 2) {		return 1						}

		return 0
	}

	//----------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) {	return cellStatus			}
		if (indexPath.section == 0) && (indexPath.row == 1) {	return cellCountry			}
		if (indexPath.section == 0) && (indexPath.row == 2) {	return cellLocation			}
		if (indexPath.section == 1) && (indexPath.row == 0) {	return cellMedia			}
		if (indexPath.section == 1) && (indexPath.row == 1) {	return cellChat				}
		if (indexPath.section == 2) && (indexPath.row == 0) {	return cellFriend			}

		return UITableViewCell()
	}

	// MARK: - Table view delegate
	//----------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 1) && (indexPath.row == 0) {	actionMedia()				}
		if (indexPath.section == 1) && (indexPath.row == 1) {	actionChatPrivate()			}
		if (indexPath.section == 2) && (indexPath.row == 0) {	actionFriendOrUnfriend()	}
	}
}
