class UserStatus: NSObject {

	//---------------------------------------------
	class func createItems() {

		createItem(name: "Accounting")
		createItem(name: "Anthropology")
		createItem(name: "Applied Math")
		createItem(name: "Architecture")
		createItem(name: "Art History")
		createItem(name: "Biochemistry")
		createItem(name: "Bioengineering")
		createItem(name: "Biology")
		createItem(name: "Business Administration")
		createItem(name: "Chemical Engineering")
		createItem(name: "Chemistry")
        createItem(name: "Civil Engineering")
        createItem(name: "Computer Engineering")
        createItem(name: "Computer Science")
        createItem(name: "Criminal Justice")
        createItem(name: "Dance")
        createItem(name: "Earth Sciences")
        createItem(name: "Economics")
        createItem(name: "Electrical Enineering")
        createItem(name: "Education")
        createItem(name: "English")
        createItem(name: "Environmental Science")
        createItem(name: "Film")
        createItem(name: "Finance")
        createItem(name: "Geography")
        createItem(name: "Graphic Design")
        createItem(name: "History")
        createItem(name: "Journalism")
        createItem(name: "Kinesiology")
        createItem(name: "Marine Biology")
        createItem(name: "Marketing")
        createItem(name: "Mathmatics")
        createItem(name: "Mechanical Engineering")
        createItem(name: "Nutrition")
        createItem(name: "Physics")
        createItem(name: "Political Science")
        createItem(name: "Pre-medicine")
        createItem(name: "Religious Studies")
        createItem(name: "Sociology")
        createItem(name: "Statistics")
	}

	//-----------------------------------------------
	class func createItem(name: String) {

		let object = FObject(path: FUSERSTATUS_PATH)

		object[FUSERSTATUS_NAME] = name

		object.saveInBackground(block: { error in
			if (error != nil) {
				print("UserStatus createItem error: \(error)")
			}
		})
	}
}
