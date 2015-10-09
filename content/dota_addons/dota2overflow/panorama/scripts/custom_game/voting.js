"use strict";
function LevelVoteSelected() {
	var LevelSelect = $.FindChildInContext('#level_select');
}
function TimeVote() {
	var TimeSelect = $.FindChildInContext('#time_input');
}
function ExpDown() {
	var ExpSelect = $.FindChildInContext('#exp_value');
}
function ExpUp() {
	var ExpSelect = $.FindChildInContext('#exp_value');
	
}

function LockVotes() {
	var ExpSelect = $.FindChildInContext('#exp_value');
	var TimeSelect = $.FindChildInContext('#time_input');
	var LevelSelect = $.FindChildInContext('#level_select');
}

(function () {
     $.Msg('voting init')
})();