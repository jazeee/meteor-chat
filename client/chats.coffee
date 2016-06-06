FlowRouter.route "/chatRooms",
	name: "newChatRoom"
	action: ->
		BlazeLayout.render "newChatRoom"
	subscriptions: (params) ->
		@register 'chatRooms', Meteor.subscribe "chatRooms", ""

FlowRouter.route "/chatRooms/:chatRoomId",
	name: "chatRoom"
	action: ->
		BlazeLayout.render "chatRoom"
	subscriptions: (params) ->
		@register 'chats', Meteor.subscribe "chats", params.chatRoomId
		@register 'chatRooms', Meteor.subscribe "chatRooms", params.chatRoomId

Template.chatRoom.helpers
	chats: Models.Chats.find {}, sort: 'createdAt': -1
	chatRoom: -> Models.ChatRooms.findOne()

AutoForm.hooks
	newChatRoom:
		onSuccess: (formType, chatRoomId) ->
			console.log chatRoomId
			FlowRouter.go 'chatRoom', {chatRoomId}
	chat:
		before:
			insert: (document) ->
				document.chatRoomId = FlowRouter.getParam "chatRoomId"
				console.log document
				return document
