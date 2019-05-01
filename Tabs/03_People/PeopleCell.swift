
class PeopleCell: UITableViewCell {

	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelInitials: UILabel!
	@IBOutlet var labelName: UILabel!
	@IBOutlet var labelStatus: UILabel!

	//----------------------------------------------
	func bindData(dbuser: DBUser) {

		labelName.text = dbuser.fullname
		labelStatus.text = dbuser.status
	}

	//-----------------------------------------------
	func loadImage(dbuser: DBUser, tableView: UITableView, indexPath: IndexPath) {

		imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
		imageUser.layer.masksToBounds = true

		if (dbuser.thumbnail != "") {
			if let path = DownloadManager.pathImage(link: dbuser.thumbnail) {
				imageUser.image = UIImage(contentsOfFile: path)
				labelInitials.text = nil
			} else {
				imageUser.image = UIImage(named: "people_blank")
				labelInitials.text = dbuser.initials()
				downloadImage(dbuser: dbuser, tableView: tableView, indexPath: indexPath)
			}
		} else {
			imageUser.image = UIImage(named: "people_blank")
			labelInitials.text = dbuser.initials()
		}
	}

	//----------------------------------------------
	func downloadImage(dbuser: DBUser, tableView: UITableView, indexPath: IndexPath) {

		DownloadManager.image(link: dbuser.thumbnail) { path, error, network in
			if (error == nil) {
				if (tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false) {
					let cell = tableView.cellForRow(at: indexPath) as! PeopleCell
					cell.imageUser.image = UIImage(contentsOfFile: path!)
					cell.labelInitials.text = nil
				}
			} else if ((error! as NSError).code == 102) {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					self.downloadImage(dbuser: dbuser, tableView: tableView, indexPath: indexPath)
				}
			}
		}
	}
}
