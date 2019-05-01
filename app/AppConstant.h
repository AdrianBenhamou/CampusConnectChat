#define		FIREBASE_STORAGE					@"gs://chatproject-b824e.appspot.com"
//---------------------------------------------------------------------------------
#define		DEFAULT_TAB							0
#define		DEFAULT_COUNTRY						188
//---------------------------------------------------------------------------------
#define		VIDEO_LENGTH						5
#define		AUDIO_LENGTH						5
#define		INSERT_MESSAGES						10
#define		DOWNLOAD_TIMEOUT					300
//---------------------------------------------------------------------------------
#define		STATUS_LOADING						1
#define		STATUS_SUCCEED						2
#define		STATUS_MANUAL						3
//---------------------------------------------------------------------------------
#define		MEDIA_IMAGE							1
#define		MEDIA_VIDEO							2
#define		MEDIA_AUDIO							3
//---------------------------------------------------------------------------------
#define		NETWORK_MANUAL						1
#define		NETWORK_WIFI						2
#define		NETWORK_ALL							3
//---------------------------------------------------------------------------------
#define		KEEPMEDIA_WEEK						1
#define		KEEPMEDIA_MONTH						2
#define		KEEPMEDIA_FOREVER					3
//---------------------------------------------------------------------------------
#define		DEL_ACCOUNT_NONE					1
#define		DEL_ACCOUNT_ONE						2
#define		DEL_ACCOUNT_ALL						3
//---------------------------------------------------------------------------------
#define		MESSAGE_STATUS						@"status"
#define		MESSAGE_TEXT						@"text"
#define		MESSAGE_EMOJI						@"emoji"
#define		MESSAGE_PICTURE						@"picture"
#define		MESSAGE_VIDEO						@"video"
#define		MESSAGE_AUDIO						@"audio"
//---------------------------------------------------------------------------------
#define		LOGIN_EMAIL							@"Email"

//---------------------------------------------------------------------------------
#define		TEXT_QUEUED							@"Queued"
#define		TEXT_SENT							@"Sent"
#define		TEXT_READ							@"Read"
//---------------------------------------------------------------------------------
#define		FFRIEND_PATH						@"Friend"				//	Path name
#define		FFRIEND_OBJECTID					@"objectId"				//	String

#define		FFRIEND_FRIENDID					@"friendId"				//	String
#define		FFRIEND_ISDELETED					@"isDeleted"			//	Boolean

#define		FFRIEND_CREATEDAT					@"createdAt"			//	Timestamp
#define		FFRIEND_UPDATEDAT					@"updatedAt"			//	Timestamp
//---------------------------------------------------------------------------------
#define		FLASTREAD_PATH						@"LastRead"				//	Path name
//---------------------------------------------------------------------------------
#define		FMESSAGE_PATH						@"Message"				//	Path name
#define		FMESSAGE_OBJECTID					@"objectId"				//	String

#define		FMESSAGE_CHATID						@"chatId"				//	String
#define		FMESSAGE_MEMBERS					@"members"				//	Array

#define		FMESSAGE_SENDERID					@"senderId"				//	String
#define		FMESSAGE_SENDERNAME					@"senderName"			//	String
#define		FMESSAGE_SENDERINITIALS				@"senderInitials"		//	String
#define		FMESSAGE_SENDERPICTURE				@"senderPicture"		//	String

#define		FMESSAGE_RECIPIENTID				@"recipientId"			//	String
#define		FMESSAGE_RECIPIENTNAME				@"recipientName"		//	String
#define		FMESSAGE_RECIPIENTINITIALS			@"recipientInitials"	//	String
#define		FMESSAGE_RECIPIENTPICTURE			@"recipientPicture"		//	String

#define		FMESSAGE_TYPE						@"type"					//	String
#define		FMESSAGE_TEXT						@"text"					//	String

#define		FMESSAGE_PICTURE					@"picture"				//	String
#define		FMESSAGE_PICTURE_WIDTH				@"picture_width"		//	Number
#define		FMESSAGE_PICTURE_HEIGHT				@"picture_height"		//	Number
#define		FMESSAGE_PICTURE_MD5				@"picture_md5"			//	String

#define		FMESSAGE_VIDEO						@"video"				//	String
#define		FMESSAGE_VIDEO_DURATION				@"video_duration"		//	Number
#define		FMESSAGE_VIDEO_MD5					@"video_md5"			//	String

#define		FMESSAGE_AUDIO						@"audio"				//	String
#define		FMESSAGE_AUDIO_DURATION				@"audio_duration"		//	Number
#define		FMESSAGE_AUDIO_MD5					@"audio_md5"			//	String

#define		FMESSAGE_STATUS						@"status"				//	String
#define		FMESSAGE_ISDELETED					@"isDeleted"			//	Boolean

#define		FMESSAGE_CREATEDAT					@"createdAt"			//	Timestamp
#define		FMESSAGE_UPDATEDAT					@"updatedAt"			//	Timestamp
//---------------------------------------------------------------------------------
#define		FMUTEDUNTIL_PATH					@"MutedUntil"			//	Path name
//---------------------------------------------------------------------------------
#define		FSTATUS_PATH						@"Status"				//	Path name
#define		FSTATUS_OBJECTID					@"objectId"				//	String

#define		FSTATUS_CHATID						@"chatId"				//	String

#define		FSTATUS_LASTREAD					@"lastRead"				//	Timestamp
#define		FSTATUS_MUTEDUNTIL					@"mutedUntil"			//	Timestamp

#define		FSTATUS_CREATEDAT					@"createdAt"			//	Timestamp
#define		FSTATUS_UPDATEDAT					@"updatedAt"			//	Timestamp
//---------------------------------------------------------------------------------
#define		FTYPING_PATH						@"Typing"				//	Path name
//---------------------------------------------------------------------------------
#define		FUSER_PATH							@"User"					//	Path name
#define		FUSER_OBJECTID						@"objectId"				//	String

#define		FUSER_EMAIL							@"email"				//	String


#define		FUSER_FIRSTNAME						@"firstname"			//	String
#define		FUSER_LASTNAME						@"lastname"				//	String
#define		FUSER_FULLNAME						@"fullname"				//	String
#define		FUSER_COUNTRY						@"country"				//	String
#define		FUSER_LOCATION						@"location"				//	String
#define		FUSER_STATUS						@"status"				//	String

#define		FUSER_PICTURE						@"picture"				//	String
#define		FUSER_THUMBNAIL						@"thumbnail"			//	String

#define		FUSER_KEEPMEDIA						@"keepMedia"			//	Number
#define		FUSER_NETWORKIMAGE					@"networkImage"			//	Number
#define		FUSER_NETWORKVIDEO					@"networkVideo"			//	Number
#define		FUSER_NETWORKAUDIO					@"networkAudio"			//	Number
#define		FUSER_WALLPAPER						@"wallpaper"			//	String

#define		FUSER_LOGINMETHOD					@"loginMethod"			//	String

#define		FUSER_LASTACTIVE					@"lastActive"			//	Timestamp
#define		FUSER_LASTTERMINATE					@"lastTerminate"		//	Timestamp

#define		FUSER_LINKEDIDS						@"linkedIds"			//	Dictionary

#define		FUSER_CREATEDAT						@"createdAt"			//	Timestamp
#define		FUSER_UPDATEDAT						@"updatedAt"			//	Timestamp
//---------------------------------------------------------------------------------
#define		FUSERSTATUS_PATH					@"UserStatus"			//	Path name
#define		FUSERSTATUS_OBJECTID				@"objectId"				//	String

#define		FUSERSTATUS_NAME					@"name"					//	String

#define		FUSERSTATUS_CREATEDAT				@"createdAt"			//	Timestamp
#define		FUSERSTATUS_UPDATEDAT				@"updatedAt"			//	Timestamp
//-------------------------------------------------------------------------------------------------------------------------------------------------

#define		USER_ACCOUNTS						@"UserAccounts"
//---------------------------------------------------------------------------------
#define		NOTIFICATION_APP_STARTED			@"NotificationAppStarted"
#define		NOTIFICATION_USER_LOGGED_IN			@"NotificationUserLoggedIn"
#define		NOTIFICATION_USER_LOGGED_OUT		@"NotificationUserLoggedOut"
//---------------------------------------------------------------------------------
#define		NOTIFICATION_REFRESH_BLOCKEDS		@"NotificationRefreshBlockeds"
#define		NOTIFICATION_REFRESH_BLOCKERS		@"NotificationRefreshBlockers"
#define		NOTIFICATION_REFRESH_CALLHISTORIES	@"NotificationRefreshCallHistories"
#define		NOTIFICATION_REFRESH_CHATS			@"NotificationRefreshChats"
#define		NOTIFICATION_REFRESH_FRIENDS		@"NotificationRefreshFriends"
#define		NOTIFICATION_REFRESH_MESSAGES1		@"NotificationRefreshMessages1"
#define		NOTIFICATION_REFRESH_MESSAGES2		@"NotificationRefreshMessages2"
#define		NOTIFICATION_REFRESH_STATUSES		@"NotificationRefreshStatuses"
#define		NOTIFICATION_REFRESH_USERS			@"NotificationRefreshUsers"
//---------------------------------------------------------------------------------
#define		NOTIFICATION_CLEANUP_CHATVIEW		@"NotificationCleanupChatView"
//-------------------------------------------------------------------------------------------------------------------------------------------------
