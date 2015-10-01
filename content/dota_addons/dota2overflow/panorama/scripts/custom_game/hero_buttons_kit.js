function Ability_Listing(tAbListS) {
	var max_row = 7;
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
		var Tooltip = ( function(name) { 
				return function(){
					SetKitTooltip(name);
				}
			});
		ability_item.SetPanelEvent( 'onactivate', AbilityPressed(abilityName,1))
		ability_item.SetPanelEvent( 'onmouseover', Tooltip(abilityName))
		var ability_image = $.CreatePanel( 'Image', ability_item, '' );
		var image_path = "file://{images}/spellicons/"+abilityName+".png"
		image_path = image_path.replace("_datadriven", "");
		ability_image.SetImage( image_path );
		//$.Msg(image_path)
		n_e++;
	}
}

function Ult_Listing(_arg) {
	var max_row = 7;
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
		var Tooltip = ( function(name) { 
				return function(){
					SetKitTooltip(name);
				}
			});
		ability_item.SetPanelEvent( 'onactivate', AbilityPressed(abilityName,3))
		ability_item.SetPanelEvent( 'onmouseover', Tooltip(abilityName))
		var ability_image = $.CreatePanel( 'Image', ability_item, '' );
		var image_path = "file://{images}/spellicons/"+abilityName+".png"
		image_path = image_path.replace("_datadriven", "");
		ability_image.SetImage( image_path );
		n_e++;
	}
}



function Trait_Listing(_arg) {
	var max_row = 7;
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
		var Tooltip = ( function(name) { 
				return function(){
					SetKitTooltip(name);
				}
			});
		ability_item.SetPanelEvent( 'onactivate', AbilityPressed(abilityName,2))
		ability_item.SetPanelEvent( 'onmouseover', Tooltip(abilityName))
		var ability_image = $.CreatePanel( 'Image', ability_item, '' );
		var image_path = "file://{images}/spellicons/"+abilityName+".png"
		image_path = image_path.replace("_datadriven", "");
		ability_image.SetImage( image_path );
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
			var image_path = "file://{images}/spellicons/"+abilityName+".png";
			if (image_path.indexOf("_datadriven") > -1) {
				image_path = image_path.replace("_datadriven", "");
			}
			SelectionImage.SetImage( image_path );
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
			var image_path = "file://{images}/spellicons/"+abilityName+".png";
			if (image_path.indexOf("_datadriven") > -1) {
				image_path = image_path.replace("_datadriven", "");
			}
			SelectionImage.SetImage( image_path );
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
			var image_path = "file://{images}/spellicons/"+abilityName+".png";
			if (image_path.indexOf("_datadriven") > -1) {
				image_path = image_path.replace("_datadriven", "");
			}
			SelectionImage.SetImage( image_path );
			break;
			}
		}
		
	}
}

function SetKitTooltip(abilityName)
{
	var tooltip_name = $.FindChildInContext('#tool_tip_name');
	var tooltip_desc = $.FindChildInContext('#tool_tip_desc');
	tooltip_name.text = $.Localize( "#DOTA_Tooltip_ability_"+abilityName )
	tooltip_desc.text = $.Localize( "#DOTA_Tooltip_ability_"+abilityName+"_Description" )
}
function OnRemoveSkill(slot)
{
	var Slot = $.FindChildInContext(slot);
	if (Slot.data().ability != null)
	{
		Slot.data().ability = null;
		var SelectionImage = Slot.GetChild(0);
		var image_path = "file://{images}/spellicons/empty.png";
		SelectionImage.SetImage( image_path );
	}
}


function OnDone()
{
	var AbilitySelection = {};
	AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_Q');
	AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_W');
	AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_E');
	AbilitySelection[4] = $.FindChildInContext('#HeroKit_Ability_D');
	AbilitySelection[5] = $.FindChildInContext('#HeroKit_Ability_F');
	AbilitySelection[6] = $.FindChildInContext('#HeroKit_Ability_R');
	var Ability = {};
	for (i = 1; i < 7; i++) { 
		if (AbilitySelection[i].data().ability != null)
		{
		Ability[i] = AbilitySelection[i].data().ability
		$.Msg(AbilitySelection[i].data().ability);
		} else {
		Ability[i] = 'random'
		$.Msg("Random");
		}
	}
	GameEvents.SendCustomGameEventToServer( "ability_choise", {ability_q: Ability[1], ability_w: Ability[2], ability_e: Ability[3], ability_d: Ability[4], ability_f: Ability[5], ability_r: Ability[6]} )
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

function OnDragEnd( panelId, draggedPanel )
{
	var imageButton = $.FindChildInContext( "#"+panelId )
	var imagePanel = draggedPanel.GetChild(0)
	imagePanel.SetParent(imageButton)
	draggedPanel.DeleteAsync( 0 );
	return true;
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
})();