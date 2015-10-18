

function SendToAll()
{
	var MsgInput = $.FindChildInContext('#CChat_Input');
	var Msg = MsgInput.text;
	if (Msg != "") {
	GameEvents.SendCustomGameEventToServer( "custom_chat_cts", {msg: Msg} );
	MsgInput.text = "";
	}
}

function RecieveMsg(event)
{
	
	if (Game.IsPlayerMuted( event['player'] )) { return };
	var MsgPanel = $.FindChildInContext('#CChat_Box');
	var PlayerInfo = Game.GetPlayerInfo( event['player'] );
	var SteamID = PlayerInfo.player_steamid;
	var NewMessage = $.CreatePanel( 'Panel', MsgPanel, 'Msg_'+MsgId+'_Panel' );
	NewMessage.AddClass("message_cont");
	NewMessage.hittest = false;
	var PlayerAvatar = $.CreatePanel( 'DOTAAvatarImage', NewMessage, 'Msg_'+MsgId+'_Avatar' );
	PlayerAvatar.steamid = SteamID;
	PlayerAvatar.AddClass("message_avat");
	var MessageText = $.CreatePanel( 'Label', NewMessage, 'Msg_'+MsgId+'_Text' );
	MessageText.AddClass("message_text");
	MessageText.text = event['msg'];
	MessageText.hittest = false;
	/**/
	MsgId = MsgId + 1;
	MsgPanel.ScrollToBottom();
}

function OpenChat()
{
	var MsgPanel = $.FindChildInContext('#CChat_Box');
	var ChatPanel = $.GetContextPanel();
	if (ChatPanel.BHasClass( "chat_closed" )){
	ChatPanel.RemoveClass( "chat_closed" );
	 MsgPanel.RemoveClass( "chat_closed_msg" );
	MsgPanel.ScrollToBottom();
	}
}


function OnChatEnter()
{
	var MsgInput = $.FindChildInContext('#CChat_Input');
	if (MsgInput.BHasKeyFocus()) {
		SendToAll()
	} else {
	var MsgPanel = $.FindChildInContext('#CChat_Box');
	var ChatPanel = $.GetContextPanel();
	if (ChatPanel.BHasClass( "chat_closed" )){
	ChatPanel.RemoveClass( "chat_closed" );
	 MsgPanel.RemoveClass( "chat_closed_msg" );
	MsgPanel.ScrollToBottom();
	MsgInput.SetFocus()
	}
	}
}

function ToggleChat()
{
	var MsgPanel = $.FindChildInContext('#CChat_Box');
	var ChatPanel = $.GetContextPanel();
	if (ChatPanel.BHasClass( "chat_closed" )){
	ChatPanel.RemoveClass( "chat_closed" );
	 MsgPanel.RemoveClass( "chat_closed_msg" );
	} else {
	ChatPanel.AddClass( "chat_closed" );
	 MsgPanel.AddClass( "chat_closed_msg" );
	MsgPanel.ScrollToBottom();
	}
}

function CloseChat()
{
	var MsgPanel = $.FindChildInContext('#CChat_Box');
	var ChatPanel = $.GetContextPanel();
	ChatPanel.AddClass( "chat_closed" );
	 MsgPanel.AddClass( "chat_closed_msg" );
	MsgPanel.ScrollToBottom();
}

(function () {
	MsgId = 0
	GameEvents.Subscribe( "custom_chat_stc", RecieveMsg );
})();