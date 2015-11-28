

function ShowTeam() {
	var TeamPanel = $.FindChildInContext( "#HeroKit_Team")
	var LocalPlayer = Game.GetLocalPlayerID();
	var LocalInfo = Game.GetPlayerInfo( LocalPlayer )
	var TeamId = LocalInfo.player_team_id
	var Players = Game.GetPlayerIDsOnTeam( TeamId );
	for (k in Players){
		/*if(Players[k] != LocalPlayer){*/
			var TeamPlayer = $.CreatePanel( "Panel", TeamPanel, "" );
			var PlayerInfo = Game.GetPlayerInfo( Players[k] )
			TeamPlayer.data.sID = PlayerInfo.player_steamid
			TeamPlayer.BLoadLayout( "file://{resources}/layout/custom_game/hero_kit_team.xml", false, false );
			//$.Msg("Creating panel for: " + TeamPlayer.data.sID)
		/*}*/
	}
}

(function () {
	ShowTeam();
})();