class UserDefaultsX: NSObject {

	//---------------------------------------------
	class func setObject(value: Any, key: String) {

		UserDefaults.standard.set(value, forKey: key)
		UserDefaults.standard.synchronize()
	}

	//---------------------------------------------
	class func removeObject(key: String) {

		UserDefaults.standard.removeObject(forKey: key)
		UserDefaults.standard.synchronize()
	}

	//----------------------------------------------
	class func removeObject(key: String, delay: TimeInterval) {

		DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
			removeObject(key: key)
		}
	}

	//----------------------------------------------
	class func object(key: String) -> Any? {

		return UserDefaults.standard.object(forKey: key)
	}

	//----------------------------------------------
	class func string(key: String) -> String? {

		return UserDefaults.standard.string(forKey: key)
	}

	//---------------------------------------------
	class func integer(key: String) -> Int {

		return UserDefaults.standard.integer(forKey: key)
	}

	//----------------------------------------------
	class func bool(key: String) -> Bool {

		return UserDefaults.standard.bool(forKey: key)
	}
}
