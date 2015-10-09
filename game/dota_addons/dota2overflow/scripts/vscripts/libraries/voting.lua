
function GameMode:InitGameMode()
	--somewhere in your game mode init
	CustomGameEventManager:RegisterListener("vote_event", Dynamic_Wrap(GameMode, 'VoteEvent'))
end

function GameMode:VoteEvent(keys)
	--We can get avarage of the votes as they come
	if not GameRules.GameTime then
		GameRules.GameTime = keys.vote_small_number
	else
		GameRules.GameTime = (GameRules.GameTime + keys.vote_small_number)/2
	end

	--This works with floating point numbers too.
	if not GameRules.GameTime then
		GameRules.ExperienceScale = keys.vote_desimal_number
	else
		GameRules.ExperienceScale = (GameRules.ExperienceScale + keys.vote_desimal_number)/2
	end
	
	--With strings we can't really do that but we can list all votes and deal with the results somewhere else.
	local pID = keys.PlayerID
	if not GameRules.LevelVote then GameRules.LevelVote = {} end
	GameRules.LevelVote[pID] = keys.vote_string
end