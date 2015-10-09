//hero_kit_team.js

"use strict";

function Tooltip(abilityName,abilityButton){
	$.DispatchEvent( "DOTAShowAbilityTooltip", abilityButton, abilityName );
}
function HideTooltip(abilityButton){
	$.DispatchEvent( "DOTAHideAbilityTooltip", abilityButton );
}
function ChangesHandler(keys) {
	//$.Msg("Player Recieve!");
	var PlayerInfo = Game.GetPlayerInfo( keys['player'] );
	var SteamID = PlayerInfo.player_steamid;
	var SteamAvatar = $.FindChildInContext( "#player_steam_profile" );
	if (SteamAvatar.steamid == SteamID){
	var target = keys['target'];
	var change = keys['change'];
	var gold = keys['gold'];
	var Targets = {};
	Targets[0] = $.FindChildInContext( "#TeamStrVal" );
	Targets[1] = $.FindChildInContext( "#TeamAgiVal" );
	Targets[2] = $.FindChildInContext( "#TeamIntVal" );
	var GoldTarget = $.FindChildInContext( "#TeamGoldVal" );
	Targets[target].text = change;
	GoldTarget.text = gold;
	}
}
function SkillsHandler(keys) {
	//$.Msg("Player Recieve!");
	var PlayerInfo = Game.GetPlayerInfo( keys['player'] );
	var SteamID = PlayerInfo.player_steamid;
	var SteamAvatar = $.FindChildInContext( "#player_steam_profile" );
	if (SteamAvatar.steamid == SteamID){
	var target = keys['target'];
	var change = keys['change'];
	var Targets = {};
	Targets[1] = $.FindChildInContext( "#player_slot_1" );
	Targets[2] = $.FindChildInContext( "#player_slot_2" );
	Targets[3] = $.FindChildInContext( "#player_slot_3" );
	Targets[4] = $.FindChildInContext( "#player_slot_4" );
	Targets[5] = $.FindChildInContext( "#player_slot_5" );
	Targets[6] = $.FindChildInContext( "#player_slot_6" );
	Targets[target].abilityname = change;
		var HoverIn = ( function(name,id) { 
				return function(){
					Tooltip(name,id);
				}
			});
		var HoverOut = ( function(name) { 
				return function(){
					HideTooltip(name);
				}
			});
		if (change == "rubick_empty1"){
		Targets[target].SetPanelEvent( 'onmouseover', function(){});
		Targets[target].SetPanelEvent( 'onmouseout', HoverOut(Targets[target]));
		} else {
		Targets[target].SetPanelEvent( 'onmouseover', HoverIn(change,Targets[target]));
		Targets[target].SetPanelEvent( 'onmouseout', HoverOut(Targets[target]));
		}
	}
}

function Debug(){
	var SteamAvatar = $.FindChildInContext( "#player_steam_profile" );
	//$.Msg(SteamAvatar.steamid + " still exist!");
}


(function () {
	
	var SteamAvatar = $.FindChildInContext( "#player_steam_profile" );
	var PlayerPanel = $.GetContextPanel();
	SteamAvatar.steamid = PlayerPanel.data.sID;
	//$.Msg(PlayerPanel.data.sID + " added!");
	 GameEvents.Subscribe( 'team_hero_kit_stats', ChangesHandler );
	 GameEvents.Subscribe( 'team_hero_kit_skills', SkillsHandler );
	//$.Schedule(2,Debug);
})();