var tAbList;


function Ability_Listing() {
	var max_row = 24;
	var abs = tAbList.length;
	var need_rows = Math.ceil(abs/max_row)
	var n_r = 1;
	var n_e = 1;
	var AbilityMenu = $.FindChildInContext('#HeroKit_Abilities', '#HeroKit_Root');
	for(k in tAbList){
		if(n_e > max_row){
			n_r++;
			n_e = 1;
		}
		if(n_e == 1){
			var ability_row = $.CreatePanel( 'Panel', AbilityMenu, 'ab_row_'+n_r);
			ability_row.AddClass( "Ability_row" )
		}
		var abilityName = tAbList[k]['value']['name']
		var abilityButton_Ac = 'AbilityPressed('+abilityName+')'
		var ability_row_true = $.FindChildInContext( '#ab_row_'+n_r )
		var ability_item = $.CreatePanel( 'Button', ability_row_true, 'ab_'+k);
		ability_item.AddClass( "ab_button" )
		var AbilityPressed = ( function(_args) { 
				return function(){
					AddSkill(_args)
					$.Msg( _args )
				}
			});
		ability_item.SetPanelEvent( 'onactivate', AbilityPressed(abilityName))
		var ability_image = $.CreatePanel( 'Image', ability_item, '' );
		var image_path = "file://{images}/ability_icons/"+tAbList[k]['value']['name']+".png"
		image_path = image_path.replace("_datadriven", "");
		ability_image.SetImage( image_path );
		//$.Msg(image_path)
		n_e++;
	}
}

function AddSkill(abilityName)
{
	var AbilitySelection = {};
	AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_A');
	AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_B');
	AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_C');
	AbilitySelection[4] = $.FindChildInContext('#HeroKit_Ability_D');
	for (i = 1; i < 5; i++) { 
		if (AbilitySelection[i].data().ability == null)
		{
		AbilitySelection[i].data().ability = abilityName;
		var SelectionImage = AbilitySelection[i].GetChild(0);
		var image_path = "file://{images}/ability_icons/"+abilityName+".png";
		image_path = image_path.replace("_datadriven", "");
		SelectionImage.SetImage( image_path );
		break;
		}
	}
}

function OnRemoveSkill(slot)
{
	var Slot = $.FindChildInContext(slot);
	if (Slot.data().ability != null)
	{
		Slot.data().ability = null;
		var SelectionImage = Slot.GetChild(0);
		var image_path = "file://{images}/ability_icons/empty.png";
		SelectionImage.SetImage( image_path );
	}
}


function OnDone()
{
	var AbilitySelection = {};
	AbilitySelection[1] = $.FindChildInContext('#HeroKit_Ability_A');
	AbilitySelection[2] = $.FindChildInContext('#HeroKit_Ability_B');
	AbilitySelection[3] = $.FindChildInContext('#HeroKit_Ability_C');
	AbilitySelection[4] = $.FindChildInContext('#HeroKit_Ability_D');
	var Ability = {};
	for (i = 1; i < 5; i++) { 
		if (AbilitySelection[i].data().ability != null)
		{
		Ability[i] = AbilitySelection[i].data().ability
		$.Msg(AbilitySelection[i].data().ability);
		} else {
		Ability[i] = 'random'
		$.Msg("Random");
		}
	}
	GameEvents.SendCustomGameEventToServer( "ability_choise", {ability_a: Ability[1], ability_b: Ability[2], ability_c: Ability[3], ability_d: Ability[4]} )
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
	tAbList = CustomNetTables.GetAllTableValues( "ability_list" )
	$.RegisterEventHandler( 'DragEnter', $.GetContextPanel(), OnDragEnter );
	$.RegisterEventHandler( 'DragDrop', $.GetContextPanel(), OnDragDrop );
	$.RegisterEventHandler( 'DragLeave', $.GetContextPanel(), OnDragLeave );
	$.RegisterEventHandler( 'DragStart', $.GetContextPanel(), OnDragStart );
	$.RegisterEventHandler( 'DragEnd', $.GetContextPanel(), OnDragEnd );
	tAbList.sort();
	Ability_Listing();
})();