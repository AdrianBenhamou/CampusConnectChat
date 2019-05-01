import MapKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
@objc class RCMessage: NSObject {

	var type: Int = 0

	var incoming = false
	var outgoing = false

	var text = ""

	var picture_image: UIImage?
	var picture_width: Int = 0
	var picture_height: Int = 0

	var video_path = ""
	var video_thumbnail: UIImage?
	var video_duration: Int = 0

	var audio_path = ""
	var audio_duration: Int = 0
	var audio_status: Int = 0

	var status: Int = 0

	// MARK: - Initialization methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	override init() {
		
		super.init()
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	init(status text: String) {

		super.init()

		type = Int(RC_TYPE_STATUS)

		incoming = false
		outgoing = false

		self.text = text
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	init(text: String, incoming incoming_: Bool) {

		super.init()

		type = Int(RC_TYPE_TEXT)

		incoming = incoming_
		outgoing = !incoming

		self.text = text
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	init(emoji text: String, incoming incoming_: Bool) {

		super.init()

		type = Int(RC_TYPE_EMOJI)

		incoming = incoming_
		outgoing = !incoming

		self.text = text
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	init(picture image: UIImage?, width: Int, height: Int, incoming incoming_: Bool) {

		super.init()

		type = Int(RC_TYPE_PICTURE)

		incoming = incoming_
		outgoing = !incoming

		picture_image = image
		picture_width = width
		picture_height = height
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	init(video path: String?, duration: Int, incoming incoming_: Bool) {

		super.init()

		type = Int(RC_TYPE_VIDEO)

		incoming = incoming_
		outgoing = !incoming

		video_path = path ?? ""
		video_duration = duration
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	init(audio path: String?, duration: Int, incoming incoming_: Bool) {

		super.init()

		type = Int(RC_TYPE_AUDIO)

		incoming = incoming_
		outgoing = !incoming

		audio_path = path ?? ""
		audio_duration = duration
		audio_status = Int(RC_AUDIOSTATUS_STOPPED)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------

	
}
