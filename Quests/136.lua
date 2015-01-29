-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 136;
local ReqClv = 13;
local ReqJlv = 0;
local NextQuest = 137;
local RewZeny = 232;
local RewCxp = 1035;
local RewJxp = 423;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	Saga.GeneralDialog(cid, 3957);
	return 0;
end

-- Initialisation des �tapes
function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 13601);
	Saga.AddStep(cid, QuestID, 13602);
	Saga.AddStep(cid, QuestID, 13603);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- R�compenses
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
		Saga.GiveItem(cid, RewItem2, RewItemCount2);
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	-- Annulation de la qu�te
	return 0;
end

function QUEST_STEP_1(cid)
	-- Lancement des �tapes

	Saga.StepComplete(cid, QuestID, StepID);
	return 0
end

function QUEST_STEP_2(cid)
	-- Lancement des �tapes
	Saga.FindQuestItem(cid, QuestID, StepID, 28, 3960, 10000, 1, 1);

	-- V�rifie que l'on parle au Npc
	if Saga.IsSubStepCompleted(cid,QuestID,13602, 1) == false then
		Saga.UserUpdateActionObjectType(cid,QuestID,StepID,28,0);
	else
		Saga.UserUpdateActionObjectType(cid,QuestID,StepID,28,1);
	end
	
    -- V�rifie si l'�tape en cours est termin�
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		 end
    end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0
end

function QUEST_STEP_3(cid)
	-- Lancement des �tapes
	Saga.AddWaypoint(cid, QuestID, 13603, 1, 1004);

	
	-- V�rifie que l'on parle au Npc
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1004 then
		Saga.GeneralDialog(cid, 3957);
		Saga.NpcTakeItem(cid, 3960, 1);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
    -- V�rifie si l'�tape en cours est termin�
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		 end
    end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
    Saga.QuestComplete(cid, QuestID);
    return -1;
end

function QUEST_CHECK(cid)
	-- V�rifie toutes les �tapes
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 13601 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 13602 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 13603 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
