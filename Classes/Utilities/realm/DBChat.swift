class DBChat: RLMObject {

	@objc dynamic var chatId = ""

	@objc dynamic var recipientId = ""

	@objc dynamic var initials = ""
	@objc dynamic var picture = ""
	@objc dynamic var details = ""

	@objc dynamic var lastMessage = ""
	@objc dynamic var lastMessageDate: Int64 = 0
	@objc dynamic var lastIncoming: Int64 = 0

	@objc dynamic var isArchived = false
	@objc dynamic var isDeleted = false

	@objc dynamic var createdAt: Int64 = 0
	@objc dynamic var updatedAt: Int64 = 0

	//-----------------------------------------------
	override static func primaryKey() -> String? {

		return "chatId"
	}
}
