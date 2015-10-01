"use strict";


function UpdateInfo()
{
	var queryUnit = Players.GetLocalPlayerPortraitUnit();
	var hp = Entities.GetHealthPercent( queryUnit )
	var health =	Entities.GetHealth( queryUnit )
	var maxhealth =	Entities.GetMaxHealth( queryUnit )
	var hpreg = Entities.GetHealthThinkRegen( queryUnit )
	hpreg = Math.round(hpreg * 10) / 10
	if (hp) {
		$( "#Health" ).style.width = hp+"%";
		$( "#HealthNum" ).text = health + "/" + maxhealth + " +" + hpreg;
	} else {
		$( "#Health" ).style.width = "0%";
		if (maxhealth) {
		$( "#HealthNum" ).text = "0/"+maxhealth;
		} else {
		$( "#HealthNum" ).text = "0/0";
		}
	}
	var mana =	Entities.GetMana( queryUnit )
	var maxmana =	Entities.GetMaxMana( queryUnit )
	var manap = mana/maxmana*100
	var mpreg = Entities.GetManaThinkRegen( queryUnit )
	mpreg = Math.round(mpreg * 10) / 10
	if (manap) {
		$( "#Mana" ).style.width = manap+"%";
		$( "#ManaNum" ).text = mana + "/" + maxmana + " +" + mpreg;
	} else {
		$( "#Mana" ).style.width = "0%";
		if (maxmana) {
		$( "#ManaNum" ).text = "0/"+maxmana;
		} else {
		$( "#ManaNum" ).text = "0/0";
		}
	}
	UpdateStats();
}


function AutoUpdateHealth()
{
	UpdateInfo();
	$.Schedule( 0.1, AutoUpdateHealth );
}

function UpdateStats()
{
	var queryUnit = Players.GetLocalPlayerPortraitUnit();
	var damage = (Entities.GetDamageMin( queryUnit ) + Entities.GetDamageMax( queryUnit )) / 2
	var dmgbonus = Entities.GetDamageBonus( queryUnit )
	var dmgfull = damage + dmgbonus
	
	//$( "#Damage" ).text = "(" + damage +") + " dmgbonus;
	$( "#Damage" ).text = dmgfull+"("+damage+")";
	
	var ArmorP = Math.round(Entities.GetArmorForDamageType( queryUnit, 1 )* 10) / 10
	var ArmorPR = Math.round(Entities.GetArmorReductionForDamageType( queryUnit, 1 )* 10) / 10
	var ArmorM = Math.round(Entities.GetArmorForDamageType( queryUnit, 2 )* 10) / 10
	var ArmorMR = Math.round(Entities.GetArmorReductionForDamageType( queryUnit, 2 )* 10) / 10
	var AttackRange = Entities.GetAttackRange( queryUnit )
	var AttackSpeed = Math.round(Entities.GetAttackSpeed( queryUnit )* 10) / 10
	var AttacksPS = Math.round(Entities.GetAttacksPerSecond( queryUnit )* 10) / 10
	$( "#ArmorP" ).text = ArmorP+"("+ArmorPR+")"
	$( "#ArmorM" ).text = ArmorM+"("+ArmorMR+")"
	$( "#AttackR" ).text = AttackRange
	$( "#AttackS" ).text = AttackSpeed+"("+AttacksPS+")"
}

(function()
{
	//CreateInfoPanel();
	AutoUpdateHealth();
	//GameEvents.Subscribe( "dota_inventory_changed", UpdateStats );
	//GameEvents.Subscribe( "dota_inventory_item_changed", UpdateStats );
	//GameEvents.Subscribe( "m_event_dota_inventory_changed_query_unit", UpdateStats );
	//GameEvents.Subscribe( "dota_portrait_unit_stats_changed", UpdateStats );
	//GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateStats );
	//GameEvents.Subscribe( "dota_player_update_query_unit", UpdateStats );
	//GameEvents.Subscribe( "CustomGameThink", UpdateInfo );
	//GameEvents.Subscribe( "entity_hurt", UpdateInfo );
	//GameEvents.Subscribe( "dota_unit_event", UpdateInfo );
})();