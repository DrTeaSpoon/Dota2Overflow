"use strict";

var m_AbilityPanels = []; // created up to a high-water mark, but reused when selection changes
var m_QueryUnit = -1;

function OnLevelUpClicked()
{
	if ( Game.IsInAbilityLearnMode() )
	{
		Game.EndAbilityLearnMode();
	}
	else
	{
		Game.EnterAbilityLearnMode();
	}
}

function OnAbilityLearnModeToggled( bEnabled )
{
	UpdateAbilityList();
}

function SameTeam( queryUnit )
{
	var localteam = Game.GetLocalPlayerInfo().player_team_id;
	var teamId = Entities.GetTeamNumber( queryUnit );
	return localteam == teamId;
}

function UpdateAbilityList()
{
	var abilityListPanelA = $( "#skill_list_A" );
	var abilityListPanelB = $( "#skill_list_B" );
	var abilityListPanelC = $( "#skill_list_C" );
	if ( !abilityListPanelA )
		return;
	if ( !abilityListPanelB )
		return;
	if ( !abilityListPanelC )
		return;

	var queryUnit = Players.GetLocalPlayerPortraitUnit();
	var bSameUnit = ( m_QueryUnit == queryUnit );
	m_QueryUnit = queryUnit;

	// see if we can level up
	if (SameTeam( queryUnit )){
	var nRemainingPoints = Entities.GetAbilityPoints( queryUnit );
	var bPointsToSpend = ( nRemainingPoints > 0 );
	var bControlsUnit = Entities.IsControllableByPlayer( queryUnit, Game.GetLocalPlayerID() );
	$.GetContextPanel().SetHasClass( "could_level_up", ( bControlsUnit && bPointsToSpend ) );
	}
	else
	{
	var nRemainingPoints = 0;
	var nRemainingPoints = 0;
	var bPointsToSpend = ( nRemainingPoints > 0 );
	var bControlsUnit = Entities.IsControllableByPlayer( queryUnit, Game.GetLocalPlayerID() );
	$.GetContextPanel().SetHasClass( "could_level_up", ( bControlsUnit && bPointsToSpend ) );
	}
	// update all the panels
	var nUsedPanels = 0;
	//for ( var i = 0; i < Entities.GetAbilityCount( m_QueryUnit ); ++i )
	for ( var i = 0; i < 10; ++i )
	{
		var ability = Entities.GetAbility( m_QueryUnit, i );
		if ( !Abilities.IsDisplayedAbility(ability) )
			continue;
		
		if ( nUsedPanels >= m_AbilityPanels.length )
		{
			// create a new panel
			if ( nUsedPanels < 3 ) {
			var abilityPanel = $.CreatePanel( "Panel", abilityListPanelA, "" );
			} else if ( nUsedPanels < 6 ) {
			var abilityPanel = $.CreatePanel( "Panel", abilityListPanelB, "" );
			} else if ( nUsedPanels < 10 ) {
			var abilityPanel = $.CreatePanel( "Panel", abilityListPanelC, "" );
			}
			abilityPanel.BLoadLayout( "file://{resources}/layout/custom_game/OverflowHud/action_bar_ability.xml", false, false );
			m_AbilityPanels.push( abilityPanel );
		}

		// update the panel for the current unit / ability
		var abilityPanel = m_AbilityPanels[ nUsedPanels ];
		abilityPanel.data().SetAbility( ability, m_QueryUnit, Game.IsInAbilityLearnMode() );
		
		nUsedPanels++;
	}

	// clear any remaining panels
	for ( var i = nUsedPanels; i < m_AbilityPanels.length; ++i )
	{
		var abilityPanel = m_AbilityPanels[ i ];
		abilityPanel.data().SetAbility( -1, -1, false );
	}
}

(function()
{
    $.RegisterForUnhandledEvent( "DOTAAbility_LearnModeToggled", OnAbilityLearnModeToggled);

	GameEvents.Subscribe( "dota_portrait_ability_layout_changed", UpdateAbilityList );
	GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateAbilityList );
	GameEvents.Subscribe( "dota_player_update_query_unit", UpdateAbilityList );
	GameEvents.Subscribe( "dota_ability_changed", UpdateAbilityList );
	GameEvents.Subscribe( "dota_hero_ability_points_changed", UpdateAbilityList );
	
	UpdateAbilityList(); // initial update
})();

