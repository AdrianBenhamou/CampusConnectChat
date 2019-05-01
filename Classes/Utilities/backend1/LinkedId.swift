class LinkedId: NSObject {

	//-----------------------------------------------
	class func createItem() {

		let userId1 = FUser.currentId()

		let firebase = Database.database().reference(withPath: FUSER_PATH).child(userId1).child(FUSER_LINKEDIDS)
		firebase.updateChildValues([userId1: true])
	}

	//----------------------------------------------
	class func createItem(userId userId2: String) {

		let userId1 = FUser.currentId()

		let firebase1 = Database.database().reference(withPath: FUSER_PATH).child(userId1).child(FUSER_LINKEDIDS)
		firebase1.updateChildValues([userId2: true])

		let firebase2 = Database.database().reference(withPath: FUSER_PATH).child(userId2).child(FUSER_LINKEDIDS)
		firebase2.updateChildValues([userId1: true])
	}

	//---------------------------------------------
	class func createItem(userId1: String, userId2: String) {

		let firebase1 = Database.database().reference(withPath: FUSER_PATH).child(userId1).child(FUSER_LINKEDIDS)
		firebase1.updateChildValues([userId2: true])

		let firebase2 = Database.database().reference(withPath: FUSER_PATH).child(userId2).child(FUSER_LINKEDIDS)
		firebase2.updateChildValues([userId1: true])
	}
}
