package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.messages.Message;
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
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionsListMessage;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionAddMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignRequestAction;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionsObjetAttributionMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignAllRequestAction;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionsAllAttributionMessage;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionFinishedMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.network.messages.game.character.stats.CharacterLevelUpInformationMessage;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemInformationWithQuantity;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.enums.StatsUpgradeResultEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
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
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   
   public class PlayedCharacterUpdatesFrame extends Object implements Frame
   {
      
      public function PlayedCharacterUpdatesFrame()
      {
         super();
      }
      
      public static var SPELL_TOOLTIP_CACHE_NUM:int = 0;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterUpdatesFrame));
      
      public var setList:Array;
      
      public var guildEmblemSymbolCategories:int;
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      public function pushed() : Boolean
      {
         this.setList = new Array();
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var name:String = null;
         var scrmsg:SetCharacterRestrictionsMessage = null;
         var rpEntitiesFrame:RoleplayEntitiesFrame = null;
         var semsg:ServerExperienceModificatorMessage = null;
         var cslmsg:CharacterStatsListMessage = null;
         var fightBattleFrame:FightBattleFrame = null;
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var grai:GameRolePlayActorInformations = null;
         var grpci:GameRolePlayCharacterInformations = null;
         var opt:* = undefined;
         var ccmsg:CharacterCapabilitiesMessage = null;
         var isla:IncreaseSpellLevelAction = null;
         var spurmsg:SpellUpgradeRequestMessage = null;
         var susmsg:SpellUpgradeSuccessMessage = null;
         var position:uint = 0;
         var updatedSW:SpellWrapper = null;
         var updated:Boolean = false;
         var previousCooldown:int = 0;
         var sfmsg:SpellForgottenMessage = null;
         var sufmsg:SpellUpgradeFailureMessage = null;
         var sura:StatsUpgradeRequestAction = null;
         var surqmsg:StatsUpgradeRequestMessage = null;
         var surmsg:StatsUpgradeResultMessage = null;
         var statUpgradeErrorText:String = null;
         var clumsg:CharacterLevelUpMessage = null;
         var messageId:uint = 0;
         var cegmsg:CharacterExperienceGainMessage = null;
         var grplsmsg:GameRolePlayPlayerLifeStatusMessage = null;
         var grpgomsg:GameRolePlayGameOverMessage = null;
         var acdmsg:AlmanachCalendarDateMessage = null;
         var sumsg:SetUpdateMessage = null;
         var crmsg:CompassResetMessage = null;
         var cumsg:CompassUpdateMessage = null;
         var legend:String = null;
         var color:uint = 0;
         var btmsg:BasicTimeMessage = null;
         var date:Date = null;
         var receptionDelay:int = 0;
         var salm:StartupActionsListMessage = null;
         var giftList:Array = null;
         var saam:StartupActionAddMessage = null;
         var items:Array = null;
         var gar:GiftAssignRequestAction = null;
         var sao:StartupActionsObjetAttributionMessage = null;
         var gaara:GiftAssignAllRequestAction = null;
         var saaamsg:StartupActionsAllAttributionMessage = null;
         var safm:StartupActionFinishedMessage = null;
         var indexToDelete:int = 0;
         var infos:GameRolePlayHumanoidInformations = null;
         var currentLook:TiphonEntityLook = null;
         var newLook:TiphonEntityLook = null;
         var sw:SpellWrapper = null;
         var oldSw:SpellWrapper = null;
         var swn:SpellWrapper = null;
         var spellPointEarned:uint = 0;
         var caracPointEarned:uint = 0;
         var healPointEarned:uint = 0;
         var newSpell:Array = null;
         var returnedSpell:SpellWrapper = null;
         var playerBreed:Breed = null;
         var spellObtained:Boolean = false;
         var levelSpellObtention:int = 0;
         var cluimsg:CharacterLevelUpInformationMessage = null;
         var onSameMap:Boolean = false;
         var displayTextInfo:String = null;
         var swBreed:Spell = null;
         var obtentionLevel:uint = 0;
         var swrapper:SpellWrapper = null;
         var pBreed:Breed = null;
         var swB:Spell = null;
         var sl:SpellLevel = null;
         var minPlayerLevel:uint = 0;
         var selectedSpell:SpellLevel = null;
         var ssequencer:SerialSequencer = null;
         var entityId:int = 0;
         var ss:SerialSequencer = null;
         var socialFrame:SocialFrame = null;
         var memberId:int = 0;
         var pmFrame:PartyManagementFrame = null;
         var socialFrame2:SocialFrame = null;
         var memberInfo:PartyMemberWrapper = null;
         var gift:StartupActionAddObject = null;
         var _items:Array = null;
         var item:ObjectItemInformationWithQuantity = null;
         var obj:Object = null;
         var iw:ItemWrapper = null;
         var itema:ObjectItemInformationWithQuantity = null;
         var giftAction:Object = null;
         var msg:Message = param1;
         switch(true)
         {
            case msg is SetCharacterRestrictionsMessage:
               scrmsg = msg as SetCharacterRestrictionsMessage;
               PlayedCharacterManager.getInstance().restrictions = scrmsg.restrictions;
               rpEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(rpEntitiesFrame)
               {
                  infos = rpEntitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayHumanoidInformations;
                  if(infos)
                  {
                     infos.humanoidInfo.restrictions = PlayedCharacterManager.getInstance().restrictions;
                  }
               }
               return true;
            case msg is ServerExperienceModificatorMessage:
               semsg = msg as ServerExperienceModificatorMessage;
               PlayedCharacterManager.getInstance().experiencePercent = semsg.experiencePercent - 100;
               return true;
            case msg is CharacterStatsListMessage:
               cslmsg = msg as CharacterStatsListMessage;
               fightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
               if(!(fightBattleFrame == null) && (fightBattleFrame.executingSequence))
               {
                  fightBattleFrame.delayCharacterStatsList(cslmsg);
               }
               else
               {
                  this.updateCharacterStatsList(cslmsg);
               }
               return true;
            case msg is MapComplementaryInformationsDataMessage:
               mcidmsg = msg as MapComplementaryInformationsDataMessage;
               for each(grai in mcidmsg.actors)
               {
                  grpci = grai as GameRolePlayCharacterInformations;
                  if((grpci) && grpci.contextualId == PlayedCharacterManager.getInstance().id)
                  {
                     currentLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
                     newLook = EntityLookAdapter.fromNetwork(grpci.look);
                     if(!currentLook.equals(newLook) && (this.roleplayContextFrame.entitiesFrame))
                     {
                        this.roleplayContextFrame.entitiesFrame.dispatchPlayerNewLook = true;
                     }
                     PlayedCharacterManager.getInstance().infos.entityLook = grpci.look;
                     for each(opt in grpci.humanoidInfo.options)
                     {
                        if(opt is HumanOptionAlliance)
                        {
                           PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = (opt as HumanOptionAlliance).aggressable;
                           KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange,(opt as HumanOptionAlliance).aggressable,PlayedCharacterManager.getInstance().characteristics.probationTime);
                           return false;
                        }
                     }
                     break;
                  }
               }
               return false;
            case msg is CharacterCapabilitiesMessage:
               ccmsg = msg as CharacterCapabilitiesMessage;
               this.guildEmblemSymbolCategories = ccmsg.guildEmblemSymbolCategories;
               return true;
            case msg is IncreaseSpellLevelAction:
               isla = msg as IncreaseSpellLevelAction;
               spurmsg = new SpellUpgradeRequestMessage();
               spurmsg.initSpellUpgradeRequestMessage(isla.spellId,isla.spellLevel);
               ConnectionsHandler.getConnection().send(spurmsg);
               return true;
            case msg is SpellUpgradeSuccessMessage:
               if(!PlayedCharacterManager.getInstance().spellsInventory)
               {
                  return true;
               }
               susmsg = msg as SpellUpgradeSuccessMessage;
               position = 63;
               updated = false;
               previousCooldown = 0;
               for each(sw in PlayedCharacterManager.getInstance().spellsInventory)
               {
                  if(sw.id == susmsg.spellId)
                  {
                     oldSw = SpellWrapper.getFirstSpellWrapperById(sw.id,sw.playerId);
                     if(oldSw)
                     {
                        previousCooldown = oldSw.actualCooldown;
                     }
                     updatedSW = SpellWrapper.create(sw.position,sw.id,susmsg.spellLevel,true,sw.playerId);
                     position = sw.position;
                     break;
                  }
               }
               if(updatedSW == null)
               {
                  swn = SpellWrapper.create(63,susmsg.spellId,susmsg.spellLevel,true,PlayedCharacterManager.getInstance().id);
                  PlayedCharacterManager.getInstance().spellsInventory.push(swn);
                  KernelEventsManager.getInstance().processCallback(HookList.SpellList,PlayedCharacterManager.getInstance().spellsInventory);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.SpellUpgradeSuccess,updatedSW);
                  updatedSW.actualCooldown = previousCooldown;
               }
               return true;
            case msg is SpellForgottenMessage:
               sfmsg = msg as SpellForgottenMessage;
               KernelEventsManager.getInstance().processCallback(HookList.SpellForgotten,sfmsg.boostPoint,sfmsg.spellsId);
               return true;
            case msg is SpellUpgradeFailureMessage:
               sufmsg = msg as SpellUpgradeFailureMessage;
               KernelEventsManager.getInstance().processCallback(HookList.SpellUpgradeFail);
               return true;
            case msg is StatsUpgradeRequestAction:
               sura = msg as StatsUpgradeRequestAction;
               surqmsg = new StatsUpgradeRequestMessage();
               surqmsg.initStatsUpgradeRequestMessage(sura.useAdditionnal,sura.statId,sura.boostPoint);
               ConnectionsHandler.getConnection().send(surqmsg);
               return true;
            case msg is StatsUpgradeResultMessage:
               surmsg = msg as StatsUpgradeResultMessage;
               switch(surmsg.result)
               {
                  case StatsUpgradeResultEnum.SUCCESS:
                     KernelEventsManager.getInstance().processCallback(HookList.StatsUpgradeResult,surmsg.nbCharacBoost);
                     break;
                  case StatsUpgradeResultEnum.NONE:
                     statUpgradeErrorText = I18n.getUiText("ui.popup.statboostFailed.text");
                     break;
                  case StatsUpgradeResultEnum.GUEST:
                     statUpgradeErrorText = I18n.getUiText("ui.fight.guestAccount");
                     break;
                  case StatsUpgradeResultEnum.RESTRICTED:
                     statUpgradeErrorText = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                     break;
                  case StatsUpgradeResultEnum.IN_FIGHT:
                     statUpgradeErrorText = I18n.getUiText("ui.error.cantDoInFight");
                     break;
                  case StatsUpgradeResultEnum.NOT_ENOUGH_POINT:
                     statUpgradeErrorText = I18n.getUiText("ui.popup.statboostFailed.notEnoughPoint");
                     break;
               }
               if(statUpgradeErrorText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,statUpgradeErrorText,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is CharacterLevelUpMessage:
               clumsg = msg as CharacterLevelUpMessage;
               messageId = clumsg.getMessageId();
               switch(messageId)
               {
                  case CharacterLevelUpMessage.protocolId:
                     spellPointEarned = clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level;
                     caracPointEarned = (clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level) * 5;
                     healPointEarned = (clumsg.newLevel - PlayedCharacterManager.getInstance().infos.level) * 5;
                     newSpell = new Array();
                     playerBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                     for each(swBreed in playerBreed.breedSpells)
                     {
                        obtentionLevel = swBreed.getSpellLevel(1).minPlayerLevel;
                        if(obtentionLevel <= clumsg.newLevel && obtentionLevel > PlayedCharacterManager.getInstance().infos.level)
                        {
                           swrapper = SpellWrapper.create(63,swBreed.id,1,false);
                           newSpell.push(swrapper);
                        }
                     }
                     spellObtained = true;
                     levelSpellObtention = -1;
                     if(newSpell.length)
                     {
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerNewSpell);
                        returnedSpell = newSpell[0] as SpellWrapper;
                     }
                     else
                     {
                        spellObtained = false;
                        pBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                        for each(swB in pBreed.breedSpells)
                        {
                           sl = swB.getSpellLevel(1);
                           minPlayerLevel = sl.minPlayerLevel;
                           if(minPlayerLevel > clumsg.newLevel)
                           {
                              newSpell.push(sl);
                           }
                        }
                        if(newSpell.length > 0)
                        {
                           newSpell.sortOn("minPlayerLevel",Array.NUMERIC);
                           selectedSpell = newSpell[0] as SpellLevel;
                           returnedSpell = SpellWrapper.create(63,selectedSpell.spellId,1,false);
                           levelSpellObtention = selectedSpell.minPlayerLevel;
                        }
                     }
                     PlayedCharacterManager.getInstance().infos.level = clumsg.newLevel;
                     try
                     {
                        ssequencer = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
                        ssequencer.addStep(new AddGfxEntityStep(152,DofusEntities.getEntity(PlayedCharacterManager.getInstance().id).position.cellId));
                        ssequencer.start();
                     }
                     catch(e:Error)
                     {
                     }
                     SoundManager.getInstance().manager.playUISound(UISoundEnum.LEVEL_UP);
                     KernelEventsManager.getInstance().processCallback(HookList.CharacterLevelUp,clumsg.newLevel,spellPointEarned,caracPointEarned,healPointEarned,returnedSpell,spellObtained,levelSpellObtention);
                     break;
                  case CharacterLevelUpInformationMessage.protocolId:
                     cluimsg = msg as CharacterLevelUpInformationMessage;
                     onSameMap = false;
                     try
                     {
                        for each(entityId in this.roleplayContextFrame.entitiesFrame.getEntitiesIdsList())
                        {
                           if(entityId == cluimsg.id)
                           {
                              onSameMap = true;
                           }
                        }
                        if(onSameMap)
                        {
                           ss = new SerialSequencer();
                           ss.addStep(new AddGfxEntityStep(152,DofusEntities.getEntity(cluimsg.id).position.cellId));
                           ss.start();
                        }
                     }
                     catch(e:Error)
                     {
                        _log.warn("Un problème est survenu lors du traitement du message CharacterLevelUpInformationMessage. " + "Un personnage vient de changer de niveau mais on n\'est surement pas encore sur la map");
                     }
                     displayTextInfo = I18n.getUiText("ui.common.characterLevelUp",["{player," + cluimsg.name + "," + cluimsg.id + "}",cluimsg.newLevel]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,displayTextInfo,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                     break;
               }
               return true;
            case msg is CharacterExperienceGainMessage:
               cegmsg = msg as CharacterExperienceGainMessage;
               if(cegmsg.experienceCharacter > 0)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mine",[StringUtils.formateIntToString(cegmsg.experienceCharacter)]),"n",cegmsg.experienceCharacter == 1),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(cegmsg.experienceIncarnation > 0)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.incarnation",[StringUtils.formateIntToString(cegmsg.experienceIncarnation)]),"n",cegmsg.experienceIncarnation == 1),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(cegmsg.experienceGuild > 0)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.guild",[StringUtils.formateIntToString(cegmsg.experienceGuild)]),"n",cegmsg.experienceGuild == 1),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(cegmsg.experienceMount > 0)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mount",[StringUtils.formateIntToString(cegmsg.experienceMount)]),"n",cegmsg.experienceMount == 1),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is GameRolePlayPlayerLifeStatusMessage:
               grplsmsg = msg as GameRolePlayPlayerLifeStatusMessage;
               PlayedCharacterManager.getInstance().state = grplsmsg.state;
               KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus,grplsmsg.state,0);
               KernelEventsManager.getInstance().processCallback(HookList.PhoenixUpdate);
               return true;
            case msg is GameRolePlayGameOverMessage:
               grpgomsg = msg as GameRolePlayGameOverMessage;
               KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus,2,1);
               return true;
            case msg is AlmanachCalendarDateMessage:
               acdmsg = msg as AlmanachCalendarDateMessage;
               KernelEventsManager.getInstance().processCallback(HookList.CalendarDate,acdmsg.date);
               return true;
            case msg is SetUpdateMessage:
               sumsg = msg as SetUpdateMessage;
               this.setList[sumsg.setId] = new PlayerSetInfo(sumsg.setId,sumsg.setObjects,sumsg.setEffects);
               KernelEventsManager.getInstance().processCallback(InventoryHookList.SetUpdate,sumsg.setId);
               return true;
            case msg is CompassResetMessage:
               crmsg = msg as CompassResetMessage;
               name = "flag_srv" + crmsg.type;
               switch(crmsg.type)
               {
                  case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                     socialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
                     socialFrame.spouse.followSpouse = false;
                     KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated,false);
                     break;
                  case CompassTypeEnum.COMPASS_TYPE_PARTY:
                     if(PlayedCharacterManager.getInstance().followingPlayerId == -1)
                     {
                        return true;
                     }
                     name = name + ("_" + PlayedCharacterManager.getInstance().followingPlayerId);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,name,PlayedCharacterManager.getInstance().currentWorldMap.id);
               return true;
            case msg is CompassUpdatePartyMemberMessage:
            case msg is CompassUpdatePvpSeekMessage:
            case msg is CompassUpdateMessage:
               cumsg = msg as CompassUpdateMessage;
               name = "flag_srv" + cumsg.type;
               switch(cumsg.type)
               {
                  case CompassTypeEnum.COMPASS_TYPE_PARTY:
                     memberId = CompassUpdatePartyMemberMessage(msg).memberId;
                     pmFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
                     if(pmFrame)
                     {
                        memberInfo = pmFrame.getGroupMemberById(memberId);
                        if(memberInfo)
                        {
                           legend = I18n.getUiText("ui.cartography.positionof",[memberInfo.name]) + " (" + cumsg.coords.worldX + "," + cumsg.coords.worldY + ")";
                        }
                        name = name + ("_" + memberId);
                     }
                     color = 39423;
                     break;
                  case CompassTypeEnum.COMPASS_TYPE_PVP_SEEK:
                     legend = I18n.getUiText("ui.cartography.positionof",[CompassUpdatePvpSeekMessage(msg).memberName]) + " (" + CompassUpdatePvpSeekMessage(msg).coords.worldX + "," + CompassUpdatePvpSeekMessage(msg).coords.worldY + ")";
                     color = 16711680;
                     break;
                  case CompassTypeEnum.COMPASS_TYPE_QUEST:
                     legend = cumsg.coords.worldX + "," + cumsg.coords.worldY;
                     color = 5605376;
                     break;
                  case CompassTypeEnum.COMPASS_TYPE_SIMPLE:
                     legend = cumsg.coords.worldX + "," + cumsg.coords.worldY;
                     color = 16772608;
                     break;
                  case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                     color = 16724889;
                     socialFrame2 = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
                     socialFrame2.spouse.followSpouse = true;
                     legend = I18n.getUiText("ui.cartography.positionof",[socialFrame2.spouse.name]) + " (" + cumsg.coords.worldX + "," + cumsg.coords.worldY + ")";
                     KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated,true);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,name,legend,PlayedCharacterManager.getInstance().currentWorldMap.id,cumsg.coords.worldX,cumsg.coords.worldY,color,false);
               return true;
            case msg is BasicTimeMessage:
               btmsg = msg as BasicTimeMessage;
               date = new Date();
               receptionDelay = getTimer() - btmsg.receptionTime;
               TimeManager.getInstance().serverTimeLag = btmsg.timestamp + btmsg.timezoneOffset * 60 * 1000 - date.getTime() + receptionDelay;
               TimeManager.getInstance().serverUtcTimeLag = btmsg.timestamp - date.getTime() + receptionDelay;
               return true;
            case msg is StartupActionsListMessage:
               salm = msg as StartupActionsListMessage;
               giftList = new Array();
               for each(gift in salm.actions)
               {
                  _items = new Array();
                  for each(item in gift.items)
                  {
                     iw = ItemWrapper.create(0,0,item.objectGID,item.quantity,item.effects,false);
                     _items.push(iw);
                  }
                  obj = {
                     "uid":gift.uid,
                     "title":gift.title,
                     "text":gift.text,
                     "items":_items
                  };
                  giftList.push(obj);
               }
               PlayedCharacterManager.getInstance().waitingGifts = giftList;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.GiftsWaitingAllocation,giftList.length > 0);
               return true;
            case msg is StartupActionAddMessage:
               saam = msg as StartupActionAddMessage;
               items = new Array();
               for each(itema in saam.newAction.items)
               {
                  iw = ItemWrapper.create(0,0,itema.objectGID,itema.quantity,itema.effects,false);
                  items.push(iw);
               }
               obj = {
                  "uid":saam.newAction.uid,
                  "title":saam.newAction.title,
                  "text":saam.newAction.text,
                  "items":items
               };
               PlayedCharacterManager.getInstance().waitingGifts.push(obj);
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.GiftsWaitingAllocation,true);
               return true;
            case msg is GiftAssignRequestAction:
               gar = msg as GiftAssignRequestAction;
               sao = new StartupActionsObjetAttributionMessage();
               sao.initStartupActionsObjetAttributionMessage(gar.giftId,gar.characterId);
               ConnectionsHandler.getConnection().send(sao);
               return true;
            case msg is GiftAssignAllRequestAction:
               gaara = msg as GiftAssignAllRequestAction;
               saaamsg = new StartupActionsAllAttributionMessage();
               saaamsg.initStartupActionsAllAttributionMessage(gaara.characterId);
               ConnectionsHandler.getConnection().send(saaamsg);
               return true;
            case msg is StartupActionFinishedMessage:
               safm = msg as StartupActionFinishedMessage;
               indexToDelete = -1;
               for each(giftAction in PlayedCharacterManager.getInstance().waitingGifts)
               {
                  if(giftAction.uid == safm.actionId)
                  {
                     indexToDelete = PlayedCharacterManager.getInstance().waitingGifts.indexOf(giftAction);
                     break;
                  }
               }
               if(indexToDelete > -1)
               {
                  PlayedCharacterManager.getInstance().waitingGifts.splice(indexToDelete,1);
                  KernelEventsManager.getInstance().processCallback(HookList.GiftAssigned,safm.actionId);
                  if(PlayedCharacterManager.getInstance().waitingGifts.length == 0)
                  {
                     KernelEventsManager.getInstance().processCallback(RoleplayHookList.GiftsWaitingAllocation,false);
                  }
               }
               return true;
            default:
               return false;
         }
      }
      
      public function updateCharacterStatsList(param1:CharacterStatsListMessage) : void
      {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:Array = null;
         var _loc10_:SpellWrapper = null;
         var _loc2_:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
         if((_loc2_) && _loc2_.energyPoints > param1.stats.energyPoints)
         {
            KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerIsDead);
         }
         if(param1.stats.kamas != InventoryManager.getInstance().inventory.kamas)
         {
            InventoryManager.getInstance().inventory.kamas = param1.stats.kamas;
         }
         var _loc3_:Vector.<CharacterSpellModification> = _loc2_?PlayedCharacterManager.getInstance().characteristics.spellModifications:null;
         var _loc4_:Vector.<CharacterSpellModification> = param1.stats.spellModifications;
         var _loc5_:int = _loc3_?Math.max(_loc3_.length,_loc4_.length):_loc4_.length;
         var _loc6_:Array = new Array();
         if(_loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               if(_loc3_.length <= _loc7_)
               {
                  if(_loc6_.indexOf(_loc4_[_loc7_].spellId) == -1)
                  {
                     _loc6_.push(_loc4_[_loc7_].spellId);
                  }
               }
               else if(_loc4_.length <= _loc7_)
               {
                  if(_loc6_.indexOf(_loc3_[_loc7_].spellId) == -1)
                  {
                     _loc6_.push(_loc3_[_loc7_].spellId);
                  }
               }
               else if(_loc3_[_loc7_] != _loc4_[_loc7_])
               {
                  if(_loc6_.indexOf(_loc4_[_loc7_].spellId) == -1)
                  {
                     _loc6_.push(_loc4_[_loc7_].spellId);
                  }
                  if(_loc6_.indexOf(_loc3_[_loc7_].spellId) == -1)
                  {
                     _loc6_.push(_loc3_[_loc7_].spellId);
                  }
               }
               
               
               _loc7_++;
            }
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc6_.push(_loc4_[_loc7_].spellId);
               _loc7_++;
            }
         }
         PlayedCharacterManager.getInstance().characteristics = param1.stats;
         for each(_loc8_ in _loc6_)
         {
            _loc9_ = SpellWrapper.getSpellWrappersById(_loc8_,PlayedCharacterManager.getInstance().id);
            for each(_loc10_ in _loc9_)
            {
               if(_loc10_)
               {
                  _loc10_ = SpellWrapper.create(_loc10_.position,_loc10_.spellId,_loc10_.spellLevel,true,PlayedCharacterManager.getInstance().id);
                  _loc10_.versionNum++;
               }
            }
         }
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            if(CurrentPlayedFighterManager.getInstance().isRealPlayer())
            {
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            }
            SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function getPlayerSet(param1:uint) : PlayerSetInfo
      {
         var _loc4_:PlayerSetInfo = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:int = this.setList.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.setList[_loc3_];
            if(_loc4_)
            {
               _loc5_ = _loc4_.setObjects;
               _loc6_ = _loc5_.length;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  if(_loc5_[_loc7_] == param1)
                  {
                     return _loc4_;
                  }
                  _loc7_++;
               }
            }
            _loc3_++;
         }
         return null;
      }
   }
}
