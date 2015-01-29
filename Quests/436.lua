-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:19 PM

local QuestID = 436;
local ReqClv = 34;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1447;
local RewCxp = 11520;
local RewJxp = 4623;
local RewWxp = 0;
local RewItem1 = 1700115;
local RewItem2 = 0;
local RewItemCount1 = 4;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START()
	-- Initialize all quest steps
	-- Initialize all starting navigation points
	return 0;
end

function QUEST_FINISH()
	Saga.GiveZeny(RewZeny);
	Saga.GiveExp( RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL()
	return 0;
end

function QUEST_CHECK()
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex();
	-- TODO: Add code to check all progress
	return -1;
end
