
func LogoutUser(delAccount: Int32) {


	if (delAccount == DEL_ACCOUNT_ONE) { Account.delOne() }
	if (delAccount == DEL_ACCOUNT_ALL) { Account.delAll() }



	if (FUser.logOut()) {
		CacheManager.cleanupManual(logout: true)
		NotificationCenterX.post(notification: NOTIFICATION_USER_LOGGED_OUT)
	} else {
		ProgressHUD.showError("Logout error.")
	}
}

//----------------------------------------------
func LoginUser(target: Any) {

	let viewController = target as! UIViewController
	let welcomeView = WelcomeView()
	viewController.present(welcomeView, animated: true) {
		viewController.tabBarController?.selectedIndex = Int(DEFAULT_TAB)
	}
}

//----------------------------------------------
func OnboardUser(target: Any) {

	let viewController = target as! UIViewController
	let editProfileView = EditProfileView()
	editProfileView.myInit(isOnboard: true)
	let navController = NavigationController(rootViewController: editProfileView)
	viewController.present(navController, animated: true)
}

//----------------------------------------------
func UserLoggedIn(loginMethod: String) {

	UpdateUserSettings(loginMethod: loginMethod)

	LinkedId.createItem()

	if (FUser.isOnboardOk()) {
		ProgressHUD.showSuccess("Welcome back!")
	} else {
		ProgressHUD.showSuccess("Welcome!")
	}

	NotificationCenterX.post(notification: NOTIFICATION_USER_LOGGED_IN)
}

//----------------------------------------------
func UpdateUserSettings(loginMethod: String) {

	var update = false
	let user = FUser.currentUser()

	if (user[FUSER_LOGINMETHOD] as? String == nil)	{ update = true; user[FUSER_LOGINMETHOD] = loginMethod		}

	if (user[FUSER_KEEPMEDIA] as? Int == nil)		{ update = true; user[FUSER_KEEPMEDIA] = KEEPMEDIA_FOREVER	}
	if (user[FUSER_NETWORKIMAGE] as? Int == nil)	{ update = true; user[FUSER_NETWORKIMAGE] = NETWORK_ALL		}
	if (user[FUSER_NETWORKVIDEO] as? Int == nil)	{ update = true; user[FUSER_NETWORKVIDEO] = NETWORK_ALL		}
	if (user[FUSER_NETWORKAUDIO] as? Int == nil)	{ update = true; user[FUSER_NETWORKAUDIO] = NETWORK_ALL		}

	if (user[FUSER_LASTACTIVE] as? Int64 == nil)	{ update = true; user[FUSER_LASTACTIVE] = 0					}
	if (user[FUSER_LASTTERMINATE] as? Int64 == nil)	{ update = true; user[FUSER_LASTTERMINATE] = 0				}

	if (update) {
		user.saveInBackground()
	}
}

