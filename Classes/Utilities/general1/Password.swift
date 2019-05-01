class Password: NSObject {

	//-----------------------------------------------
	class func get(chatId: String) -> String {

		return Checksum.md5HashOf(string: chatId)
	}
}
