package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.datacenter.notifications.Notification;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.datacenter.servers.ServerPopulation;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.breeds.Head;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.userInterface.ButtonWrapper;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.internalDatacenter.jobs.JobWrapper;
   import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
   import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.SpellType;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.datacenter.communication.ChatChannel;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.IncarnationLevel;
   import com.ankamagames.dofus.types.data.GenericSlotData;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.items.ItemSet;
   import com.ankamagames.dofus.datacenter.livingObjects.Pet;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterMiniBoss;
   import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
   import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.CompanionCharacteristic;
   import com.ankamagames.dofus.datacenter.monsters.CompanionSpell;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.npcs.NpcAction;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentBalance;
   import com.ankamagames.dofus.datacenter.guild.RankName;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.datacenter.communication.InfoMessage;
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.EmblemBackground;
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbolCategory;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestCategory;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.datacenter.quest.QuestStep;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
   import com.ankamagames.dofus.datacenter.quest.AchievementReward;
   import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
   import com.ankamagames.dofus.datacenter.houses.House;
   import com.ankamagames.dofus.internalDatacenter.items.LivingObjectSkinWrapper;
   import com.ankamagames.dofus.datacenter.abuse.AbuseReasons;
   import com.ankamagames.dofus.datacenter.items.PresetIcon;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.datacenter.world.HintCategory;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.datacenter.spells.SpellPair;
   import com.ankamagames.dofus.datacenter.spells.SpellBomb;
   import com.ankamagames.dofus.datacenter.misc.Pack;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.appearance.TitleCategory;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.misc.OptionalFeature;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxEvent;
   import com.ankamagames.dofus.logic.game.common.managers.AlmanaxManager;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxZodiac;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxMonth;
   import com.ankamagames.dofus.datacenter.almanax.AlmanaxCalendar;
   import com.ankamagames.dofus.datacenter.externalnotifications.ExternalNotification;
   import com.ankamagames.dofus.datacenter.misc.ActionDescription;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DataApi extends Object implements IApi
   {
      
      public function DataApi() {
         this._log = Log.getLogger(getQualifiedClassName(DataApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      private function get entitiesFrame() : RoleplayEntitiesFrame {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getNotifications() : Array {
         return Notification.getNotifications();
      }
      
      public function getServer(id:int) : Server {
         return Server.getServerById(id);
      }
      
      public function getServerPopulation(id:int) : ServerPopulation {
         return ServerPopulation.getServerPopulationById(id);
      }
      
      public function getBreed(id:int) : Breed {
         return Breed.getBreedById(id);
      }
      
      public function getBreeds() : Array {
         return Breed.getBreeds();
      }
      
      public function getHead(id:int) : Head {
         return Head.getHeadById(id);
      }
      
      public function getHeads() : Array {
         return Head.getHeads();
      }
      
      public function getSpell(id:int) : Spell {
         return Spell.getSpellById(id);
      }
      
      public function getSpells() : Array {
         return Spell.getSpells();
      }
      
      public function getSpellWrapper(id:uint, level:uint=1) : SpellWrapper {
         var sw:SpellWrapper = SpellWrapper.create(-1,id,level,false);
         return sw;
      }
      
      public function getEmoteWrapper(id:uint, position:uint=0) : EmoteWrapper {
         return EmoteWrapper.create(id,position);
      }
      
      public function getButtonWrapper(buttonId:uint, position:int, uriName:String, callback:Function, name:String, shortcut:String="") : ButtonWrapper {
         return ButtonWrapper.create(buttonId,position,uriName,callback,name,shortcut);
      }
      
      public function getJobs() : Array {
         return Job.getJobs();
      }
      
      public function getJobWrapper(id:uint) : JobWrapper {
         return JobWrapper.create(id);
      }
      
      public function getTitleWrapper(id:uint) : TitleWrapper {
         return TitleWrapper.create(id);
      }
      
      public function getOrnamentWrapper(id:uint) : OrnamentWrapper {
         return OrnamentWrapper.create(id);
      }
      
      public function getSpellLevel(id:int) : SpellLevel {
         return SpellLevel.getLevelById(id);
      }
      
      public function getSpellLevelBySpell(spell:Spell, level:int) : SpellLevel {
         return spell.getSpellLevel(level);
      }
      
      public function getSpellType(id:int) : SpellType {
         return SpellType.getSpellTypeById(id);
      }
      
      public function getSpellState(id:int) : SpellState {
         return SpellState.getSpellStateById(id);
      }
      
      public function getChatChannel(id:int) : ChatChannel {
         return ChatChannel.getChannelById(id);
      }
      
      public function getAllChatChannels() : Array {
         return ChatChannel.getChannels();
      }
      
      public function getSubArea(id:int) : SubArea {
         return SubArea.getSubAreaById(id);
      }
      
      public function getSubAreaFromMap(mapId:int) : SubArea {
         return SubArea.getSubAreaByMapId(mapId);
      }
      
      public function getAllSubAreas() : Array {
         return SubArea.getAllSubArea();
      }
      
      public function getArea(id:int) : Area {
         return Area.getAreaById(id);
      }
      
      public function getSuperArea(id:int) : SuperArea {
         return SuperArea.getSuperAreaById(id);
      }
      
      public function getAllArea(withHouses:Boolean=false, withPaddocks:Boolean=false) : Array {
         var area:Area = null;
         var results:Array = new Array();
         for each (area in Area.getAllArea())
         {
            if((withHouses) && (area.containHouses) || (withPaddocks) && (area.containPaddocks) || (!withHouses) && (!withPaddocks))
            {
               results.push(area);
            }
         }
         return results;
      }
      
      public function getWorldPoint(id:int) : WorldPoint {
         return WorldPoint.fromMapId(id);
      }
      
      public function getItem(id:int, returnDefaultItemIfNull:Boolean=true) : Item {
         return Item.getItemById(id,returnDefaultItemIfNull);
      }
      
      public function getItems() : Array {
         return Item.getItems();
      }
      
      public function getIncarnationLevel(incarnationId:int, level:int) : IncarnationLevel {
         return IncarnationLevel.getIncarnationLevelByIdAndLevel(incarnationId,level);
      }
      
      public function getNewGenericSlotData() : GenericSlotData {
         return new GenericSlotData();
      }
      
      public function getItemIconUri(iconId:uint) : Uri {
         return new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(iconId).concat(".png"));
      }
      
      public function getItemName(id:int) : String {
         var i:Item = Item.getItemById(id);
         if(i)
         {
            return i.name;
         }
         return null;
      }
      
      public function getItemType(id:int) : String {
         var it:ItemType = ItemType.getItemTypeById(id);
         if(it)
         {
            return it.name;
         }
         return null;
      }
      
      public function getItemSet(id:int) : ItemSet {
         return ItemSet.getItemSetById(id);
      }
      
      public function getPet(id:int) : Pet {
         return Pet.getPetById(id);
      }
      
      public function getSetEffects(GIDList:Array, setBonus:Array=null) : Array {
         var item:* = undefined;
         var GID:* = undefined;
         var GIDe:* = undefined;
         var line:* = undefined;
         var lineNA:* = undefined;
         var iGID:* = undefined;
         var effect:* = undefined;
         var effectEquip:* = undefined;
         var setBonusLine:* = undefined;
         var effectsDice:Dictionary = new Dictionary();
         var effects:Array = new Array();
         var effectsNonAddable:Array = new Array();
         var GIDEquippedList:Array = new Array();
         for each (item in PlayedCharacterManager.getInstance().inventory)
         {
            if(item.position <= 15)
            {
               for (iGID in GIDList)
               {
                  if(item.objectGID == GIDList[iGID])
                  {
                     GIDEquippedList.push(item);
                     GIDList[iGID] = -1;
                  }
               }
            }
         }
         for each (GID in GIDList)
         {
            if(GID != -1)
            {
               for each (effect in Item.getItemById(GID).possibleEffects)
               {
                  if(Effect.getEffectById(effect.effectId).useDice)
                  {
                     if(effectsDice[effect.effectId])
                     {
                        effectsDice[effect.effectId].add(effect);
                     }
                     else
                     {
                        effectsDice[effect.effectId] = effect.clone();
                     }
                  }
                  else
                  {
                     effectsNonAddable.push(effect.clone());
                  }
               }
            }
         }
         for each (GIDe in GIDEquippedList)
         {
            for each (effectEquip in GIDe.effects)
            {
               if(Effect.getEffectById(effectEquip.effectId).useDice)
               {
                  if(effectsDice[effectEquip.effectId])
                  {
                     effectsDice[effectEquip.effectId].add(effectEquip);
                  }
                  else
                  {
                     effectsDice[effectEquip.effectId] = effectEquip.clone();
                  }
               }
               else
               {
                  effectsNonAddable.push(effectEquip.clone());
               }
            }
         }
         if((setBonus) && (setBonus.length))
         {
            for each (setBonusLine in setBonus)
            {
               if(setBonusLine is String)
               {
                  this._log.debug("Bonus en texte, on ne peut pas l\'ajouter");
               }
               else
               {
                  if((Effect.getEffectById(setBonusLine.effectId)) && (Effect.getEffectById(setBonusLine.effectId).useDice))
                  {
                     if(effectsDice[setBonusLine.effectId])
                     {
                        effectsDice[setBonusLine.effectId].add(SecureCenter.unsecure(setBonusLine));
                     }
                     else
                     {
                        effectsDice[setBonusLine.effectId] = SecureCenter.unsecure(setBonusLine).clone();
                     }
                  }
                  else
                  {
                     effectsNonAddable.push(SecureCenter.unsecure(setBonusLine).clone());
                  }
               }
            }
         }
         for each (line in effectsDice)
         {
            if(line.showInSet > 0)
            {
               effects.push(line);
            }
         }
         for each (lineNA in effectsNonAddable)
         {
            if(lineNA.showInSet > 0)
            {
               effects.push(lineNA);
            }
         }
         effects.sortOn("category",Array.NUMERIC);
         return effects;
      }
      
      public function getMonsterFromId(monsterId:uint) : Monster {
         return Monster.getMonsterById(monsterId);
      }
      
      public function getMonsters() : Array {
         return Monster.getMonsters();
      }
      
      public function getMonsterMiniBossFromId(monsterId:uint) : MonsterMiniBoss {
         return MonsterMiniBoss.getMonsterById(monsterId);
      }
      
      public function getMonsterRaceFromId(raceId:uint) : MonsterRace {
         return MonsterRace.getMonsterRaceById(raceId);
      }
      
      public function getMonsterRaces() : Array {
         return MonsterRace.getMonsterRaces();
      }
      
      public function getMonsterSuperRaceFromId(raceId:uint) : MonsterSuperRace {
         return MonsterSuperRace.getMonsterSuperRaceById(raceId);
      }
      
      public function getMonsterSuperRaces() : Array {
         return MonsterSuperRace.getMonsterSuperRaces();
      }
      
      public function getCompanion(companionId:uint) : Companion {
         return Companion.getCompanionById(companionId);
      }
      
      public function getAllCompanions() : Array {
         return Companion.getCompanions();
      }
      
      public function getCompanionCharacteristic(companionCharacteristicId:uint) : CompanionCharacteristic {
         return CompanionCharacteristic.getCompanionCharacteristicById(companionCharacteristicId);
      }
      
      public function getCompanionSpell(companionSpellId:uint) : CompanionSpell {
         return CompanionSpell.getCompanionSpellById(companionSpellId);
      }
      
      public function getNpc(npcId:uint) : Npc {
         return Npc.getNpcById(npcId);
      }
      
      public function getNpcAction(actionId:uint) : NpcAction {
         return NpcAction.getNpcActionById(actionId);
      }
      
      public function getAlignmentSide(sideId:uint) : AlignmentSide {
         return AlignmentSide.getAlignmentSideById(sideId);
      }
      
      public function getAlignmentBalance(percent:uint) : AlignmentBalance {
         var balance:uint = 0;
         if(percent == 0)
         {
            balance = 1;
         }
         else
         {
            if(percent == 10)
            {
               balance = 2;
            }
            else
            {
               if(percent == 20)
               {
                  balance = 3;
               }
               else
               {
                  if(percent == 30)
                  {
                     balance = 4;
                  }
                  else
                  {
                     if(percent == 40)
                     {
                        balance = 5;
                     }
                     else
                     {
                        if(percent == 50)
                        {
                           balance = 6;
                        }
                        else
                        {
                           if(percent == 60)
                           {
                              balance = 7;
                           }
                           else
                           {
                              if(percent == 70)
                              {
                                 balance = 8;
                              }
                              else
                              {
                                 if(percent == 80)
                                 {
                                    balance = 9;
                                 }
                                 else
                                 {
                                    if(percent == 90)
                                    {
                                       balance = 10;
                                    }
                                    else
                                    {
                                       balance = Math.ceil(percent / 10);
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return AlignmentBalance.getAlignmentBalanceById(balance);
      }
      
      public function getRankName(rankId:uint) : RankName {
         return RankName.getRankNameById(rankId);
      }
      
      public function getAllRankNames() : Array {
         return RankName.getRankNames();
      }
      
      public function getItemWrapper(itemGID:uint, itemPosition:int=0, itemUID:uint=0, itemQuantity:uint=0, itemEffects:*=null) : ItemWrapper {
         if(itemEffects == null)
         {
            itemEffects = new Vector.<ObjectEffect>();
         }
         return ItemWrapper.create(itemPosition,itemUID,itemGID,itemQuantity,itemEffects,false);
      }
      
      public function getItemFromUId(objectUID:uint) : ItemWrapper {
         return ItemWrapper.getItemFromUId(objectUID);
      }
      
      public function getSkill(skillId:uint) : Skill {
         return Skill.getSkillById(skillId);
      }
      
      public function getHouseSkills() : Array {
         var skill:Skill = null;
         var houseSkills:Array = new Array();
         for each (skill in Skill.getSkills())
         {
            if(skill.availableInHouse)
            {
               houseSkills.push(skill);
            }
         }
         return houseSkills;
      }
      
      public function getInfoMessage(infoMsgId:uint) : InfoMessage {
         return InfoMessage.getInfoMessageById(infoMsgId);
      }
      
      public function getAllInfoMessages() : Array {
         return InfoMessage.getInfoMessages();
      }
      
      public function getSmiliesWrapperForPlayers() : Array {
         var smiley:Smiley = null;
         var smileyW:SmileyWrapper = null;
         var chatFrame:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         if((chatFrame) && (chatFrame.smilies) && (chatFrame.smilies.length > 0))
         {
            return chatFrame.smilies;
         }
         var a:Array = new Array();
         for each (smiley in Smiley.getSmileys())
         {
            if(smiley.forPlayers)
            {
               smileyW = SmileyWrapper.create(smiley.id,smiley.gfxId,smiley.order);
               a.push(smileyW);
            }
         }
         a.sortOn("order",Array.NUMERIC);
         return a;
      }
      
      public function getSmiley(id:uint) : Smiley {
         return Smiley.getSmileyById(id);
      }
      
      public function getAllSmiley() : Array {
         return Smiley.getSmileys();
      }
      
      public function getTaxCollectorName(id:uint) : TaxCollectorName {
         return TaxCollectorName.getTaxCollectorNameById(id);
      }
      
      public function getTaxCollectorFirstname(id:uint) : TaxCollectorFirstname {
         return TaxCollectorFirstname.getTaxCollectorFirstnameById(id);
      }
      
      public function getEmblems() : Array {
         var upEmblem:EmblemSymbol = null;
         var backEmblem:EmblemBackground = null;
         var returnValue:Array = null;
         var upEmblemTotal:Array = EmblemSymbol.getEmblemSymbols();
         var backEmblemTotal:Array = EmblemBackground.getEmblemBackgrounds();
         var upEmblems:Array = new Array();
         var backEmblems:Array = new Array();
         for each (upEmblem in upEmblemTotal)
         {
            upEmblems.push(EmblemWrapper.create(upEmblem.id,EmblemWrapper.UP));
         }
         upEmblems.sortOn("order",Array.NUMERIC);
         for each (backEmblem in backEmblemTotal)
         {
            backEmblems.push(EmblemWrapper.create(backEmblem.id,EmblemWrapper.BACK));
         }
         backEmblems.sortOn("order",Array.NUMERIC);
         returnValue = new Array(upEmblems,backEmblems);
         return returnValue;
      }
      
      public function getEmblemSymbol(symbolId:int) : EmblemSymbol {
         return EmblemSymbol.getEmblemSymbolById(symbolId);
      }
      
      public function getAllEmblemSymbolCategories() : Array {
         return EmblemSymbolCategory.getEmblemSymbolCategories();
      }
      
      public function getQuest(questId:int) : Quest {
         return Quest.getQuestById(questId);
      }
      
      public function getQuestCategory(questCatId:int) : QuestCategory {
         return QuestCategory.getQuestCategoryById(questCatId);
      }
      
      public function getQuestObjective(questObjectiveId:int) : QuestObjective {
         return QuestObjective.getQuestObjectiveById(questObjectiveId);
      }
      
      public function getQuestStep(questStepId:int) : QuestStep {
         return QuestStep.getQuestStepById(questStepId);
      }
      
      public function getAchievement(achievementId:int) : Achievement {
         return Achievement.getAchievementById(achievementId);
      }
      
      public function getAchievements() : Array {
         return Achievement.getAchievements();
      }
      
      public function getAchievementCategory(achievementCatId:int) : AchievementCategory {
         return AchievementCategory.getAchievementCategoryById(achievementCatId);
      }
      
      public function getAchievementCategories() : Array {
         return AchievementCategory.getAchievementCategories();
      }
      
      public function getAchievementReward(rewardId:int) : AchievementReward {
         return AchievementReward.getAchievementRewardById(rewardId);
      }
      
      public function getAchievementRewards() : Array {
         return AchievementReward.getAchievementRewards();
      }
      
      public function getAchievementObjective(objectiveId:int) : AchievementObjective {
         return AchievementObjective.getAchievementObjectiveById(objectiveId);
      }
      
      public function getAchievementObjectives() : Array {
         return AchievementObjective.getAchievementObjectives();
      }
      
      public function getHouse(houseId:int) : House {
         return House.getGuildHouseById(houseId);
      }
      
      public function getLivingObjectSkins(item:ItemWrapper) : Array {
         if(!item.isLivingObject)
         {
            return [];
         }
         var array:Array = new Array();
         var i:int = 1;
         while(i <= item.livingObjectLevel)
         {
            array.push(LivingObjectSkinWrapper.create(item.livingObjectId?item.livingObjectId:item.id,item.livingObjectMood,i));
            i++;
         }
         return array;
      }
      
      public function getAbuseReasonName(abuseReasonId:uint) : AbuseReasons {
         return AbuseReasons.getReasonNameById(abuseReasonId);
      }
      
      public function getAllAbuseReasons() : Array {
         return AbuseReasons.getReasonNames();
      }
      
      public function getPresetIcons() : Array {
         return PresetIcon.getPresetIcons();
      }
      
      public function getPresetIcon(iconId:uint) : PresetIcon {
         return PresetIcon.getPresetIconById(iconId);
      }
      
      public function getDungeons() : Array {
         return Dungeon.getAllDungeons();
      }
      
      public function getDungeon(dungeonId:uint) : Dungeon {
         return Dungeon.getDungeonById(dungeonId);
      }
      
      public function getMapInfo(mapId:uint) : MapPosition {
         return MapPosition.getMapPositionById(mapId);
      }
      
      public function getWorldMap(mapId:uint) : WorldMap {
         return WorldMap.getWorldMapById(mapId);
      }
      
      public function getAllWorldMaps() : Array {
         return WorldMap.getAllWorldMaps();
      }
      
      public function getHintCategory(hintId:uint) : HintCategory {
         return HintCategory.getHintCategoryById(hintId);
      }
      
      public function getHintCategories() : Array {
         return HintCategory.getHintCategories();
      }
      
      public function getHousesInformations() : Dictionary {
         if(this.entitiesFrame)
         {
            return this.entitiesFrame.housesInformations;
         }
         return null;
      }
      
      public function getHouseInformations(doorId:uint) : HouseWrapper {
         if(this.entitiesFrame)
         {
            return this.entitiesFrame.housesInformations[doorId];
         }
         return null;
      }
      
      public function getSpellPair(pairId:uint) : SpellPair {
         return SpellPair.getSpellPairById(pairId);
      }
      
      public function getBomb(bombId:uint) : SpellBomb {
         return SpellBomb.getSpellBombById(bombId);
      }
      
      public function getPack(packId:uint) : Pack {
         return Pack.getPackById(packId);
      }
      
      public function getTitle(titleId:uint) : Title {
         return Title.getTitleById(titleId);
      }
      
      public function getTitles() : Array {
         return Title.getAllTitle();
      }
      
      public function getTitleCategory(titleCatId:uint) : TitleCategory {
         return TitleCategory.getTitleCategoryById(titleCatId);
      }
      
      public function getTitleCategories() : Array {
         return TitleCategory.getTitleCategories();
      }
      
      public function getOrnament(oId:uint) : Ornament {
         return Ornament.getOrnamentById(oId);
      }
      
      public function getOrnaments() : Array {
         return Ornament.getAllOrnaments();
      }
      
      public function getOptionalFeatureByKeyword(key:String) : OptionalFeature {
         return OptionalFeature.getOptionalFeatureByKeyword(key);
      }
      
      public function getEffect(effectId:uint) : Effect {
         return Effect.getEffectById(effectId);
      }
      
      public function getAlmanaxEvent() : AlmanaxEvent {
         return AlmanaxManager.getInstance().event;
      }
      
      public function getAlmanaxZodiac() : AlmanaxZodiac {
         return AlmanaxManager.getInstance().zodiac;
      }
      
      public function getAlmanaxMonth() : AlmanaxMonth {
         return AlmanaxManager.getInstance().month;
      }
      
      public function getAlmanaxCalendar(calendarId:uint) : AlmanaxCalendar {
         return AlmanaxCalendar.getAlmanaxCalendarById(calendarId);
      }
      
      public function getExternalNotification(pExtNotifId:int) : ExternalNotification {
         return ExternalNotification.getExternalNotificationById(pExtNotifId);
      }
      
      public function getExternalNotifications() : Array {
         return ExternalNotification.getExternalNotifications();
      }
      
      public function getActionDescriptionByName(name:String) : ActionDescription {
         return ActionDescription.getActionDescriptionByName(name);
      }
      
      public function queryString(dataClass:Class, field:String, pattern:String) : Vector.<uint> {
         return GameDataQuery.queryString(dataClass,field,pattern);
      }
      
      public function queryEquals(dataClass:Class, field:String, value:*) : Vector.<uint> {
         return GameDataQuery.queryEquals(dataClass,field,value);
      }
      
      public function queryUnion(... ids) : Vector.<uint> {
         return GameDataQuery.union.apply(null,ids);
      }
      
      public function queryIntersection(... ids) : Vector.<uint> {
         return GameDataQuery.intersection.apply(null,ids);
      }
      
      public function queryGreaterThan(dataClass:Class, field:String, value:*) : Vector.<uint> {
         return GameDataQuery.queryGreaterThan(dataClass,field,value);
      }
      
      public function querySmallerThan(dataClass:Class, field:String, value:*) : Vector.<uint> {
         return GameDataQuery.querySmallerThan(dataClass,field,value);
      }
      
      public function queryReturnInstance(dataClass:Class, ids:Vector.<uint>) : Vector.<Object> {
         return GameDataQuery.returnInstance(dataClass,ids);
      }
      
      public function querySort(dataClass:Class, ids:Vector.<uint>, fields:*, ascending:*=true) : Vector.<uint> {
         return GameDataQuery.sort(dataClass,ids,fields,ascending);
      }
      
      public function querySortI18nId(data:*, fields:*, ascending:*=true) : * {
         return GameDataQuery.sortI18n(data,fields,ascending);
      }
   }
}
