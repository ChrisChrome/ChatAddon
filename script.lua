chatbot_port = 9005
steam_ids = {}

function onPlayerJoin(steam_id, name, peer_id, admin, auth)
	steam_ids[peer_id] = tostring(steam_id)
end

function onChatMessage(user_peer_id, sender_name, message)
	server.httpGet(chatbot_port, "/sendmsg?msg="..message.."&sid="..steamids[user_peer_id])
end
