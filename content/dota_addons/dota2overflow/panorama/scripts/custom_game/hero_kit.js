var tAbList;
function Ability_Listing() {
	for (i = 1; i < 5; i++) {
		var AbilityMenu = $.FindChildInContext('#ab_'+i, '#HeroKit_Root');
		for(k in tAbList){
		var ability_item = $.CreatePanel( 'Label', AbilityMenu, 'ab_'+i+'_'+tAbList[k]['value']['name'] );
		ability_item.text = $.Localize( 'DOTA_Tooltip_ability_' + tAbList[k]['value']['name'] );
			AbilityMenu.AddOption( ability_item, tAbList[k]['value']['name'] )
		}
	}
}


(function () {
	tAbList = CustomNetTables.GetAllTableValues( "ability_list" )
	Ability_Listing();
     $.Msg('callback')
     $.Msg(tAbList)
})();