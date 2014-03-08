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
   import __AS3__.vec.Vector;
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
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getNotifications() : Array {
         return Notification.getNotifications();
      }
      
      public function getServer(param1:int) : Server {
         return Server.getServerById(param1);
      }
      
      public function getServerPopulation(param1:int) : ServerPopulation {
         return ServerPopulation.getServerPopulationById(param1);
      }
      
      public function getBreed(param1:int) : Breed {
         return Breed.getBreedById(param1);
      }
      
      public function getBreeds() : Array {
         return Breed.getBreeds();
      }
      
      public function getHead(param1:int) : Head {
         return Head.getHeadById(param1);
      }
      
      public function getHeads() : Array {
         return Head.getHeads();
      }
      
      public function getSpell(param1:int) : Spell {
         return Spell.getSpellById(param1);
      }
      
      public function getSpells() : Array {
         return Spell.getSpells();
      }
      
      public function getSpellWrapper(param1:uint, param2:uint=1) : SpellWrapper {
         var _loc3_:SpellWrapper = SpellWrapper.create(-1,param1,param2,false);
         return _loc3_;
      }
      
      public function getEmoteWrapper(param1:uint, param2:uint=0) : EmoteWrapper {
         return EmoteWrapper.create(param1,param2);
      }
      
      public function getButtonWrapper(param1:uint, param2:int, param3:String, param4:Function, param5:String, param6:String="") : ButtonWrapper {
         return ButtonWrapper.create(param1,param2,param3,param4,param5,param6);
      }
      
      public function getJobs() : Array {
         return Job.getJobs();
      }
      
      public function getJobWrapper(param1:uint) : JobWrapper {
         return JobWrapper.create(param1);
      }
      
      public function getTitleWrapper(param1:uint) : TitleWrapper {
         return TitleWrapper.create(param1);
      }
      
      public function getOrnamentWrapper(param1:uint) : OrnamentWrapper {
         return OrnamentWrapper.create(param1);
      }
      
      public function getSpellLevel(param1:int) : SpellLevel {
         return SpellLevel.getLevelById(param1);
      }
      
      public function getSpellLevelBySpell(param1:Spell, param2:int) : SpellLevel {
         return param1.getSpellLevel(param2);
      }
      
      public function getSpellType(param1:int) : SpellType {
         return SpellType.getSpellTypeById(param1);
      }
      
      public function getSpellState(param1:int) : SpellState {
         return SpellState.getSpellStateById(param1);
      }
      
      public function getChatChannel(param1:int) : ChatChannel {
         return ChatChannel.getChannelById(param1);
      }
      
      public function getAllChatChannels() : Array {
         return ChatChannel.getChannels();
      }
      
      public function getSubArea(param1:int) : SubArea {
         return SubArea.getSubAreaById(param1);
      }
      
      public function getSubAreaFromMap(param1:int) : SubArea {
         return SubArea.getSubAreaByMapId(param1);
      }
      
      public function getAllSubAreas() : Array {
         return SubArea.getAllSubArea();
      }
      
      public function getArea(param1:int) : Area {
         return Area.getAreaById(param1);
      }
      
      public function getSuperArea(param1:int) : SuperArea {
         return SuperArea.getSuperAreaById(param1);
      }
      
      public function getAllArea(param1:Boolean=false, param2:Boolean=false) : Array {
         var _loc4_:Area = null;
         var _loc3_:Array = new Array();
         for each (_loc4_ in Area.getAllArea())
         {
            if((param1) && (_loc4_.containHouses) || (param2) && (_loc4_.containPaddocks) || !param1 && !param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function getWorldPoint(param1:int) : WorldPoint {
         return WorldPoint.fromMapId(param1);
      }
      
      public function getItem(param1:int, param2:Boolean=true) : Item {
         return Item.getItemById(param1,param2);
      }
      
      public function getItems() : Array {
         return Item.getItems();
      }
      
      public function getIncarnationLevel(param1:int, param2:int) : IncarnationLevel {
         return IncarnationLevel.getIncarnationLevelByIdAndLevel(param1,param2);
      }
      
      public function getNewGenericSlotData() : GenericSlotData {
         return new GenericSlotData();
      }
      
      public function getItemIconUri(param1:uint) : Uri {
         return new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(param1).concat(".png"));
      }
      
      public function getItemName(param1:int) : String {
         var _loc2_:Item = Item.getItemById(param1);
         if(_loc2_)
         {
            return _loc2_.name;
         }
         return null;
      }
      
      public function getItemType(param1:int) : String {
         var _loc2_:ItemType = ItemType.getItemTypeById(param1);
         if(_loc2_)
         {
            return _loc2_.name;
         }
         return null;
      }
      
      public function getItemSet(param1:int) : ItemSet {
         return ItemSet.getItemSetById(param1);
      }
      
      public function getPet(param1:int) : Pet {
         return Pet.getPetById(param1);
      }
      
      public function getSetEffects(param1:Array, param2:Array=null) : Array {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc3_:Dictionary = new Dictionary();
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         for each (_loc7_ in PlayedCharacterManager.getInstance().inventory)
         {
            if(_loc7_.position <= 15)
            {
               for (_loc12_ in param1)
               {
                  if(_loc7_.objectGID == param1[_loc12_])
                  {
                     _loc6_.push(_loc7_);
                     param1[_loc12_] = -1;
                  }
               }
            }
         }
         for each (_loc8_ in param1)
         {
            if(_loc8_ != -1)
            {
               for each (_loc13_ in Item.getItemById(_loc8_).possibleEffects)
               {
                  if(Effect.getEffectById(_loc13_.effectId).useDice)
                  {
                     if(_loc3_[_loc13_.effectId])
                     {
                        _loc3_[_loc13_.effectId].add(_loc13_);
                     }
                     else
                     {
                        _loc3_[_loc13_.effectId] = _loc13_.clone();
                     }
                  }
                  else
                  {
                     _loc5_.push(_loc13_.clone());
                  }
               }
            }
         }
         for each (_loc9_ in _loc6_)
         {
            for each (_loc14_ in _loc9_.effects)
            {
               if(Effect.getEffectById(_loc14_.effectId).useDice)
               {
                  if(_loc3_[_loc14_.effectId])
                  {
                     _loc3_[_loc14_.effectId].add(_loc14_);
                  }
                  else
                  {
                     _loc3_[_loc14_.effectId] = _loc14_.clone();
                  }
               }
               else
               {
                  _loc5_.push(_loc14_.clone());
               }
            }
         }
         if((param2) && (param2.length))
         {
            for each (_loc15_ in param2)
            {
               if(_loc15_ is String)
               {
                  this._log.debug("Bonus en texte, on ne peut pas l\'ajouter");
               }
               else
               {
                  if((Effect.getEffectById(_loc15_.effectId)) && (Effect.getEffectById(_loc15_.effectId).useDice))
                  {
                     if(_loc3_[_loc15_.effectId])
                     {
                        _loc3_[_loc15_.effectId].add(SecureCenter.unsecure(_loc15_));
                     }
                     else
                     {
                        _loc3_[_loc15_.effectId] = SecureCenter.unsecure(_loc15_).clone();
                     }
                  }
                  else
                  {
                     _loc5_.push(SecureCenter.unsecure(_loc15_).clone());
                  }
               }
            }
         }
         for each (_loc10_ in _loc3_)
         {
            if(_loc10_.showInSet > 0)
            {
               _loc4_.push(_loc10_);
            }
         }
         for each (_loc11_ in _loc5_)
         {
            if(_loc11_.showInSet > 0)
            {
               _loc4_.push(_loc11_);
            }
         }
         _loc4_.sortOn("category",Array.NUMERIC);
         return _loc4_;
      }
      
      public function getMonsterFromId(param1:uint) : Monster {
         return Monster.getMonsterById(param1);
      }
      
      public function getMonsters() : Array {
         return Monster.getMonsters();
      }
      
      public function getMonsterMiniBossFromId(param1:uint) : MonsterMiniBoss {
         return MonsterMiniBoss.getMonsterById(param1);
      }
      
      public function getMonsterRaceFromId(param1:uint) : MonsterRace {
         return MonsterRace.getMonsterRaceById(param1);
      }
      
      public function getMonsterRaces() : Array {
         return MonsterRace.getMonsterRaces();
      }
      
      public function getMonsterSuperRaceFromId(param1:uint) : MonsterSuperRace {
         return MonsterSuperRace.getMonsterSuperRaceById(param1);
      }
      
      public function getMonsterSuperRaces() : Array {
         return MonsterSuperRace.getMonsterSuperRaces();
      }
      
      public function getCompanion(param1:uint) : Companion {
         return Companion.getCompanionById(param1);
      }
      
      public function getAllCompanions() : Array {
         return Companion.getCompanions();
      }
      
      public function getCompanionCharacteristic(param1:uint) : CompanionCharacteristic {
         return CompanionCharacteristic.getCompanionCharacteristicById(param1);
      }
      
      public function getCompanionSpell(param1:uint) : CompanionSpell {
         return CompanionSpell.getCompanionSpellById(param1);
      }
      
      public function getNpc(param1:uint) : Npc {
         return Npc.getNpcById(param1);
      }
      
      public function getNpcAction(param1:uint) : NpcAction {
         return NpcAction.getNpcActionById(param1);
      }
      
      public function getAlignmentSide(param1:uint) : AlignmentSide {
         return AlignmentSide.getAlignmentSideById(param1);
      }
      
      public function getAlignmentBalance(param1:uint) : AlignmentBalance {
         var _loc2_:uint = 0;
         if(param1 == 0)
         {
            _loc2_ = 1;
         }
         else
         {
            if(param1 == 10)
            {
               _loc2_ = 2;
            }
            else
            {
               if(param1 == 20)
               {
                  _loc2_ = 3;
               }
               else
               {
                  if(param1 == 30)
                  {
                     _loc2_ = 4;
                  }
                  else
                  {
                     if(param1 == 40)
                     {
                        _loc2_ = 5;
                     }
                     else
                     {
                        if(param1 == 50)
                        {
                           _loc2_ = 6;
                        }
                        else
                        {
                           if(param1 == 60)
                           {
                              _loc2_ = 7;
                           }
                           else
                           {
                              if(param1 == 70)
                              {
                                 _loc2_ = 8;
                              }
                              else
                              {
                                 if(param1 == 80)
                                 {
                                    _loc2_ = 9;
                                 }
                                 else
                                 {
                                    if(param1 == 90)
                                    {
                                       _loc2_ = 10;
                                    }
                                    else
                                    {
                                       _loc2_ = Math.ceil(param1 / 10);
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
         return AlignmentBalance.getAlignmentBalanceById(_loc2_);
      }
      
      public function getRankName(param1:uint) : RankName {
         return RankName.getRankNameById(param1);
      }
      
      public function getAllRankNames() : Array {
         return RankName.getRankNames();
      }
      
      public function getItemWrapper(param1:uint, param2:int=0, param3:uint=0, param4:uint=0, param5:*=null) : ItemWrapper {
         if(param5 == null)
         {
            param5 = new Vector.<ObjectEffect>();
         }
         return ItemWrapper.create(param2,param3,param1,param4,param5,false);
      }
      
      public function getItemFromUId(param1:uint) : ItemWrapper {
         return ItemWrapper.getItemFromUId(param1);
      }
      
      public function getSkill(param1:uint) : Skill {
         return Skill.getSkillById(param1);
      }
      
      public function getHouseSkills() : Array {
         var _loc2_:Skill = null;
         var _loc1_:Array = new Array();
         for each (_loc2_ in Skill.getSkills())
         {
            if(_loc2_.availableInHouse)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getInfoMessage(param1:uint) : InfoMessage {
         return InfoMessage.getInfoMessageById(param1);
      }
      
      public function getAllInfoMessages() : Array {
         return InfoMessage.getInfoMessages();
      }
      
      public function getSmiliesWrapperForPlayers() : Array {
         var _loc3_:Smiley = null;
         var _loc4_:SmileyWrapper = null;
         var _loc1_:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         if((_loc1_) && (_loc1_.smilies) && _loc1_.smilies.length > 0)
         {
            return _loc1_.smilies;
         }
         var _loc2_:Array = new Array();
         for each (_loc3_ in Smiley.getSmileys())
         {
            if(_loc3_.forPlayers)
            {
               _loc4_ = SmileyWrapper.create(_loc3_.id,_loc3_.gfxId,_loc3_.order);
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn("order",Array.NUMERIC);
         return _loc2_;
      }
      
      public function getSmiley(param1:uint) : Smiley {
         return Smiley.getSmileyById(param1);
      }
      
      public function getAllSmiley() : Array {
         return Smiley.getSmileys();
      }
      
      public function getTaxCollectorName(param1:uint) : TaxCollectorName {
         return TaxCollectorName.getTaxCollectorNameById(param1);
      }
      
      public function getTaxCollectorFirstname(param1:uint) : TaxCollectorFirstname {
         return TaxCollectorFirstname.getTaxCollectorFirstnameById(param1);
      }
      
      public function getEmblems() : Array {
         var _loc5_:EmblemSymbol = null;
         var _loc6_:EmblemBackground = null;
         var _loc7_:Array = null;
         var _loc1_:Array = EmblemSymbol.getEmblemSymbols();
         var _loc2_:Array = EmblemBackground.getEmblemBackgrounds();
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         for each (_loc5_ in _loc1_)
         {
            _loc3_.push(EmblemWrapper.create(_loc5_.id,EmblemWrapper.UP));
         }
         _loc3_.sortOn("order",Array.NUMERIC);
         for each (_loc6_ in _loc2_)
         {
            _loc4_.push(EmblemWrapper.create(_loc6_.id,EmblemWrapper.BACK));
         }
         _loc4_.sortOn("order",Array.NUMERIC);
         _loc7_ = new Array(_loc3_,_loc4_);
         return _loc7_;
      }
      
      public function getEmblemSymbol(param1:int) : EmblemSymbol {
         return EmblemSymbol.getEmblemSymbolById(param1);
      }
      
      public function getAllEmblemSymbolCategories() : Array {
         return EmblemSymbolCategory.getEmblemSymbolCategories();
      }
      
      public function getQuest(param1:int) : Quest {
         return Quest.getQuestById(param1);
      }
      
      public function getQuestCategory(param1:int) : QuestCategory {
         return QuestCategory.getQuestCategoryById(param1);
      }
      
      public function getQuestObjective(param1:int) : QuestObjective {
         return QuestObjective.getQuestObjectiveById(param1);
      }
      
      public function getQuestStep(param1:int) : QuestStep {
         return QuestStep.getQuestStepById(param1);
      }
      
      public function getAchievement(param1:int) : Achievement {
         return Achievement.getAchievementById(param1);
      }
      
      public function getAchievements() : Array {
         return Achievement.getAchievements();
      }
      
      public function getAchievementCategory(param1:int) : AchievementCategory {
         return AchievementCategory.getAchievementCategoryById(param1);
      }
      
      public function getAchievementCategories() : Array {
         return AchievementCategory.getAchievementCategories();
      }
      
      public function getAchievementReward(param1:int) : AchievementReward {
         return AchievementReward.getAchievementRewardById(param1);
      }
      
      public function getAchievementRewards() : Array {
         return AchievementReward.getAchievementRewards();
      }
      
      public function getAchievementObjective(param1:int) : AchievementObjective {
         return AchievementObjective.getAchievementObjectiveById(param1);
      }
      
      public function getAchievementObjectives() : Array {
         return AchievementObjective.getAchievementObjectives();
      }
      
      public function getHouse(param1:int) : House {
         return House.getGuildHouseById(param1);
      }
      
      public function getLivingObjectSkins(param1:ItemWrapper) : Array {
         if(!param1.isLivingObject)
         {
            return [];
         }
         var _loc2_:Array = new Array();
         var _loc3_:* = 1;
         while(_loc3_ <= param1.livingObjectLevel)
         {
            _loc2_.push(LivingObjectSkinWrapper.create(param1.livingObjectId?param1.livingObjectId:param1.id,param1.livingObjectMood,_loc3_));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getAbuseReasonName(param1:uint) : AbuseReasons {
         return AbuseReasons.getReasonNameById(param1);
      }
      
      public function getAllAbuseReasons() : Array {
         return AbuseReasons.getReasonNames();
      }
      
      public function getPresetIcons() : Array {
         return PresetIcon.getPresetIcons();
      }
      
      public function getPresetIcon(param1:uint) : PresetIcon {
         return PresetIcon.getPresetIconById(param1);
      }
      
      public function getDungeons() : Array {
         return Dungeon.getAllDungeons();
      }
      
      public function getDungeon(param1:uint) : Dungeon {
         return Dungeon.getDungeonById(param1);
      }
      
      public function getMapInfo(param1:uint) : MapPosition {
         return MapPosition.getMapPositionById(param1);
      }
      
      public function getWorldMap(param1:uint) : WorldMap {
         return WorldMap.getWorldMapById(param1);
      }
      
      public function getAllWorldMaps() : Array {
         return WorldMap.getAllWorldMaps();
      }
      
      public function getHintCategory(param1:uint) : HintCategory {
         return HintCategory.getHintCategoryById(param1);
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
      
      public function getHouseInformations(param1:uint) : HouseWrapper {
         if(this.entitiesFrame)
         {
            return this.entitiesFrame.housesInformations[param1];
         }
         return null;
      }
      
      public function getBomb(param1:uint) : SpellBomb {
         return SpellBomb.getSpellBombById(param1);
      }
      
      public function getPack(param1:uint) : Pack {
         return Pack.getPackById(param1);
      }
      
      public function getTitle(param1:uint) : Title {
         return Title.getTitleById(param1);
      }
      
      public function getTitles() : Array {
         return Title.getAllTitle();
      }
      
      public function getTitleCategory(param1:uint) : TitleCategory {
         return TitleCategory.getTitleCategoryById(param1);
      }
      
      public function getTitleCategories() : Array {
         return TitleCategory.getTitleCategories();
      }
      
      public function getOrnament(param1:uint) : Ornament {
         return Ornament.getOrnamentById(param1);
      }
      
      public function getOrnaments() : Array {
         return Ornament.getAllOrnaments();
      }
      
      public function getOptionalFeatureByKeyword(param1:String) : OptionalFeature {
         return OptionalFeature.getOptionalFeatureByKeyword(param1);
      }
      
      public function getEffect(param1:uint) : Effect {
         return Effect.getEffectById(param1);
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
      
      public function getAlmanaxCalendar(param1:uint) : AlmanaxCalendar {
         return AlmanaxCalendar.getAlmanaxCalendarById(param1);
      }
      
      public function getExternalNotification(param1:int) : ExternalNotification {
         return ExternalNotification.getExternalNotificationById(param1);
      }
      
      public function getExternalNotifications() : Array {
         return ExternalNotification.getExternalNotifications();
      }
      
      public function getActionDescriptionByName(param1:String) : ActionDescription {
         return ActionDescription.getActionDescriptionByName(param1);
      }
      
      public function queryString(param1:Class, param2:String, param3:String) : Vector.<uint> {
         return GameDataQuery.queryString(param1,param2,param3);
      }
      
      public function queryEquals(param1:Class, param2:String, param3:*) : Vector.<uint> {
         return GameDataQuery.queryEquals(param1,param2,param3);
      }
      
      public function queryUnion(... rest) : Vector.<uint> {
         return GameDataQuery.union.apply(null,rest);
      }
      
      public function queryIntersection(... rest) : Vector.<uint> {
         return GameDataQuery.intersection.apply(null,rest);
      }
      
      public function queryGreaterThan(param1:Class, param2:String, param3:*) : Vector.<uint> {
         return GameDataQuery.queryGreaterThan(param1,param2,param3);
      }
      
      public function querySmallerThan(param1:Class, param2:String, param3:*) : Vector.<uint> {
         return GameDataQuery.querySmallerThan(param1,param2,param3);
      }
      
      public function queryReturnInstance(param1:Class, param2:Vector.<uint>) : Vector.<Object> {
         return GameDataQuery.returnInstance(param1,param2);
      }
      
      public function querySort(param1:Class, param2:Vector.<uint>, param3:*, param4:*=true) : Vector.<uint> {
         return GameDataQuery.sort(param1,param2,param3,param4);
      }
      
      public function querySortI18nId(param1:*, param2:*, param3:*=true) : * {
         return GameDataQuery.sortI18n(param1,param2,param3);
      }
   }
}
