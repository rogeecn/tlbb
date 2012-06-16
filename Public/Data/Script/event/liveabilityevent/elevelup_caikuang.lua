--�ɿ�������

--�ű���
x713567_g_ScriptId = 713567

--��npc������������ߵȼ�
x713567_g_MaxLevel = 5

----���ܱ��
x713567_g_AbilityID = ABILITY_CAIKUANG

--��������
x713567_g_AbilityName = "�ɿ�"

--**********************************
--������ں���
--**********************************
function x713567_OnDefaultEvent( sceneId, selfId, targetId, nNum, npcScriptId, bid )
	--��Ҽ��ܵĵȼ�
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x713567_g_AbilityID)
	--��Ҽӹ����ܵ�������
	ExpPoint = GetAbilityExp(sceneId, selfId, x713567_g_AbilityID)
	--�����ж�

	--�����û��ѧ��������
	if AbilityLevel < 1	then
		BeginEvent(sceneId)
			strText = "�㻹û��ѧ��"..x713567_g_AbilityName.."���ܣ�"
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--������ڳ���������
	if bid then
		--�������Ƿ��ڵ�ά��״̬
		if CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "CheckCityStatus",sceneId, selfId,targetId) < 0 then
			return
		end
		local ret = CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck",sceneId, selfId, x713567_g_AbilityID, bid, 2)
		if ret > 0 then
			CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnCityAction",sceneId, selfId, targetId, x713567_g_AbilityID, bid, 2)
		end
		return
	end
	--�������ܵȼ��Ѿ�������npc���̵ܽķ�Χ
	if AbilityLevel >= x713567_g_MaxLevel then
		BeginEvent(sceneId)
			strText = "��ֻ�ܽ���1-5����"..x713567_g_AbilityName.."����,�뵽������ѧϰ���߼���"..x713567_g_AbilityName.."."
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		--DispatchAbilityInfo(sceneId, selfId, targetId,x713567_g_ScriptId, x713567_g_AbilityID, LEVELUP_ABILITY_CAIKUANG[AbilityLevel+1].Money, LEVELUP_ABILITY_CAIKUANG[AbilityLevel+1].HumanExp, LEVELUP_ABILITY_CAIKUANG[AbilityLevel+1].AbilityExpLimitShow,LEVELUP_ABILITY_CAIKUANG[AbilityLevel+1].HumanLevelLimit)
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(ABILITY_CAIKUANG, AbilityLevel + 1);
		if ret and ret == 1 then
			DispatchAbilityInfo(sceneId, selfId, targetId,x713567_g_ScriptId, x713567_g_AbilityID, demandMoney, demandExp, limitAbilityExpShow, limitLevel);
		end
	end
end

--**********************************
--�о��¼�
--**********************************
function x713567_OnEnumerate( sceneId, selfId, targetId, bid )
		if bid then
			local ret = CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck",sceneId, selfId, x713567_g_AbilityID, bid, 6)
			if ret > 0 then AddNumText(sceneId,x713567_g_ScriptId,"����"..x713567_g_AbilityName.."����", 12, 1) end
			return
		end
		--��������ȼ�����ʾѡ��
		--if GetLevel(sceneId,selfId) >= LEVELUP_ABILITY_CAIKUANG[1].HumanLevelLimit then
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(ABILITY_CAIKUANG, 1);
		if ret and ret == 1 and 1 then
			AddNumText(sceneId,x713567_g_ScriptId,"����"..x713567_g_AbilityName.."����", 12, 1)
		end
		return
end

--**********************************
--����������
--**********************************
function x713567_CheckAccept( sceneId, selfId )
end

--**********************************
--����
--**********************************
function x713567_OnAccept( sceneId, selfId, x713567_g_AbilityID )
end