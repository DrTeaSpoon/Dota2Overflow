

function Ability_Listing(tAbListS) {
	var max_row = 5;
	var abs = tAbListS.length;
	var need_rows = Math.ceil(abs/max_row)
	var n_r = 1;
	var n_e = 1;
	var AbilityMenu = $.FindChildInContext('#HeroKit_Abilities');
	for(k in tAbListS){
		if(n_e > max_row){
			n_r++;
			n_e = 1;
		}
		if(n_e == 1){
			var ability_row = $.CreatePanel( 'Panel', AbilityMenu, 'ab_row_'+n_r);
			ability_row.AddClass( "Ability_row" )
		}
		var abilityName = tAbListS[k]
		var abilityButton_Ac = 'AbilityPressed('+abilityName+')'
		var ability_row_true = $.FindChildInContext( '#ab_row_'+n_r )
		var ability_item = $.CreatePanel( 'Button', ability_row_true, 'ab_'+k);
		ability_item.AddClass( "ab_button" )
		var AbilityPressed = ( function(name,type) { 
				return function(){
					AddSkill(name,type);
				}
			});
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
		ability_item.SetPanelEvent( 'onmouseover', HoverIn(abilityName,ability_item));
		ability_item.SetPanelEvent( 'onmouseout', HoverOut(ability_item));
		ability_item.SetPanelEvent( 'onactivate', AbilityPressed(abilityName,1));
		var ability_image = $.CreatePanel( 'DOTAAbilityImage', ability_item, '' );
		ability_image.abilityname = abilityName;
		
		n_e++;
	}
}

function Ult_Listing(_arg) {
	var max_row = 5;
	var abs = _arg.length;
	var need_rows = Math.ceil(abs/max_row)
	var n_r = 1;
	var n_e = 1;
	var UltMenu = $.FindChildInContext('#HeroKit_UltsList');
	for(k in _arg){
		if(n_e > max_row){
			n_r++;
			n_e = 1;
		}
		if(n_e == 1){
			var ability_row = $.CreatePanel( 'Panel', UltMenu, 'ul_row_'+n_r);
			ability_row.AddClass( "Ability_row" )
		}
		var abilityName = _arg[k]
		var abilityButton_Ac = 'AbilityPressed('+abilityName+')'
		var ability_row_true = $.FindChildInContext( '#ul_row_'+n_r )
		var ability_item = $.CreatePanel( 'Button', ability_row_true, 'ul_'+k);
		ability_item.AddClass( "ab_button" )
		var AbilityPressed = ( function(name,type) { 
				return function(){
					AddSkill(name,type)
				}
			});
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
		ability_item.SetPanelEvent( 'onmouseover', HoverIn(abilityName,ability_item));
		ability_item.SetPanelEvent( 'onmouseout', HoverOut(ability_item));
		ability_item.SetPanelEvent( 'onactivate', AbilityPressed(abilityName,3));
		var ability_image = $.CreatePanel( 'DOTAAbilityImage', ability_item, '' );
		ability_image.abilityname = abilityName;
		n_e++;
	}
}



function Trait_Listing(_arg) {
	var max_row = 5;
	var abs = _arg.length;
	var need_rows = Math.ceil(abs/max_row)
	var n_r = 1;
	var n_e = 1;
	var TraitMenu = $.FindChildInContext('#HeroKit_Traits');
	for(k in _arg){
		if(n_e > max_row){
			n_r++;
			n_e = 1;
		}
		if(n_e == 1){
			var ability_row = $.CreatePanel( 'Panel', TraitMenu, 'tr_row_'+n_r);
			ability_row.AddClass( "Ability_row" )
		}
		var abilityName = _arg[k]
		var abilityButton_Ac = 'AbilityPressed('+abilityName+')'
		var ability_row_true = $.FindChildInContext( '#tr_row_'+n_r )
		var ability_item = $.CreatePanel( 'Button', ability_row_true, 'tr_'+k);
		ability_item.AddClass( "ab_button" )
		var AbilityPressed = ( function(name,type) { 
				return function(){
					AddSkill(name,type)
				}
			});
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
		ability_item.SetPanelEvent( 'onmouseover', HoverIn(abilityName,ability_item));
		ability_item.SetPanelEvent( 'onmouseout', HoverOut(ability_item));
		ability_item.SetPanelEvent( 'onactivate', AbilityPressed(abilityName,2));
		var ability_image = $.CreatePanel( 'DOTAAbilityImage', ability_item, '' );
		ability_image.abilityname = abilityName;
		n_e++;
	}
}

function AddSkill(abilityName,type)
{
	var AbilitySelection = {};
		
		AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_Q');
		AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_W');
		AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_E');
		AbilitySelection[4] = $.FindChildInContext('#HeroKit_Ability_D');
		AbilitySelection[5] = $.FindChildInContext('#HeroKit_Ability_F');
		AbilitySelection[6] = $.FindChildInContext('#HeroKit_Ability_R');
		for (i = 1; i < 7; i++) { 
			if (AbilitySelection[i].data().ability == abilityName)
			{
				return;
			}
		}
		AbilitySelection = {};
		var Tooltip = ( function(name) { 
				return function(){
					SetKitTooltip(name);
				}
			});
	if(type == 1){
		AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_Q');
		AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_W');
		AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_E');
		var Fail = false
		for (i = 1; i < 4; i++) { 
			if (AbilitySelection[i].data().ability == null)
			{
			AbilitySelection[i].data().ability = abilityName;
			var SelectionImage = AbilitySelection[i].GetChild(0);
			SelectionImage.abilityname = abilityName
			PutToSlot(SelectionImage.abilityname,AbilitySelection[i])
			SendSkill(SelectionImage.abilityname,i);
			break;
			}
		}
	} else if(type == 2) {
		AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_D');
		AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_F');
		for (i = 1; i < 3; i++) { 
			if (AbilitySelection[i].data().ability == null)
			{
			AbilitySelection[i].data().ability = abilityName;
			var SelectionImage = AbilitySelection[i].GetChild(0);
			SelectionImage.abilityname = abilityName
			PutToSlot(SelectionImage.abilityname,AbilitySelection[i])
			SendSkill(SelectionImage.abilityname,3+i);
			break;
			}
		}
	} else if(type == 3) {
		AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_R');
		for (i = 1; i < 2; i++) { 
			if (AbilitySelection[i].data().ability == null)
			{
			AbilitySelection[i].data().ability = abilityName;
			var SelectionImage = AbilitySelection[i].GetChild(0);
			SelectionImage.abilityname = abilityName
			PutToSlot(SelectionImage.abilityname,AbilitySelection[i])
			SendSkill(SelectionImage.abilityname,6);
			break;
			}
		}
		
	}
}


function PutToSlot(abilityName,slot){
	var AbilitySelection = {};
		AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_Q');
		AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_W');
		AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_E');
		AbilitySelection[4] = $.FindChildInContext('#HeroKit_Ability_D');
		AbilitySelection[5] = $.FindChildInContext('#HeroKit_Ability_F');
		AbilitySelection[6] = $.FindChildInContext('#HeroKit_Ability_R');
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
		slot.SetPanelEvent( 'onmouseover', HoverIn(abilityName,slot));
		slot.SetPanelEvent( 'onmouseout', HoverOut(slot));
		Game.EmitSound("ui.npe_objective_given");
}



function Tooltip(abilityName,abilityButton){
	$.DispatchEvent( "DOTAShowAbilityTooltip", abilityButton, abilityName );
}
function HideTooltip(abilityButton){
	$.DispatchEvent( "DOTAHideAbilityTooltip", abilityButton );
}

function SendSkill(skill,slot){
	//$.Msg("Player Send!")
			GameEvents.SendCustomGameEventToServer( "hero_kit_skill", {change: skill, target: slot} );
}
function SendStat(num,stat,val){
	//$.Msg("Player Send!")
			GameEvents.SendCustomGameEventToServer( "hero_kit_stats", {change: num, target: stat,gold: val} );
}


function OnRemoveSkill(slot)
{
	var AbilitySelection = {};
		AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_Q');
		AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_W');
		AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_E');
		AbilitySelection[4] = $.FindChildInContext('#HeroKit_Ability_D');
		AbilitySelection[5] = $.FindChildInContext('#HeroKit_Ability_F');
		AbilitySelection[6] = $.FindChildInContext('#HeroKit_Ability_R');
	var Slot = AbilitySelection[slot];
	if (Slot.data().ability != null)
	{
		Slot.data().ability = null;
		var SelectionImage = Slot.GetChild(0);
		SelectionImage.abilityname = "rubick_empty1";
		SendSkill("rubick_empty1",slot)
		Slot.SetPanelEvent( 'onmouseover', function(){})
		Game.EmitSound("compendium_levelup");
		HideTooltip(Slot)
	}
}

function StatTooltip(stat){
	var HStat = {};
	HStat[0] = {};
	HStat[1] = {};
	HStat[2] = {};
	HStat[0].Panel = $.FindChildInContext('#str_val');
	HStat[1].Panel = $.FindChildInContext('#agi_val');
	HStat[2].Panel = $.FindChildInContext('#int_val');
	HStat[0].Val = Number(HStat[0].Panel.text);
	HStat[1].Val = Number(HStat[1].Panel.text);
	HStat[2].Val = Number(HStat[2].Panel.text);
	var tool_text = $.Localize( "#DOTA_HeroKit_Stat_" + stat ) + "\n" + $.Localize( "#DOTA_HeroKit_Stat_" + stat + "_gain" ) + (HStat[stat].Val/10);
	$.DispatchEvent( "DOTAShowTextTooltip", HStat[stat].Panel, tool_text );
}

function StatPlus(stat)
{
	
	var PointsPanel = $.FindChildInContext('#point_val');
	var PointsVal = Number(PointsPanel.text);
	var HStat = {};
	HStat[0] = {};
	HStat[1] = {};
	HStat[2] = {};
	HStat[0].Panel = $.FindChildInContext('#str_val');
	HStat[1].Panel = $.FindChildInContext('#agi_val');
	HStat[2].Panel = $.FindChildInContext('#int_val');
	HStat[0].Val = Number(HStat[0].Panel.text);
	HStat[1].Val = Number(HStat[1].Panel.text);
	HStat[2].Val = Number(HStat[2].Panel.text);
	var PCost = 50
	if (HStat[stat].Val + 1 > 10) { PCost = 100 }
	if (HStat[stat].Val + 1 > 20) { PCost = 150 }
	if (HStat[stat].Val + 1 > 30) { PCost = 200 }
	if (HStat[stat].Val + 1 > 40) { PCost = 250 }
	if (PointsVal > PCost - 1) {
		if (HStat[0].Val + HStat[1].Val + HStat[2].Val < 100 ) {
			HStat[stat].Val = HStat[stat].Val + 1
			HStat[stat].Panel.text = String(HStat[stat].Val)
			PointsPanel.text = String(PointsVal - PCost)
		} else {
			HStat[0].Panel.text = "1";
			HStat[1].Panel.text = "1";
			HStat[2].Panel.text = "1";
			PointsPanel.text = "-666"
		}
	}
	
	var HpPanel = $.FindChildInContext('#hp_val');
	var MpPanel = $.FindChildInContext('#mp_val');
	HpPanel.text = String(HStat[0].Val * 19 + 200);
	MpPanel.text = String(HStat[2].Val * 13);
		Game.EmitSound("Tutorial.Next");
	SendStat(HStat[stat].Val,stat,Number(PointsPanel.text));
	
	
}
//
function StatMinus(stat)
{
	var PointsPanel = $.FindChildInContext('#point_val');
	var PointsVal = Number(PointsPanel.text);
	var HStat = {};
	HStat[0] = {};
	HStat[1] = {};
	HStat[2] = {};
	HStat[0].Panel = $.FindChildInContext('#str_val');
	HStat[1].Panel = $.FindChildInContext('#agi_val');
	HStat[2].Panel = $.FindChildInContext('#int_val');
	HStat[0].Val = Number(HStat[0].Panel.text);
	HStat[1].Val = Number(HStat[1].Panel.text);
	HStat[2].Val = Number(HStat[2].Panel.text);
	var PCost = 50
	if (HStat[stat].Val > 10) { PCost = 100 }
	if (HStat[stat].Val > 20) { PCost = 150 }
	if (HStat[stat].Val > 30) { PCost = 200 }
	if (HStat[stat].Val > 40) { PCost = 250 }
	if (HStat[stat].Val > 1) {
		if (HStat[0].Val + HStat[1].Val + HStat[2].Val < 100 ) {
			HStat[stat].Val = HStat[stat].Val - 1
		HStat[stat].Panel.text = String(HStat[stat].Val)
		PointsPanel.text = String(PointsVal + PCost)
	} else {
		HStat[0].Panel.text = "1";
		HStat[1].Panel.text = "1";
		HStat[2].Panel.text = "1";
		PointsPanel.text = "-666"
	}
	}
	var HpPanel = $.FindChildInContext('#hp_val');
	var MpPanel = $.FindChildInContext('#mp_val');
	HpPanel.text = String(HStat[0].Val * 19 + 200);
	MpPanel.text = String(HStat[2].Val * 13);
		Game.EmitSound("Tutorial.Next");
	SendStat(HStat[stat].Val,stat,Number(PointsPanel.text));
}

function StatPrimeChoose(stat){
}

function OnDone(){
	var AbilitySelection = {};
	AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_Q');
	AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_W');
	AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_E');
	AbilitySelection[4] = $.FindChildInContext('#HeroKit_Ability_D');
	AbilitySelection[5] = $.FindChildInContext('#HeroKit_Ability_F');
	AbilitySelection[6] = $.FindChildInContext('#HeroKit_Ability_R');
	var Ability = {};
	var RanN = 0;
	for (i = 1; i < 7; i++) { 
		if (AbilitySelection[i].data().ability != null)
		{
		Ability[i] = AbilitySelection[i].data().ability
		//$.Msg(AbilitySelection[i].data().ability);
		} else {
		Ability[i] = 'random'
		RanN = RanN + 1
		//$.Msg("Random");
		}
	}
	
		
	
	var PointsPanel = $.FindChildInContext('#point_val');
	var PointsVal = Number(PointsPanel.text);
	
	if (RanN > 5) {
		Game.EmitSound("Hero_OgreMagi.Fireblast.x3");
		PointsVal = PointsVal + 400;
	} else if (RanN > 3) {
		Game.EmitSound("Hero_OgreMagi.Fireblast.x2");
		PointsVal = PointsVal + 200;
	} else if (RanN > 1) {
		Game.EmitSound("Hero_OgreMagi.Fireblast.x1");
		PointsVal = PointsVal + 100;
	}
	var HStat = {};
	HStat[0] = {};
	HStat[1] = {};
	HStat[2] = {};
	HStat[0].Panel = $.FindChildInContext('#str_val');
	HStat[1].Panel = $.FindChildInContext('#agi_val');
	HStat[2].Panel = $.FindChildInContext('#int_val');
	HStat[0].Val = Number(HStat[0].Panel.text);
	HStat[1].Val = Number(HStat[1].Panel.text);
	HStat[2].Val = Number(HStat[2].Panel.text);
	var Prime = 0;
	for (i = 0; i < 3; i++) {
		if (HStat[i].Panel.BHasClass("prime")){
			Prime = i;
			$.Msg("Prime: " + i);
		}
	}		
	var HStr = HStat[0].Val
	var HStr_G = HStat[0].Val*0.1
	var HAgi = HStat[1].Val
	var HAgi_G = HStat[1].Val*0.1
	var HInt = HStat[2].Val
	var HInt_G = HStat[2].Val*0.1
	
		if (HStat[0].Val + HStat[1].Val + HStat[2].Val < 100 ) {
		GameEvents.SendCustomGameEventToServer( "ability_choise", {ability_q: Ability[1], ability_w: Ability[2], ability_e: Ability[3], ability_d: Ability[4], ability_f: Ability[5], ability_r: Ability[6], hero_pri: Prime, hero_str: HStr, hero_str_g: HStr_G, hero_agi: HAgi, hero_agi_g: HAgi_G, hero_int: HInt, hero_int_g: HInt_G, hero_points: PointsVal} )
	}
	$.GetContextPanel().DeleteAsync( 0 );
}

function OnDragEnter( a, draggedPanel )
{
	$.GetContextPanel().AddClass( "WhatA_Drag" );
	return true;
}

function OnDragDrop( panelId, draggedPanel )
{
	return true;
}

function OnDragLeave( panelId, draggedPanel )
{
	var targetPanel = $.GetContextPanel()
	$.GetContextPanel().RemoveClass( "WhatA_Drag" );
	return true;
}

function OnDragStart( panelId, dragCallbacks )
{
	var imageButton = $.FindChildInContext( "#"+panelId )
	var imagePanel = imageButton.GetChild(0)
	var displayPanel = $.CreatePanel( "Image", $.GetContextPanel(), "dragImage" );
	displayPanel.data().m_DragItem = panelId;
	displayPanel.data().m_DragCompleted = false; // whether the drag was successful
	imagePanel.SetParent(displayPanel)
	dragCallbacks.displayPanel = displayPanel;
	dragCallbacks.offsetX = 0;
	dragCallbacks.offsetY = 0;
	return true;
}

function OnDragEnd( panelId, draggedPanel ){
	var imageButton = $.FindChildInContext( "#"+panelId )
	var imagePanel = draggedPanel.GetChild(0)
	imagePanel.SetParent(imageButton)
	draggedPanel.DeleteAsync( 0 );
	return true;
}


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


function UpdateTimer() {
	var time =  Game.GetDOTATime( true, true );
	time = Math.floor(time) * -1;
	var Timer = $.FindChildInContext( "#kit_timer");
	if( time > 0 ){
	var mins = 0;
	while(time > 60) {
		time = time - 60;
		mins = mins + 1;
	}
	/*$.Msg(String(mins) + ":" + String(time));*/
	if( mins < 10 ){
		mins = "0" + String(mins);
	}
	if( time < 10 ){
		time = "0" + String(time);
	}
	Timer.text = String(mins) + ":" + String(time);
	$.Schedule(0.5,UpdateTimer);
	} else {
	Timer.text = "Game In Progress";
	}
}

(function () {
	var tAbList = CustomNetTables.GetAllTableValues( "ability_list" );
	var tAbListS = [];
	for(k in tAbList){
		tAbListS[k] = tAbList[k]['value']['name']; 
	}
	tAbListS.sort();
	Ability_Listing(tAbListS);
	
	var tTrList = CustomNetTables.GetAllTableValues( "trait_list" );
	var tTrListS = [];
	for(k in tTrList){
		tTrListS[k] = tTrList[k]['value']['name']; 
	}
	tTrListS.sort();
	Trait_Listing(tTrListS);
	
	var tUlList = CustomNetTables.GetAllTableValues( "ult_list" );
	var tUlListS = [];
	for(k in tUlList){
		tUlListS[k] = tUlList[k]['value']['name']; 
	}
	tUlListS.sort();
	Ult_Listing(tUlListS);
	ShowTeam();
	$.Schedule(0.5,UpdateTimer);
})();