chatbot_port = 9005
steam_ids = {}

function onCreate(is_world_create)
	for _, player in pairs(server.getPlayers()) do
		steam_ids[player.id] = tostring(player.steam_id)
	end
end

function onPlayerJoin(steam_id, name, peer_id, admin, auth)
	steam_ids[peer_id] = tostring(steam_id)
end

function onChatMessage(user_peer_id, sender_name, message)
	server.httpGet(chatbot_port, "/sendmsg?msg="..encode(message).."&sid="..encode(steam_ids[user_peer_id]))
end

function encode(str)
	if str == nil then
		return ""
	end
	str = string.gsub(str, "([^%w _ %- . ~])", cth)
	str = str:gsub(" ", "%%20")
	return str
end

function cth(c)
	return string.format("%%%02X", string.byte(c))
end