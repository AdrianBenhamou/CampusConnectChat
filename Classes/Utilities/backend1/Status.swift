class Status: NSObject {

	//----------------------------------------------
	class func updateLastRead(chatId: String) {

		let lastRead = ServerValue.timestamp()
		let mutedUntil = self.mutedUntil(chatId: chatId)

		let object = FObject(path: FSTATUS_PATH, subpath: FUser.currentId())

		object[FSTATUS_OBJECTID] = chatId
		object[FSTATUS_CHATID] = chatId
		object[FSTATUS_LASTREAD] = lastRead
		object[FSTATUS_MUTEDUNTIL] = mutedUntil

		object.saveInBackground(block: { error in
			if (error == nil) {
				object.fetchInBackground(block: { error in
					let firebase = Database.database().reference(withPath: FLASTREAD_PATH).child(chatId)
					firebase.updateChildValues([FUser.currentId(): lastRead])
				})
			} else {
				ProgressHUD.showError("Network error.")
			}
		})
	}

	//---------------------------------------------
	class func updateMutedUntil(chatId: String, mutedUntil: Int64) {

	}

	//----------------------------------------------
    class func lastRead(chatId: String) -> Int64 {

		let predicate = NSPredicate(format: "chatId == %@", chatId)
		let dbstatus = DBStatus.objects(with: predicate).firstObject() as? DBStatus

		return dbstatus?.lastRead ?? 0
	}

	//-----------------------------------------------
	class func mutedUntil(chatId: String) -> Int64 {

		let predicate = NSPredicate(format: "chatId == %@", chatId)
		let dbstatus = DBStatus.objects(with: predicate).firstObject() as? DBStatus

		return dbstatus?.mutedUntil ?? 0
	}
}
