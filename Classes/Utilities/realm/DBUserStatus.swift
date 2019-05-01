class DBUserStatus: RLMObject {

	@objc dynamic var objectId = ""

	@objc dynamic var name = ""

	@objc dynamic var createdAt: Int64 = 0
	@objc dynamic var updatedAt: Int64 = 0

	//-----------------------------------------------
	class func lastUpdatedAt() -> Int64 {

		let dbuserStatus = DBUserStatus.allObjects().sortedResults(usingKeyPath: "updatedAt", ascending: true).lastObject() as? DBUserStatus
		return dbuserStatus?.updatedAt ?? 0
	}

	//-----------------------------------------------
	override static func primaryKey() -> String? {

		return FUSERSTATUS_OBJECTID
	}
}
