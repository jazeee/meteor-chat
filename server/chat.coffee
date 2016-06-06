Meteor.startup ->
	Meteor.publish "chats", (chatRoomId) ->
		Models.Chats.find {chatRoomId}, sort : 'createdAt': -1
	Meteor.publish "chatRooms", (_id) ->
		search = {}
		search = {_id} if _id?
		Models.ChatRooms.find search, sort : 'createdAt': -1
