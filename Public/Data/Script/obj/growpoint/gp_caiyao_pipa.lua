--������
--��Ӧ����ܣ���ҩ	�ɿ��ܵı��8
--����
--�ű���710504
--����1	0.6		2	0.3		3	0.1		������ֵĸ�����0.2		����1	0.6		2	0.3		3	0.1
--�ȼ�1

--ÿ�δ򿪱ض���õĲ�Ʒ
x710504_g_MainItemId = 20101005
--���ܵõ��Ĳ�Ʒ
x710504_g_SubItemId = 20304006
--��Ҫ����Id
x710504_g_AbilityId = 8
--��Ҫ���ܵȼ�
x710504_g_AbilityLevel = 2


--���ɺ�����ʼ************************************************************************
--ÿ��ItemBox�����10����Ʒ
function 		x710504_OnCreate(sceneId,growPointType,x,y)
	--����ItemBoxͬʱ����һ����Ʒ
	targetId  = ItemBoxEnterScene(x,y,growPointType,sceneId,QUALITY_MUST_BE_CHANGE,1,x710504_g_MainItemId)	--ÿ�������������ܵõ�һ����Ʒ,����ֱ�ӷ���itembox��һ��
	--���1~100�������,������������Ʒ�͸���Ʒ
	--����Ʒ1~60���ţ�61~90��1����91~100��2��
	--����Ʒ1~12��1����13~18��2����19~20��3��
	local ItemCount = random(1,100)
	if ItemCount >= 61 and ItemCount <= 90 then
		AddItemToBox(sceneId,targetId,QUALITY_MUST_BE_CHANGE,1,x710504_g_MainItemId)
	elseif ItemCount >= 91 and ItemCount <= 100 then
		AddItemToBox(sceneId,targetId,QUALITY_MUST_BE_CHANGE,2,x710504_g_MainItemId,x710504_g_MainItemId)
	end
	--�����Ҫ��Ʒ
	if ItemCount >= 1 and ItemCount <= 12 then
		AddItemToBox(sceneId,targetId,QUALITY_MUST_BE_CHANGE,1,x710504_g_SubItemId)
	elseif ItemCount >= 13 and ItemCount <= 18 then
		AddItemToBox(sceneId,targetId,QUALITY_MUST_BE_CHANGE,2,x710504_g_SubItemId,x710504_g_SubItemId)
	elseif ItemCount >= 19 and ItemCount <= 20 then
		AddItemToBox(sceneId,targetId,QUALITY_MUST_BE_CHANGE,3,x710504_g_SubItemId,x710504_g_SubItemId,x710504_g_SubItemId)
	end
end
--���ɺ�������**********************************************************************


--��ǰ������ʼ&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x710504_OnOpen(sceneId,selfId,targetId)
--��������
-- 0 ��ʾ�򿪳ɹ�
	ABilityID		=	GetItemBoxRequireAbilityID(sceneId,targetId)
	AbilityLevel = QueryHumanAbilityLevel(sceneId,selfId,ABilityID)
	res = x710504_OpenCheck(sceneId,selfId,ABilityID,AbilityLevel)
	return res
	end
--��ǰ��������&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--���պ�����ʼ########################################################################
function	 x710504_OnRecycle(sceneId,selfId,targetId)
	-- ����������
		ABilityID	=	GetItemBoxRequireAbilityID(sceneId,targetId)
	CallScriptFunction(ABILITYLOGIC_ID, "GainExperience", sceneId, selfId, ABilityID, x710504_g_AbilityLevel)
		--����1�����������
		return 1
end
--���պ�������########################################################################



--�򿪺�����ʼ@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x710504_OnProcOver( sceneId, selfId, targetId )
	local ABilityID = GetItemBoxRequireAbilityID( sceneId, targetId )
	CallScriptFunction( ABILITYLOGIC_ID, "EnergyCostCaiJi", sceneId, selfId, ABilityID, x710504_g_AbilityLevel )
	return 0
end
--�򿪺�������@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x710504_OpenCheck(sceneId,selfId,AbilityId,AbilityLevel)
	--�������ܵȼ�
	if AbilityLevel<x710504_g_AbilityLevel then
		return OR_NO_LEVEL
	end
	--��龫��
	if GetHumanEnergy(sceneId,selfId)< (floor(x710504_g_AbilityLevel * 1.5 +2) * 2) then
		return OR_NOT_ENOUGH_ENERGY
	end
	return OR_OK
end