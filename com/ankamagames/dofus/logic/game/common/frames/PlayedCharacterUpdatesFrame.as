package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.network.messages.game.initialization.SetCharacterRestrictionsMessage;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.messages.game.initialization.ServerExperienceModificatorMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterStatsListMessage;
    import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.network.messages.game.initialization.CharacterCapabilitiesMessage;
    import com.ankamagames.dofus.logic.game.common.actions.IncreaseSpellLevelAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellUpgradeRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellUpgradeSuccessMessage;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellForgottenMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellUpgradeFailureMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.StatsUpgradeRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.stats.StatsUpgradeRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.stats.StatsUpgradeResultMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterLevelUpMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterExperienceGainMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayPlayerLifeStatusMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayGameOverMessage;
    import com.ankamagames.dofus.network.messages.game.almanach.AlmanachCalendarDateMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.SetUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassResetMessage;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.basic.BasicTimeMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterLevelUpInformationMessage;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.PrismHookList;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.misc.lists.TriggerHookList;
    import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.types.data.PlayerSetInfo;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassUpdatePartyMemberMessage;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassUpdatePvpSeekMessage;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;

    public class PlayedCharacterUpdatesFrame implements Frame 
    {

        public static var SPELL_TOOLTIP_CACHE_NUM:int = 0;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterUpdatesFrame));

        public var setList:Array;
        public var guildEmblemSymbolCategories:int;


        public function get priority():int
        {
            return (Priority.HIGH);
        }

        public function get roleplayContextFrame():RoleplayContextFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame));
        }

        public function pushed():Boolean
        {
            this.setList = new Array();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var name:String;
            var scrmsg:SetCharacterRestrictionsMessage;
            var rpEntitiesFrame:RoleplayEntitiesFrame;
            var semsg:ServerExperienceModificatorMessage;
            var cslmsg:CharacterStatsListMessage;
            var fightBattleFrame:FightBattleFrame;
            var mcidmsg:MapComplementaryInformationsDataMessage;
            var grai:GameRolePlayActorInformations;
            var grpci:GameRolePlayCharacterInformations;
            var opt:* = undefined;
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
            var btmsg:BasicTimeMessage;
            var date:Date;
            var receptionDelay:int;
            var infos:GameRolePlayHumanoidInformations;
            var currentLook:TiphonEntityLook;
            var newLook:TiphonEntityLook;
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
            switch (true)
            {
                case (msg is SetCharacterRestrictionsMessage):
                    scrmsg = (msg as SetCharacterRestrictionsMessage);
                    PlayedCharacterManager.getInstance().restrictions = scrmsg.restrictions;
                    rpEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    if (rpEntitiesFrame)
                    {
                        infos = (rpEntitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayHumanoidInformations);
                        if (infos)
                        {
                            infos.humanoidInfo.restrictions = PlayedCharacterManager.getInstance().restrictions;
                        };
                    };
                    return (true);
                case (msg is ServerExperienceModificatorMessage):
                    semsg = (msg as ServerExperienceModificatorMessage);
                    PlayedCharacterManager.getInstance().experiencePercent = (semsg.experiencePercent - 100);
                    return (true);
                case (msg is CharacterStatsListMessage):
                    cslmsg = (msg as CharacterStatsListMessage);
                    fightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
                    if (((!((fightBattleFrame == null))) && (fightBattleFrame.executingSequence)))
                    {
                        fightBattleFrame.delayCharacterStatsList(cslmsg);
                    }
                    else
                    {
                        this.updateCharacterStatsList(cslmsg);
                    };
                    return (true);
                case (msg is MapComplementaryInformationsDataMessage):
                    mcidmsg = (msg as MapComplementaryInformationsDataMessage);
                    for each (grai in mcidmsg.actors)
                    {
                        grpci = (grai as GameRolePlayCharacterInformations);
                        if (((grpci) && ((grpci.contextualId == PlayedCharacterManager.getInstance().id))))
                        {
                            currentLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
                            newLook = EntityLookAdapter.fromNetwork(grpci.look);
                            if (((!(currentLook.equals(newLook))) && (this.roleplayContextFrame.entitiesFrame)))
                            {
                                this.roleplayContextFrame.entitiesFrame.dispatchPlayerNewLook = true;
                            };
                            PlayedCharacterManager.getInstance().infos.entityLook = grpci.look;
                            for each (opt in grpci.humanoidInfo.options)
                            {
                                if ((opt is HumanOptionAlliance))
                                {
                                    PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = (opt as HumanOptionAlliance).aggressable;
                                    KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange, (opt as HumanOptionAlliance).aggressable, PlayedCharacterManager.getInstance().characteristics.probationTime);
                                    return (false);
                                };
                            };
                            break;
                        };
                    };
                    return (false);
                case (msg is CharacterCapabilitiesMessage):
                    ccmsg = (msg as CharacterCapabilitiesMessage);
                    this.guildEmblemSymbolCategories = ccmsg.guildEmblemSymbolCategories;
                    return (true);
                case (msg is IncreaseSpellLevelAction):
                    isla = (msg as IncreaseSpellLevelAction);
                    spurmsg = new SpellUpgradeRequestMessage();
                    spurmsg.initSpellUpgradeRequestMessage(isla.spellId, isla.spellLevel);
                    ConnectionsHandler.getConnection().send(spurmsg);
                    return (true);
                case (msg is SpellUpgradeSuccessMessage):
                    if (!(PlayedCharacterManager.getInstance().spellsInventory))
                    {
                        return (true);
                    };
                    susmsg = (msg as SpellUpgradeSuccessMessage);
                    position = 63;
                    updated = false;
                    previousCooldown = 0;
                    for each (sw in PlayedCharacterManager.getInstance().spellsInventory)
                    {
                        if (sw.id == susmsg.spellId)
                        {
                            oldSw = SpellWrapper.getFirstSpellWrapperById(sw.id, sw.playerId);
                            if (oldSw)
                            {
                                previousCooldown = oldSw.actualCooldown;
                            };
                            updatedSW = SpellWrapper.create(sw.position, sw.id, susmsg.spellLevel, true, sw.playerId);
                            position = sw.position;
                            break;
                        };
                    };
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
                    };
                    return (true);
                case (msg is SpellForgottenMessage):
                    sfmsg = (msg as SpellForgottenMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.SpellForgotten, sfmsg.boostPoint, sfmsg.spellsId);
                    return (true);
                case (msg is SpellUpgradeFailureMessage):
                    sufmsg = (msg as SpellUpgradeFailureMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.SpellUpgradeFail);
                    return (true);
                case (msg is StatsUpgradeRequestAction):
                    sura = (msg as StatsUpgradeRequestAction);
                    surqmsg = new StatsUpgradeRequestMessage();
                    surqmsg.initStatsUpgradeRequestMessage(sura.statId, sura.boostPoint);
                    ConnectionsHandler.getConnection().send(surqmsg);
                    return (true);
                case (msg is StatsUpgradeResultMessage):
                    surmsg = (msg as StatsUpgradeResultMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.StatsUpgradeResult, surmsg.nbCharacBoost);
                    if (surmsg.nbCharacBoost == 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.popup.statboostFailed.text"), ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is CharacterLevelUpMessage):
                    clumsg = (msg as CharacterLevelUpMessage);
                    messageId = clumsg.getMessageId();
                    switch (messageId)
                    {
                        case CharacterLevelUpMessage.protocolId:
                            spellPointEarned = (clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level);
                            caracPointEarned = ((clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level) * 5);
                            healPointEarned = ((clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level) * 5);
                            newSpell = new Array();
                            playerBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                            for each (swBreed in playerBreed.breedSpells)
                            {
                                obtentionLevel = swBreed.getSpellLevel(1).minPlayerLevel;
                                if ((((obtentionLevel <= clumsg.newLevel)) && ((obtentionLevel > PlayedCharacterManager.getInstance().infos.level))))
                                {
                                    swrapper = SpellWrapper.create(63, swBreed.id, 1, false);
                                    newSpell.push(swrapper);
                                };
                            };
                            spellObtained = true;
                            levelSpellObtention = -1;
                            if (newSpell.length)
                            {
                                KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerNewSpell);
                                returnedSpell = (newSpell[0] as SpellWrapper);
                            }
                            else
                            {
                                spellObtained = false;
                                pBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                                for each (swB in pBreed.breedSpells)
                                {
                                    sl = swB.getSpellLevel(1);
                                    minPlayerLevel = sl.minPlayerLevel;
                                    if (minPlayerLevel > clumsg.newLevel)
                                    {
                                        newSpell.push(sl);
                                    };
                                };
                                if (newSpell.length > 0)
                                {
                                    newSpell.sortOn("minPlayerLevel", Array.NUMERIC);
                                    selectedSpell = (newSpell[0] as SpellLevel);
                                    returnedSpell = SpellWrapper.create(63, selectedSpell.spellId, 1, false);
                                    levelSpellObtention = selectedSpell.minPlayerLevel;
                                };
                            };
                            PlayedCharacterManager.getInstance().infos.level = clumsg.newLevel;
                            try
                            {
                                ssequencer = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
                                ssequencer.addStep(new AddGfxEntityStep(152, DofusEntities.getEntity(PlayedCharacterManager.getInstance().id).position.cellId));
                                ssequencer.start();
                            }
                            catch(e:Error)
                            {
                            };
                            SoundManager.getInstance().manager.playUISound(UISoundEnum.LEVEL_UP);
                            KernelEventsManager.getInstance().processCallback(HookList.CharacterLevelUp, clumsg.newLevel, spellPointEarned, caracPointEarned, healPointEarned, returnedSpell, spellObtained, levelSpellObtention);
                            break;
                        case CharacterLevelUpInformationMessage.protocolId:
                            cluimsg = (msg as CharacterLevelUpInformationMessage);
                            onSameMap = false;
                            try
                            {
                                for each (entityId in this.roleplayContextFrame.entitiesFrame.getEntitiesIdsList())
                                {
                                    if (entityId == cluimsg.id)
                                    {
                                        onSameMap = true;
                                    };
                                };
                                if (onSameMap)
                                {
                                    ss = new SerialSequencer();
                                    ss.addStep(new AddGfxEntityStep(152, DofusEntities.getEntity(cluimsg.id).position.cellId));
                                    ss.start();
                                };
                            }
                            catch(e:Error)
                            {
                                _log.warn(("Un problème est survenu lors du traitement du message CharacterLevelUpInformationMessage. " + "Un personnage vient de changer de niveau mais on n'est surement pas encore sur la map"));
                            };
                            displayTextInfo = I18n.getUiText("ui.common.characterLevelUp", [(((("{player," + cluimsg.name) + ",") + cluimsg.id) + "}"), cluimsg.newLevel]);
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, displayTextInfo, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                            break;
                    };
                    return (true);
                case (msg is CharacterExperienceGainMessage):
                    cegmsg = (msg as CharacterExperienceGainMessage);
                    if (cegmsg.experienceCharacter > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mine", [StringUtils.formateIntToString(cegmsg.experienceCharacter)]), "n", (cegmsg.experienceCharacter == 1)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (cegmsg.experienceIncarnation > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.incarnation", [StringUtils.formateIntToString(cegmsg.experienceIncarnation)]), "n", (cegmsg.experienceIncarnation == 1)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (cegmsg.experienceGuild > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.guild", [StringUtils.formateIntToString(cegmsg.experienceGuild)]), "n", (cegmsg.experienceGuild == 1)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (cegmsg.experienceMount > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mount", [StringUtils.formateIntToString(cegmsg.experienceMount)]), "n", (cegmsg.experienceMount == 1)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is GameRolePlayPlayerLifeStatusMessage):
                    grplsmsg = (msg as GameRolePlayPlayerLifeStatusMessage);
                    PlayedCharacterManager.getInstance().state = grplsmsg.state;
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus, grplsmsg.state, 0);
                    KernelEventsManager.getInstance().processCallback(HookList.PhoenixUpdate);
                    return (true);
                case (msg is GameRolePlayGameOverMessage):
                    grpgomsg = (msg as GameRolePlayGameOverMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus, 2, 1);
                    return (true);
                case (msg is AlmanachCalendarDateMessage):
                    acdmsg = (msg as AlmanachCalendarDateMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.CalendarDate, acdmsg.date);
                    return (true);
                case (msg is SetUpdateMessage):
                    sumsg = (msg as SetUpdateMessage);
                    this.setList[sumsg.setId] = new PlayerSetInfo(sumsg.setId, sumsg.setObjects, sumsg.setEffects);
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.SetUpdate, sumsg.setId);
                    return (true);
                case (msg is CompassResetMessage):
                    crmsg = (msg as CompassResetMessage);
                    name = ("flag_srv" + crmsg.type);
                    switch (crmsg.type)
                    {
                        case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                            socialFrame = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame);
                            socialFrame.spouse.followSpouse = false;
                            KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, false);
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_PARTY:
                            if (PlayedCharacterManager.getInstance().followingPlayerId == -1)
                            {
                                return (true);
                            };
                            name = (name + ("_" + PlayedCharacterManager.getInstance().followingPlayerId));
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, name, PlayedCharacterManager.getInstance().currentWorldMap.id);
                    return (true);
                case (msg is CompassUpdatePartyMemberMessage):
                case (msg is CompassUpdatePvpSeekMessage):
                case (msg is CompassUpdateMessage):
                    cumsg = (msg as CompassUpdateMessage);
                    name = ("flag_srv" + cumsg.type);
                    switch (cumsg.type)
                    {
                        case CompassTypeEnum.COMPASS_TYPE_PARTY:
                            memberId = CompassUpdatePartyMemberMessage(msg).memberId;
                            pmFrame = (Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame);
                            if (pmFrame)
                            {
                                memberInfo = pmFrame.getGroupMemberById(memberId);
                                if (memberInfo)
                                {
                                    legend = (((((I18n.getUiText("ui.cartography.positionof", [memberInfo.name]) + " (") + cumsg.coords.worldX) + ",") + cumsg.coords.worldY) + ")");
                                };
                                name = (name + ("_" + memberId));
                            };
                            color = 39423;
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_PVP_SEEK:
                            legend = (((((I18n.getUiText("ui.cartography.positionof", [CompassUpdatePvpSeekMessage(msg).memberName]) + " (") + CompassUpdatePvpSeekMessage(msg).coords.worldX) + ",") + CompassUpdatePvpSeekMessage(msg).coords.worldY) + ")");
                            color = 0xFF0000;
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_QUEST:
                            legend = ((cumsg.coords.worldX + ",") + cumsg.coords.worldY);
                            color = 0x558800;
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_SIMPLE:
                            legend = ((cumsg.coords.worldX + ",") + cumsg.coords.worldY);
                            color = 0xFFEE00;
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                            color = 16724889;
                            socialFrame2 = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame);
                            socialFrame2.spouse.followSpouse = true;
                            legend = (((((I18n.getUiText("ui.cartography.positionof", [socialFrame2.spouse.name]) + " (") + cumsg.coords.worldX) + ",") + cumsg.coords.worldY) + ")");
                            KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, true);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, name, legend, PlayedCharacterManager.getInstance().currentWorldMap.id, cumsg.coords.worldX, cumsg.coords.worldY, color, false);
                    return (true);
                case (msg is BasicTimeMessage):
                    btmsg = (msg as BasicTimeMessage);
                    date = new Date();
                    receptionDelay = (getTimer() - btmsg.receptionTime);
                    TimeManager.getInstance().serverTimeLag = (((btmsg.timestamp + ((btmsg.timezoneOffset * 60) * 1000)) - date.getTime()) + receptionDelay);
                    TimeManager.getInstance().serverUtcTimeLag = ((btmsg.timestamp - date.getTime()) + receptionDelay);
                    return (true);
            };
            return (false);
        }

        public function updateCharacterStatsList(cslmsg:CharacterStatsListMessage):void
        {
            var iSM:int;
            var spellIdToRefresh:int;
            var swsToUpdate:Array;
            var swToUpdate:SpellWrapper;
            var lastCharacteristics:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
            if (((lastCharacteristics) && ((lastCharacteristics.energyPoints > cslmsg.stats.energyPoints))))
            {
                KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerIsDead);
            };
            if (cslmsg.stats.kamas != InventoryManager.getInstance().inventory.kamas)
            {
                InventoryManager.getInstance().inventory.kamas = cslmsg.stats.kamas;
            };
            var oldSM:Vector.<CharacterSpellModification> = ((lastCharacteristics) ? (PlayedCharacterManager.getInstance().characteristics.spellModifications) : null);
            var newSM:Vector.<CharacterSpellModification> = cslmsg.stats.spellModifications;
            var lengthSM:int = ((oldSM) ? Math.max(oldSM.length, newSM.length) : newSM.length);
            var idSpellsToRefresh:Array = new Array();
            if (oldSM)
            {
                iSM = 0;
                while (iSM < lengthSM)
                {
                    if (oldSM.length <= iSM)
                    {
                        if (idSpellsToRefresh.indexOf(newSM[iSM].spellId) == -1)
                        {
                            idSpellsToRefresh.push(newSM[iSM].spellId);
                        };
                    }
                    else
                    {
                        if (newSM.length <= iSM)
                        {
                            if (idSpellsToRefresh.indexOf(oldSM[iSM].spellId) == -1)
                            {
                                idSpellsToRefresh.push(oldSM[iSM].spellId);
                            };
                        }
                        else
                        {
                            if (oldSM[iSM] != newSM[iSM])
                            {
                                if (idSpellsToRefresh.indexOf(newSM[iSM].spellId) == -1)
                                {
                                    idSpellsToRefresh.push(newSM[iSM].spellId);
                                };
                                if (idSpellsToRefresh.indexOf(oldSM[iSM].spellId) == -1)
                                {
                                    idSpellsToRefresh.push(oldSM[iSM].spellId);
                                };
                            };
                        };
                    };
                    iSM++;
                };
            }
            else
            {
                iSM = 0;
                while (iSM < lengthSM)
                {
                    idSpellsToRefresh.push(newSM[iSM].spellId);
                    iSM++;
                };
            };
            PlayedCharacterManager.getInstance().characteristics = cslmsg.stats;
            for each (spellIdToRefresh in idSpellsToRefresh)
            {
                swsToUpdate = SpellWrapper.getSpellWrappersById(spellIdToRefresh, PlayedCharacterManager.getInstance().id);
                for each (swToUpdate in swsToUpdate)
                {
                    if (swToUpdate)
                    {
                        swToUpdate = SpellWrapper.create(swToUpdate.position, swToUpdate.spellId, swToUpdate.spellLevel, true, PlayedCharacterManager.getInstance().id);
                        swToUpdate.versionNum++;
                    };
                };
            };
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                if (CurrentPlayedFighterManager.getInstance().isRealPlayer())
                {
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                };
                SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            };
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function getPlayerSet(objectGID:uint):PlayerSetInfo
        {
            var playerSetInfo:PlayerSetInfo;
            var itemList:Vector.<uint>;
            var nbItem:int;
            var k:int;
            var nbSet:int = this.setList.length;
            var i:int;
            while (i < nbSet)
            {
                playerSetInfo = this.setList[i];
                if (playerSetInfo)
                {
                    itemList = playerSetInfo.setObjects;
                    nbItem = itemList.length;
                    k = 0;
                    while (k < nbItem)
                    {
                        if (itemList[k] == objectGID)
                        {
                            return (playerSetInfo);
                        };
                        k++;
                    };
                };
                i++;
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

