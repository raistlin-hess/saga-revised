-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM
--Spanner 7/26/08

local QuestID = 127;
local ReqClv = 9;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 266;
local RewCxp = 519;
local RewJxp = 204;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 6;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 12701);
	Saga.AddStep(cid, QuestID, 12702);
	Saga.AddStep(cid, QuestID, 12703);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end

function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
	Saga.GiveZeny(RewZeny);
	Saga.GiveExp( RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveItem(cid, RewItem2, RewItemCount2 );
	    return 0;
    else
	    return -1;
	end
end
function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	Saga.StepComplete(cid, QuestID, 12701);
	return 0;
end
function QUEST_STEP_2(cid)
--Eliminate Be Chased Mermaid<

	Saga.Eliminate(cid, QuestID, 12702, 10034, 6, 1);
	Saga.Eliminate(cid, QuestID, 12702, 10035, 6, 1);

--check if all substeps are completed
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12702, i) == false
then
	return -1;
	end
end
	Saga.StepComplete(cid, QuestID, 12702);
	return 0;
end

function QUEST_STEP_3(cid)
--Talk to aldria?? (Adria sill?)
	
	Saga.AddWaypoint(cid, QuestID, 12703, 1, 1143);
--check for completion
	local = Saga.GetNPCIndex(cid);
	if ret == 1143
then
	Saga.GeneralDialog(cid, 3936);
	Saga.SubstepComplete(cid, QuestID, 12703, 1);
	end
end
--check if all substeps are completed
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12703, i) == false
then
	return -1;
	end
end
	Saga.StepComplete(cid, QuestID, 12703);
	Saga.ClearWaypoints(cid, QuestID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 12701 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 12702 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 12703 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid)
	end

	return ret;
end

	