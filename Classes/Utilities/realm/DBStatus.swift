class DBStatus: RLMObject {

	@objc dynamic var objectId = ""

	@objc dynamic var chatId = ""

	@objc dynamic var lastRead: Int64 = 0
	@objc dynamic var mutedUntil: Int64 = 0

	@objc dynamic var createdAt: Int64 = 0
	@objc dynamic var updatedAt: Int64 = 0

	//----------------------------------------------
	class func lastUpdatedAt() -> Int64 {

		let dbstatus = DBStatus.allObjects().sortedResults(usingKeyPath: "updatedAt", ascending: true).lastObject() as? DBStatus
		return dbstatus?.updatedAt ?? 0
	}

	//----------------------------------------------
	override static func primaryKey() -> String? {

		return FSTATUS_OBJECTID
	}
}
