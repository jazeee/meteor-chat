@Models = {}
@Models.Chats = new Mongo.Collection "chats"
@Models.ChatRooms = new Mongo.Collection "chatRooms"

@Schemas = {}

@Schemas.Chats = new SimpleSchema {
	message:
		type: String
		min: 2
		autoform:
			placeholder: "Enter a Message"
	userId:
		type: String
		autoValue: ->
			Meteor.userId()
	email:
		type: String
		autoValue: ->
			Meteor.user()?.emails?[0]?.address
	chatRoomId:
		type: String
		optional: true
	createdAt:
		type: Date
		autoValue: -> new Date()
}
@Models.Chats.attachSchema @Schemas.Chats


@Schemas.ChatRooms = new SimpleSchema {
	name:
		type: String
		min: 2
	createdAt:
		type: Date
		autoValue: -> new Date()
}
@Models.ChatRooms.attachSchema @Schemas.ChatRooms
