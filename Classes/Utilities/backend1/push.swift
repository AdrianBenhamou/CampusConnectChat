func SendPushNotification1(message: FObject) {

	let type = message[FMESSAGE_TYPE] as! String
	var text = message[FMESSAGE_SENDERNAME] as! String
	let chatId = message[FMESSAGE_CHATID] as! String

	if (type == MESSAGE_TEXT)		{ text = text + (" sent you a text message.")	}
	if (type == MESSAGE_EMOJI)		{ text = text + (" sent you an emoji.")			}
	if (type == MESSAGE_PICTURE)	{ text = text + (" sent you a picture.")		}
	if (type == MESSAGE_VIDEO)		{ text = text + (" sent you a video.")			}
	if (type == MESSAGE_AUDIO) 		{ text = text + (" sent you an audio.")			}

	let firebase = Database.database().reference(withPath: FMUTEDUNTIL_PATH).child(chatId)
	firebase.observeSingleEvent(of: DataEventType.value, with: { snapshot in
		var userIds = message[FMESSAGE_MEMBERS] as! [String]


		if let index = userIds.index(of: FUser.currentId()) {
			userIds.remove(at: index)
		}

		SendPushNotification2(userIds: userIds, text: text)
	})
}

//----------------------------------------------
func SendPushNotification2(userIds: [String], text: String) {
	let predicate = NSPredicate(format: "objectId IN %@", userIds)
	let dbusers = DBUser.objects(with: predicate).sortedResults(usingKeyPath: FUSER_FULLNAME, ascending: true)
	for i in 0..<dbusers.count {
		let dbuser = dbusers[i] as! DBUser

	}

}
