"use strict";

var m_ItemPanels = []; // created up to a high-water mark, but reused when selection changes
var m_QueryUnit = -1;

//function OnLevelUpClicked()
//{
//	if ( Game.IsInAbilityLearnMode() )
//	{
//		Game.EndAbilityLearnMode();
//	}
//	else
//	{
//		Game.EnterAbilityLearnMode();
//	}
//}
//
//function OnAbilityLearnModeToggled( bEnabled )
//{
//	UpdateAbilityList();
//}

function UpdateAbilityList()
{
	for ( var col = 1; col < 7; ++col )
	{
		var ResearchListPanel = $( "#RTreeCol_"+col );
		if ( !ResearchListPanel )
			break;
	
		for ( var i = 1; i < 9; ++i )
		{
				// create a new panel
				var ItemPanel = $.CreatePanel( "Panel", ResearchListPanel, "" );
				ItemPanel.BLoadLayout( "file://{resources}/layout/custom_game/research_item.xml", false, false );
				m_ItemPanels.push( ItemPanel );
		}
	}
}

(function()
{
    //$.RegisterForUnhandledEvent( "DOTAAbility_LearnModeToggled", OnAbilityLearnModeToggled);

	//GameEvents.Subscribe( "dota_portrait_ability_layout_changed", UpdateAbilityList );
	//GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateAbilityList );
	//GameEvents.Subscribe( "dota_player_update_query_unit", UpdateAbilityList );
	//GameEvents.Subscribe( "dota_ability_changed", UpdateAbilityList );
	//GameEvents.Subscribe( "dota_hero_ability_points_changed", UpdateAbilityList );
	
	UpdateAbilityList(); // initial update
})();

