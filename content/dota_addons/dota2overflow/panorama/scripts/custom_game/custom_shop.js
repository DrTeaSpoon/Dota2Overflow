
function GenerateShopA(ShopList) {
	var max_row = 10;
	var items = ShopList.length;
	var need_rows = Math.ceil(items/max_row)
	var n_r = 1;
	var n_e = 1;
	var ShopAMenu = $.FindChildInContext('#CShop_A');
	for(k in ShopList){
		if(n_e > max_row){
			n_r++;
			n_e = 1;
		}
		if(n_e == 1){
			var item_row = $.CreatePanel( 'Panel', ShopAMenu, 'item_row_'+n_r);
			item_row.AddClass( "item_row" )
		}
		var itemName = ShopList[k]
		var itemButton_Ac = 'ItemSelected('+itemName+')'
		var item_row_true = $.FindChildInContext( '#item_row_'+n_r )
		var item_panel = $.CreatePanel( 'Button', item_row_true, 'item_'+k);
		item_panel.AddClass( "item_button" );
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
		item_panel.SetPanelEvent( 'onmouseover', HoverIn(itemName,item_panel));
		item_panel.SetPanelEvent( 'onmouseout', HoverOut(item_panel));
		item_panel.SetPanelEvent( 'onactivate', AbilityPressed(itemName,1));
		var item_image = $.CreatePanel( 'DOTAItemImage', item_panel, '' );
		item_image.itemname = itemName;
		
		n_e++;
	}
}


function Tooltip(abilityName,abilityButton){
	$.DispatchEvent( "DOTAShowAbilityTooltip", abilityButton, abilityName );
}
function HideTooltip(abilityButton){
	$.DispatchEvent( "DOTAHideAbilityTooltip", abilityButton );
}


function AddSkill(abilityName,type)
{
	
}

function OpenShop()
{
	var ShopAMenu = $.GetContextPanel();
	if (ShopAMenu.BHasClass( "shop_open" )){
	ShopAMenu.RemoveClass( "shop_open" );
	} else {
	ShopAMenu.AddClass( "shop_open" );
	}
}

(function () {
	var tShopA_raw = CustomNetTables.GetAllTableValues( "shop_a_list" );
	var tShopA = [];
	for(k in tShopA_raw){
		tShopA[k] = tShopA_raw[k]['value']['name']; 
	}
	tShopA.sort();
	GenerateShopA(tShopA);
})();