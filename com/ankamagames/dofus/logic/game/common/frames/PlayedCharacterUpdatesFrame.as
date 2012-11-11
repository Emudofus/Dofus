package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.people.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.almanach.*;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.*;
    import com.ankamagames.dofus.network.messages.game.character.stats.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.death.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.stats.*;
    import com.ankamagames.dofus.network.messages.game.initialization.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.pattern.*;
    import flash.utils.*;

    public class PlayedCharacterUpdatesFrame extends Object implements Frame
    {
        public var setList:Array;
        public var guildEmblemSymbolCategories:int;
        public static var SPELL_TOOLTIP_CACHE_NUM:int = 0;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterUpdatesFrame));

        public function PlayedCharacterUpdatesFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGH;
        }// end function

        public function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        public function pushed() : Boolean
        {
            this.setList = new Array();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var name:String;
            var scrmsg:SetCharacterRestrictionsMessage;
            var semsg:ServerExperienceModificatorMessage;
            var cslmsg:CharacterStatsListMessage;
            var fightBattleFrame:FightBattleFrame;
            var ccmsg:CharacterCapabilitiesMessage;
            var isla:IncreaseSpellLevelAction;
            var spurmsg:SpellUpgradeRequestMessage;
            var susmsg:SpellUpgradeSuccessMessage;
            var position:uint;
            var updatedSW:SpellWrapper;
            var updated:Boolean;
            var previousCooldown:int;
            var sfmsg:SpellForgottenMessage;
            var sufmsg:SpellUpgradeFailureMessage;
            var sura:StatsUpgradeRequestAction;
            var surqmsg:StatsUpgradeRequestMessage;
            var surmsg:StatsUpgradeResultMessage;
            var clumsg:CharacterLevelUpMessage;
            var messageId:uint;
            var cegmsg:CharacterExperienceGainMessage;
            var grplsmsg:GameRolePlayPlayerLifeStatusMessage;
            var grpgomsg:GameRolePlayGameOverMessage;
            var acdmsg:AlmanachCalendarDateMessage;
            var sumsg:SetUpdateMessage;
            var crmsg:CompassResetMessage;
            var cumsg:CompassUpdateMessage;
            var legend:String;
            var color:uint;
            var sw:SpellWrapper;
            var oldSw:SpellWrapper;
            var swn:SpellWrapper;
            var spellPointEarned:uint;
            var caracPointEarned:uint;
            var healPointEarned:uint;
            var newSpell:Array;
            var returnedSpell:SpellWrapper;
            var playerBreed:Breed;
            var spellObtained:Boolean;
            var levelSpellObtention:int;
            var cluimsg:CharacterLevelUpInformationMessage;
            var onSameMap:Boolean;
            var displayTextInfo:String;
            var swBreed:Spell;
            var obtentionLevel:uint;
            var swrapper:SpellWrapper;
            var pBreed:Breed;
            var swB:Spell;
            var sl:SpellLevel;
            var minPlayerLevel:uint;
            var selectedSpell:SpellLevel;
            var ssequencer:SerialSequencer;
            var entityId:int;
            var ss:SerialSequencer;
            var socialFrame:SocialFrame;
            var memberId:int;
            var pmFrame:PartyManagementFrame;
            var socialFrame2:SocialFrame;
            var memberInfo:PartyMemberWrapper;
            var msg:* = param1;
            switch(true)
            {
                case msg is SetCharacterRestrictionsMessage:
                {
                    scrmsg = msg as SetCharacterRestrictionsMessage;
                    PlayedCharacterManager.getInstance().restrictions = scrmsg.restrictions;
                    return true;
                }
                case msg is ServerExperienceModificatorMessage:
                {
                    semsg = msg as ServerExperienceModificatorMessage;
                    PlayedCharacterManager.getInstance().experiencePercent = semsg.experiencePercent - 100;
                    return true;
                }
                case msg is CharacterStatsListMessage:
                {
                    cslmsg = msg as CharacterStatsListMessage;
                    fightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                    if (fightBattleFrame != null && fightBattleFrame.executingSequence)
                    {
                        fightBattleFrame.delayCharacterStatsList(cslmsg);
                    }
                    else
                    {
                        this.updateCharacterStatsList(cslmsg);
                    }
                    return true;
                }
                case msg is CharacterCapabilitiesMessage:
                {
                    ccmsg = msg as CharacterCapabilitiesMessage;
                    this.guildEmblemSymbolCategories = ccmsg.guildEmblemSymbolCategories;
                    return true;
                }
                case msg is IncreaseSpellLevelAction:
                {
                    isla = msg as IncreaseSpellLevelAction;
                    spurmsg = new SpellUpgradeRequestMessage();
                    spurmsg.initSpellUpgradeRequestMessage(isla.spellId);
                    ConnectionsHandler.getConnection().send(spurmsg);
                    return true;
                }
                case msg is SpellUpgradeSuccessMessage:
                {
                    if (!PlayedCharacterManager.getInstance().spellsInventory)
                    {
                        return true;
                    }
                    susmsg = msg as SpellUpgradeSuccessMessage;
                    position;
                    updated;
                    previousCooldown;
                    var _loc_3:* = 0;
                    var _loc_4:* = PlayedCharacterManager.getInstance().spellsInventory;
                    while (_loc_4 in _loc_3)
                    {
                        
                        sw = _loc_4[_loc_3];
                        if (sw.id == susmsg.spellId)
                        {
                            oldSw = SpellWrapper.getFirstSpellWrapperById(sw.id, sw.playerId);
                            if (oldSw)
                            {
                                previousCooldown = oldSw.actualCooldown;
                            }
                            updatedSW = SpellWrapper.create(sw.position, sw.id, susmsg.spellLevel, true, sw.playerId);
                            position = sw.position;
                            break;
                        }
                    }
                    if (updatedSW == null)
                    {
                        swn = SpellWrapper.create(63, susmsg.spellId, susmsg.spellLevel, true, PlayedCharacterManager.getInstance().id);
                        PlayedCharacterManager.getInstance().spellsInventory.push(swn);
                        KernelEventsManager.getInstance().processCallback(HookList.SpellList, PlayedCharacterManager.getInstance().spellsInventory);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.SpellUpgradeSuccess, updatedSW);
                        updatedSW.actualCooldown = previousCooldown;
                    }
                    return true;
                }
                case msg is SpellForgottenMessage:
                {
                    sfmsg = msg as SpellForgottenMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.SpellForgotten, sfmsg.boostPoint, sfmsg.spellsId);
                    return true;
                }
                case msg is SpellUpgradeFailureMessage:
                {
                    sufmsg = msg as SpellUpgradeFailureMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.SpellUpgradeFail);
                    return true;
                }
                case msg is StatsUpgradeRequestAction:
                {
                    sura = msg as StatsUpgradeRequestAction;
                    surqmsg = new StatsUpgradeRequestMessage();
                    surqmsg.initStatsUpgradeRequestMessage(sura.statId, sura.boostPoint);
                    ConnectionsHandler.getConnection().send(surqmsg);
                    return true;
                }
                case msg is StatsUpgradeResultMessage:
                {
                    surmsg = msg as StatsUpgradeResultMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.StatsUpgradeResult, surmsg.nbCharacBoost);
                    if (surmsg.nbCharacBoost == 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.popup.statboostFailed.text"), ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case msg is CharacterLevelUpMessage:
                {
                    clumsg = msg as CharacterLevelUpMessage;
                    messageId = clumsg.getMessageId();
                    switch(messageId)
                    {
                        case CharacterLevelUpMessage.protocolId:
                        {
                            spellPointEarned = clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level;
                            caracPointEarned = (clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level) * 5;
                            healPointEarned = (clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level) * 5;
                            newSpell = new Array();
                            playerBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                            var _loc_3:* = 0;
                            var _loc_4:* = playerBreed.breedSpells;
                            while (_loc_4 in _loc_3)
                            {
                                
                                swBreed = _loc_4[_loc_3];
                                obtentionLevel = SpellLevel.getLevelById(swBreed.spellLevels[0]).minPlayerLevel;
                                if (obtentionLevel <= clumsg.newLevel && obtentionLevel > PlayedCharacterManager.getInstance().infos.level)
                                {
                                    swrapper = SpellWrapper.create(63, swBreed.id, 1, false);
                                    newSpell.push(swrapper);
                                }
                            }
                            spellObtained;
                            levelSpellObtention;
                            if (newSpell.length)
                            {
                                KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerNewSpell);
                                returnedSpell = newSpell[0] as SpellWrapper;
                            }
                            else
                            {
                                spellObtained;
                                pBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                                var _loc_3:* = 0;
                                var _loc_4:* = pBreed.breedSpells;
                                while (_loc_4 in _loc_3)
                                {
                                    
                                    swB = _loc_4[_loc_3];
                                    sl = SpellLevel.getLevelById(swB.spellLevels[0]);
                                    minPlayerLevel = sl.minPlayerLevel;
                                    if (minPlayerLevel > clumsg.newLevel)
                                    {
                                        newSpell.push(sl);
                                    }
                                }
                                if (newSpell.length > 0)
                                {
                                    newSpell.sortOn("minPlayerLevel", Array.NUMERIC);
                                    selectedSpell = newSpell[0] as SpellLevel;
                                    returnedSpell = SpellWrapper.create(63, selectedSpell.spellId, 1, false);
                                    levelSpellObtention = selectedSpell.minPlayerLevel;
                                }
                            }
                            PlayedCharacterManager.getInstance().infos.level = clumsg.newLevel;
                            try
                            {
                                ssequencer = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
                                ssequencer.addStep(new AddGfxEntityStep(152, DofusEntities.getEntity(PlayedCharacterManager.getInstance().infos.id).com.ankamagames.jerakine.entities.interfaces:IEntity::position.cellId));
                                ssequencer.start();
                            }
                            catch (e:Error)
                            {
                            }
                            SoundManager.getInstance().manager.playUISound(UISoundEnum.LEVEL_UP);
                            KernelEventsManager.getInstance().processCallback(HookList.CharacterLevelUp, clumsg.newLevel, spellPointEarned, caracPointEarned, healPointEarned, returnedSpell, spellObtained, levelSpellObtention);
                            break;
                        }
                        case CharacterLevelUpInformationMessage.protocolId:
                        {
                            cluimsg = msg as CharacterLevelUpInformationMessage;
                            onSameMap;
                            try
                            {
                                var _loc_3:* = 0;
                                var _loc_4:* = this.roleplayContextFrame.entitiesFrame.getEntitiesIdsList();
                                while (_loc_4 in _loc_3)
                                {
                                    
                                    entityId = _loc_4[_loc_3];
                                    if (entityId == cluimsg.id)
                                    {
                                        onSameMap;
                                        continue;
                                    }
                                }
                                if (onSameMap)
                                {
                                    ss = new SerialSequencer();
                                    ss.addStep(new AddGfxEntityStep(152, DofusEntities.getEntity(cluimsg.id).com.ankamagames.jerakine.entities.interfaces:IEntity::position.cellId));
                                    ss.start();
                                }
                            }
                            catch (e:Error)
                            {
                                _log.warn("Un problème est survenu lors du traitement du message CharacterLevelUpInformationMessage. " + "Un personnage vient de changer de niveau mais on n\'est surement pas encore sur la map");
                            }
                            displayTextInfo = I18n.getUiText("ui.common.characterLevelUp", ["{player," + cluimsg.name + "}", cluimsg.newLevel]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, displayTextInfo, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case msg is CharacterExperienceGainMessage:
                {
                    cegmsg = msg as CharacterExperienceGainMessage;
                    if (cegmsg.experienceCharacter > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mine", [StringUtils.formateIntToString(cegmsg.experienceCharacter)]), "n", cegmsg.experienceCharacter == 1), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    if (cegmsg.experienceIncarnation > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.incarnation", [StringUtils.formateIntToString(cegmsg.experienceIncarnation)]), "n", cegmsg.experienceIncarnation == 1), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    if (cegmsg.experienceGuild > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.guild", [StringUtils.formateIntToString(cegmsg.experienceGuild)]), "n", cegmsg.experienceGuild == 1), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    if (cegmsg.experienceMount > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mount", [StringUtils.formateIntToString(cegmsg.experienceMount)]), "n", cegmsg.experienceMount == 1), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case msg is GameRolePlayPlayerLifeStatusMessage:
                {
                    grplsmsg = msg as GameRolePlayPlayerLifeStatusMessage;
                    PlayedCharacterManager.getInstance().state = grplsmsg.state;
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus, grplsmsg.state, 0);
                    return true;
                }
                case msg is GameRolePlayGameOverMessage:
                {
                    grpgomsg = msg as GameRolePlayGameOverMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus, 2, 1);
                    return true;
                }
                case msg is AlmanachCalendarDateMessage:
                {
                    acdmsg = msg as AlmanachCalendarDateMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.CalendarDate, acdmsg.date);
                    return true;
                }
                case msg is SetUpdateMessage:
                {
                    sumsg = msg as SetUpdateMessage;
                    this.setList[sumsg.setId] = new PlayerSetInfo(sumsg.setId, sumsg.setObjects, sumsg.setEffects);
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.SetUpdate, sumsg.setId);
                    return true;
                }
                case msg is CompassResetMessage:
                {
                    crmsg = msg as CompassResetMessage;
                    name = "flag_srv" + crmsg.type;
                    switch(crmsg.type)
                    {
                        case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                        {
                            socialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
                            socialFrame.spouse.followSpouse = false;
                            KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, false);
                            break;
                        }
                        case CompassTypeEnum.COMPASS_TYPE_PARTY:
                        {
                            if (PlayedCharacterManager.getInstance().followingPlayerId == -1)
                            {
                                return true;
                            }
                            name = name + ("_" + PlayedCharacterManager.getInstance().followingPlayerId);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, name);
                    return true;
                }
                case msg is CompassUpdatePartyMemberMessage:
                case msg is CompassUpdatePvpSeekMessage:
                case msg is CompassUpdateMessage:
                {
                    cumsg = msg as CompassUpdateMessage;
                    name = "flag_srv" + cumsg.type;
                    switch(cumsg.type)
                    {
                        case CompassTypeEnum.COMPASS_TYPE_PARTY:
                        {
                            memberId = CompassUpdatePartyMemberMessage(msg).memberId;
                            pmFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
                            if (pmFrame)
                            {
                                memberInfo = pmFrame.getGroupMemberById(memberId);
                                if (memberInfo)
                                {
                                    legend = I18n.getUiText("ui.cartography.positionof", [memberInfo.name]) + " (" + cumsg.worldX + "," + cumsg.worldY + ")";
                                }
                                name = name + ("_" + memberId);
                            }
                            color;
                            break;
                        }
                        case CompassTypeEnum.COMPASS_TYPE_PVP_SEEK:
                        {
                            legend = I18n.getUiText("ui.cartography.positionof", [CompassUpdatePvpSeekMessage(msg).memberName]) + " (" + CompassUpdatePvpSeekMessage(msg).worldX + "," + CompassUpdatePvpSeekMessage(msg).worldY + ")";
                            color;
                            break;
                        }
                        case CompassTypeEnum.COMPASS_TYPE_QUEST:
                        {
                            legend = cumsg.worldX + "," + cumsg.worldY;
                            color;
                            break;
                        }
                        case CompassTypeEnum.COMPASS_TYPE_SIMPLE:
                        {
                            legend = cumsg.worldX + "," + cumsg.worldY;
                            color;
                            break;
                        }
                        case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                        {
                            color;
                            socialFrame2 = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
                            socialFrame2.spouse.followSpouse = true;
                            legend = I18n.getUiText("ui.cartography.positionof", [socialFrame2.spouse.name]) + " (" + cumsg.worldX + "," + cumsg.worldY + ")";
                            KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, true);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, name, legend, cumsg.worldX, cumsg.worldY, color, false);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function updateCharacterStatsList(param1:CharacterStatsListMessage) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_2:* = PlayedCharacterManager.getInstance().characteristics;
            if (_loc_2)
            {
                if (_loc_2.energyPoints > param1.stats.energyPoints)
                {
                    KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerIsDead);
                }
                if (param1.stats.alignmentInfos.dishonor > 0 && _loc_2.alignmentInfos.dishonor != param1.stats.alignmentInfos.dishonor)
                {
                    KernelEventsManager.getInstance().processCallback(SocialHookList.DishonourChanged, param1.stats.alignmentInfos.dishonor);
                }
                if (param1.stats.kamas != InventoryManager.getInstance().inventory.kamas)
                {
                    InventoryManager.getInstance().inventory.kamas = param1.stats.kamas;
                }
                _loc_3 = PlayedCharacterManager.getInstance().characteristics.spellModifications;
                _loc_4 = param1.stats.spellModifications;
                _loc_5 = Math.max(_loc_3.length, _loc_4.length);
                _loc_6 = new Array();
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    if (_loc_3.length <= _loc_7)
                    {
                        if (_loc_6.indexOf(_loc_4[_loc_7].spellId) == -1)
                        {
                            _loc_6.push(_loc_4[_loc_7].spellId);
                        }
                    }
                    else if (_loc_4.length <= _loc_7)
                    {
                        if (_loc_6.indexOf(_loc_3[_loc_7].spellId) == -1)
                        {
                            _loc_6.push(_loc_3[_loc_7].spellId);
                        }
                    }
                    else if (_loc_3[_loc_7] != _loc_4[_loc_7])
                    {
                        if (_loc_6.indexOf(_loc_4[_loc_7].spellId) == -1)
                        {
                            _loc_6.push(_loc_4[_loc_7].spellId);
                        }
                        if (_loc_6.indexOf(_loc_3[_loc_7].spellId) == -1)
                        {
                            _loc_6.push(_loc_3[_loc_7].spellId);
                        }
                    }
                    _loc_7++;
                }
                for each (_loc_8 in _loc_6)
                {
                    
                    _loc_9 = SpellWrapper.getSpellWrappersById(_loc_8, PlayedCharacterManager.getInstance().id);
                    for each (_loc_10 in _loc_9)
                    {
                        
                        if (_loc_10)
                        {
                            _loc_10 = SpellWrapper.create(_loc_10.position, _loc_10.spellId, _loc_10.spellLevel, true, PlayedCharacterManager.getInstance().id);
                            var _loc_15:* = _loc_10;
                            var _loc_16:* = _loc_10.versionNum + 1;
                            _loc_15.versionNum = _loc_16;
                        }
                    }
                }
            }
            PlayedCharacterManager.getInstance().characteristics = param1.stats;
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                if (CurrentPlayedFighterManager.getInstance().isRealPlayer())
                {
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                }
                SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            }
            return;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        public function getPlayerSet(param1:uint) : PlayerSetInfo
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = this.setList.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this.setList[_loc_3];
                if (_loc_4)
                {
                    _loc_5 = _loc_4.setObjects;
                    _loc_6 = _loc_5.length;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6)
                    {
                        
                        if (_loc_5[_loc_7] == param1)
                        {
                            return _loc_4;
                        }
                        _loc_7++;
                    }
                }
                _loc_3++;
            }
            return null;
        }// end function

    }
}
