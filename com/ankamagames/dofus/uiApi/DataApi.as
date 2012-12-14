package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.abuse.*;
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.datacenter.almanax.*;
    import com.ankamagames.dofus.datacenter.appearance.*;
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.externalnotifications.*;
    import com.ankamagames.dofus.datacenter.guild.*;
    import com.ankamagames.dofus.datacenter.houses.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.datacenter.livingObjects.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.notifications.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.datacenter.servers.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.almanax.*;
    import com.ankamagames.dofus.internalDatacenter.appearance.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.internalDatacenter.house.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.userInterface.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.utils.*;

    public class DataApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function DataApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(DataApi));
            return;
        }// end function

        private function get entitiesFrame() : RoleplayEntitiesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getNotifications() : Array
        {
            return Notification.getNotifications();
        }// end function

        public function getServer(param1:int) : Server
        {
            return Server.getServerById(param1);
        }// end function

        public function getServerPopulation(param1:int) : ServerPopulation
        {
            return ServerPopulation.getServerPopulationById(param1);
        }// end function

        public function getBreed(param1:int) : Breed
        {
            return Breed.getBreedById(param1);
        }// end function

        public function getBreeds() : Array
        {
            return Breed.getBreeds();
        }// end function

        public function getHead(param1:int) : Head
        {
            return Head.getHeadById(param1);
        }// end function

        public function getHeads() : Array
        {
            return Head.getHeads();
        }// end function

        public function getSpell(param1:int) : Spell
        {
            return Spell.getSpellById(param1);
        }// end function

        public function getSpells() : Array
        {
            return Spell.getSpells();
        }// end function

        public function getSpellWrapper(param1:uint, param2:uint = 1) : SpellWrapper
        {
            var _loc_3:* = SpellWrapper.create(-1, param1, param2, false);
            return _loc_3;
        }// end function

        public function getEmoteWrapper(param1:uint, param2:uint = 0) : EmoteWrapper
        {
            return EmoteWrapper.create(param1, param2);
        }// end function

        public function getButtonWrapper(param1:uint, param2:int, param3:String, param4:Function, param5:String, param6:String = "") : ButtonWrapper
        {
            return ButtonWrapper.create(param1, param2, param3, param4, param5, param6);
        }// end function

        public function getJobWrapper(param1:uint) : JobWrapper
        {
            return JobWrapper.create(param1);
        }// end function

        public function getTitleWrapper(param1:uint) : TitleWrapper
        {
            return TitleWrapper.create(param1);
        }// end function

        public function getOrnamentWrapper(param1:uint) : OrnamentWrapper
        {
            return OrnamentWrapper.create(param1);
        }// end function

        public function getSpellLevel(param1:int) : SpellLevel
        {
            return SpellLevel.getLevelById(param1);
        }// end function

        public function getSpellType(param1:int) : SpellType
        {
            return SpellType.getSpellTypeById(param1);
        }// end function

        public function getSpellState(param1:int) : SpellState
        {
            return SpellState.getSpellStateById(param1);
        }// end function

        public function getChatChannel(param1:int) : ChatChannel
        {
            return ChatChannel.getChannelById(param1);
        }// end function

        public function getAllChatChannels() : Array
        {
            return ChatChannel.getChannels();
        }// end function

        public function getSubArea(param1:int) : SubArea
        {
            return SubArea.getSubAreaById(param1);
        }// end function

        public function getSubAreaFromMap(param1:int) : SubArea
        {
            return SubArea.getSubAreaByMapId(param1);
        }// end function

        public function getArea(param1:int) : Area
        {
            return Area.getAreaById(param1);
        }// end function

        public function getAllArea(param1:Boolean = false, param2:Boolean = false) : Array
        {
            var _loc_4:* = null;
            var _loc_3:* = new Array();
            for each (_loc_4 in Area.getAllArea())
            {
                
                if (param1 && _loc_4.containHouses || param2 && _loc_4.containPaddocks || !param1 && !param2)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public function getWorldPoint(param1:int) : WorldPoint
        {
            return WorldPoint.fromMapId(param1);
        }// end function

        public function getItem(param1:int) : Item
        {
            return Item.getItemById(param1);
        }// end function

        public function getItems() : Array
        {
            return Item.getItems();
        }// end function

        public function getIncarnationLevel(param1:int, param2:int) : IncarnationLevel
        {
            return IncarnationLevel.getIncarnationLevelByIdAndLevel(param1, param2);
        }// end function

        public function getNewGenericSlotData() : GenericSlotData
        {
            return new GenericSlotData();
        }// end function

        public function getItemIconUri(param1:uint) : Uri
        {
            return new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(param1).concat(".png"));
        }// end function

        public function getItemName(param1:int) : String
        {
            return Item.getItemById(param1).name;
        }// end function

        public function getItemType(param1:int) : String
        {
            return ItemType.getItemTypeById(param1).name;
        }// end function

        public function getItemSet(param1:int) : ItemSet
        {
            return ItemSet.getItemSetById(param1);
        }// end function

        public function getPet(param1:int) : Pet
        {
            return Pet.getPetById(param1);
        }// end function

        public function getSetEffects(param1:Array, param2:Array = null) : Array
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_3:* = new Dictionary();
            var _loc_4:* = new Array();
            var _loc_5:* = new Array();
            var _loc_6:* = new Array();
            for each (_loc_7 in PlayedCharacterManager.getInstance().inventory)
            {
                
                if (_loc_7.position <= 15)
                {
                    for (_loc_12 in param1)
                    {
                        
                        if (_loc_7.objectGID == param1[_loc_12])
                        {
                            _loc_6.push(_loc_7);
                            param1[_loc_12] = -1;
                        }
                    }
                }
            }
            for each (_loc_8 in param1)
            {
                
                if (_loc_8 != -1)
                {
                    for each (_loc_13 in Item.getItemById(_loc_8).possibleEffects)
                    {
                        
                        if (Effect.getEffectById(_loc_13.effectId).useDice)
                        {
                            if (_loc_3[_loc_13.effectId])
                            {
                                _loc_3[_loc_13.effectId].add(_loc_13);
                            }
                            else
                            {
                                _loc_3[_loc_13.effectId] = _loc_13.clone();
                            }
                            continue;
                        }
                        _loc_5.push(_loc_13.clone());
                    }
                }
            }
            for each (_loc_9 in _loc_6)
            {
                
                for each (_loc_14 in _loc_9.effects)
                {
                    
                    if (Effect.getEffectById(_loc_14.effectId).useDice)
                    {
                        if (_loc_3[_loc_14.effectId])
                        {
                            _loc_3[_loc_14.effectId].add(_loc_14);
                        }
                        else
                        {
                            _loc_3[_loc_14.effectId] = _loc_14.clone();
                        }
                        continue;
                    }
                    _loc_5.push(_loc_14.clone());
                }
            }
            if (param2 && param2.length)
            {
                for each (_loc_15 in param2)
                {
                    
                    if (_loc_15 is String)
                    {
                        this._log.debug("Bonus en texte, on ne peut pas l\'ajouter");
                        continue;
                    }
                    if (Effect.getEffectById(_loc_15.effectId) && Effect.getEffectById(_loc_15.effectId).useDice)
                    {
                        if (_loc_3[_loc_15.effectId])
                        {
                            _loc_3[_loc_15.effectId].add(SecureCenter.unsecure(_loc_15));
                        }
                        else
                        {
                            _loc_3[_loc_15.effectId] = SecureCenter.unsecure(_loc_15).clone();
                        }
                        continue;
                    }
                    _loc_5.push(SecureCenter.unsecure(_loc_15).clone());
                }
            }
            for each (_loc_10 in _loc_3)
            {
                
                if (_loc_10.showInSet > 0)
                {
                    _loc_4.push(_loc_10);
                }
            }
            for each (_loc_11 in _loc_5)
            {
                
                if (_loc_11.showInSet > 0)
                {
                    _loc_4.push(_loc_11);
                }
            }
            _loc_4.sortOn("category", Array.NUMERIC);
            return _loc_4;
        }// end function

        public function getMonsterFromId(param1:uint) : Monster
        {
            return Monster.getMonsterById(param1);
        }// end function

        public function getMonsters() : Array
        {
            return Monster.getMonsters();
        }// end function

        public function getNpc(param1:uint) : Npc
        {
            return Npc.getNpcById(param1);
        }// end function

        public function getNpcAction(param1:uint) : NpcAction
        {
            return NpcAction.getNpcActionById(param1);
        }// end function

        public function getAlignmentSide(param1:uint) : AlignmentSide
        {
            return AlignmentSide.getAlignmentSideById(param1);
        }// end function

        public function getAlignmentBalance(param1:uint) : AlignmentBalance
        {
            var _loc_2:* = 0;
            if (param1 == 0)
            {
                _loc_2 = 1;
            }
            else if (param1 == 10)
            {
                _loc_2 = 2;
            }
            else if (param1 == 20)
            {
                _loc_2 = 3;
            }
            else if (param1 == 30)
            {
                _loc_2 = 4;
            }
            else if (param1 == 40)
            {
                _loc_2 = 5;
            }
            else if (param1 == 50)
            {
                _loc_2 = 6;
            }
            else if (param1 == 60)
            {
                _loc_2 = 7;
            }
            else if (param1 == 70)
            {
                _loc_2 = 8;
            }
            else if (param1 == 80)
            {
                _loc_2 = 9;
            }
            else if (param1 == 90)
            {
                _loc_2 = 10;
            }
            else
            {
                _loc_2 = Math.ceil(param1 / 10);
            }
            return AlignmentBalance.getAlignmentBalanceById(_loc_2);
        }// end function

        public function getRankName(param1:uint) : RankName
        {
            return RankName.getRankNameById(param1);
        }// end function

        public function getAllRankNames() : Array
        {
            return RankName.getRankNames();
        }// end function

        public function getItemWrapper(param1:uint, param2:int = 0, param3:uint = 0, param4:uint = 0, param5 = null) : ItemWrapper
        {
            if (param5 == null)
            {
                param5 = new Vector.<ObjectEffect>;
            }
            return ItemWrapper.create(param2, param3, param1, param4, param5, false);
        }// end function

        public function getItemFromUId(param1:uint) : ItemWrapper
        {
            return ItemWrapper.getItemFromUId(param1);
        }// end function

        public function getSkill(param1:uint) : Skill
        {
            return Skill.getSkillById(param1);
        }// end function

        public function getHouseSkills() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in Skill.getSkills())
            {
                
                if (_loc_2.availableInHouse)
                {
                    _loc_1.push(_loc_2);
                }
            }
            return _loc_1;
        }// end function

        public function getInfoMessage(param1:uint) : InfoMessage
        {
            return InfoMessage.getInfoMessageById(param1);
        }// end function

        public function getAllInfoMessages() : Array
        {
            return InfoMessage.getInfoMessages();
        }// end function

        public function getSmiliesWrapperForPlayers() : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
            if (_loc_1 && _loc_1.smilies && _loc_1.smilies.length > 0)
            {
                return _loc_1.smilies;
            }
            var _loc_2:* = new Array();
            for each (_loc_3 in Smiley.getSmileys())
            {
                
                if (_loc_3.forPlayers)
                {
                    _loc_4 = SmileyWrapper.create(_loc_3.id, _loc_3.gfxId, _loc_3.order);
                    _loc_2.push(_loc_4);
                }
            }
            _loc_2.sortOn("order", Array.NUMERIC);
            return _loc_2;
        }// end function

        public function getSmiley(param1:uint) : Smiley
        {
            return Smiley.getSmileyById(param1);
        }// end function

        public function getAllSmiley() : Array
        {
            return Smiley.getSmileys();
        }// end function

        public function getTaxCollectorName(param1:uint) : TaxCollectorName
        {
            return TaxCollectorName.getTaxCollectorNameById(param1);
        }// end function

        public function getTaxCollectorFirstname(param1:uint) : TaxCollectorFirstname
        {
            return TaxCollectorFirstname.getTaxCollectorFirstnameById(param1);
        }// end function

        public function getEmblems() : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = EmblemSymbol.getEmblemSymbols();
            var _loc_2:* = EmblemBackground.getEmblemBackgrounds();
            var _loc_3:* = new Array();
            var _loc_4:* = new Array();
            for each (_loc_5 in _loc_1)
            {
                
                _loc_3.push(EmblemWrapper.create(_loc_5.id, EmblemWrapper.UP));
            }
            _loc_3.sortOn("order", Array.NUMERIC);
            for each (_loc_6 in _loc_2)
            {
                
                _loc_4.push(EmblemWrapper.create(_loc_6.id, EmblemWrapper.BACK));
            }
            _loc_4.sortOn("order", Array.NUMERIC);
            _loc_7 = new Array(_loc_3, _loc_4);
            return _loc_7;
        }// end function

        public function getEmblemSymbol(param1:int) : EmblemSymbol
        {
            return EmblemSymbol.getEmblemSymbolById(param1);
        }// end function

        public function getAllEmblemSymbolCategories() : Array
        {
            return EmblemSymbolCategory.getEmblemSymbolCategories();
        }// end function

        public function getQuest(param1:int) : Quest
        {
            return Quest.getQuestById(param1);
        }// end function

        public function getQuestCategory(param1:int) : QuestCategory
        {
            return QuestCategory.getQuestCategoryById(param1);
        }// end function

        public function getQuestObjective(param1:int) : QuestObjective
        {
            return QuestObjective.getQuestObjectiveById(param1);
        }// end function

        public function getQuestStep(param1:int) : QuestStep
        {
            return QuestStep.getQuestStepById(param1);
        }// end function

        public function getAchievement(param1:int) : Achievement
        {
            return Achievement.getAchievementById(param1);
        }// end function

        public function getAchievements() : Array
        {
            return Achievement.getAchievements();
        }// end function

        public function getAchievementCategory(param1:int) : AchievementCategory
        {
            return AchievementCategory.getAchievementCategoryById(param1);
        }// end function

        public function getAchievementCategories() : Array
        {
            return AchievementCategory.getAchievementCategories();
        }// end function

        public function getAchievementReward(param1:int) : AchievementReward
        {
            return AchievementReward.getAchievementRewardById(param1);
        }// end function

        public function getAchievementRewards() : Array
        {
            return AchievementReward.getAchievementRewards();
        }// end function

        public function getAchievementObjective(param1:int) : AchievementObjective
        {
            return AchievementObjective.getAchievementObjectiveById(param1);
        }// end function

        public function getAchievementObjectives() : Array
        {
            return AchievementObjective.getAchievementObjectives();
        }// end function

        public function getHouse(param1:int) : House
        {
            return House.getGuildHouseById(param1);
        }// end function

        public function getLivingObjectSkins(param1:ItemWrapper) : Array
        {
            if (!param1.isLivingObject)
            {
                return [];
            }
            var _loc_2:* = new Array();
            var _loc_3:* = 1;
            while (_loc_3 <= param1.livingObjectLevel)
            {
                
                _loc_2.push(LivingObjectSkinWrapper.create(param1.livingObjectId ? (param1.livingObjectId) : (param1.id), param1.livingObjectMood, _loc_3));
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function getAbuseReasonName(param1:uint) : AbuseReasons
        {
            return AbuseReasons.getReasonNameById(param1);
        }// end function

        public function getAllAbuseReasons() : Array
        {
            return AbuseReasons.getReasonNames();
        }// end function

        public function getPresetIcons() : Array
        {
            return PresetIcon.getPresetIcons();
        }// end function

        public function getPresetIcon(param1:uint) : PresetIcon
        {
            return PresetIcon.getPresetIconById(param1);
        }// end function

        public function getDungeons() : Array
        {
            return Dungeon.getAllDungeons();
        }// end function

        public function getDungeon(param1:uint) : Dungeon
        {
            return Dungeon.getDungeonById(param1);
        }// end function

        public function getMapInfo(param1:uint) : MapPosition
        {
            return MapPosition.getMapPositionById(param1);
        }// end function

        public function getWorldMap(param1:uint) : WorldMap
        {
            return WorldMap.getWorldMapById(param1);
        }// end function

        public function getHintCategory(param1:uint) : HintCategory
        {
            return HintCategory.getHintCategoryById(param1);
        }// end function

        public function getHintCategories() : Array
        {
            return HintCategory.getHintCategories();
        }// end function

        public function getHousesInformations() : Dictionary
        {
            if (this.entitiesFrame)
            {
                return this.entitiesFrame.housesInformations;
            }
            return null;
        }// end function

        public function getHouseInformations(param1:uint) : HouseWrapper
        {
            if (this.entitiesFrame)
            {
                return this.entitiesFrame.housesInformations[param1];
            }
            return null;
        }// end function

        public function getBomb(param1:uint) : SpellBomb
        {
            return SpellBomb.getSpellBombById(param1);
        }// end function

        public function getPack(param1:uint) : Pack
        {
            return Pack.getPackById(param1);
        }// end function

        public function getTitle(param1:uint) : Title
        {
            return Title.getTitleById(param1);
        }// end function

        public function getTitles() : Array
        {
            return Title.getAllTitle();
        }// end function

        public function getTitleCategory(param1:uint) : TitleCategory
        {
            return TitleCategory.getTitleCategoryById(param1);
        }// end function

        public function getTitleCategories() : Array
        {
            return TitleCategory.getTitleCategories();
        }// end function

        public function getOrnament(param1:uint) : Ornament
        {
            return Ornament.getOrnamentById(param1);
        }// end function

        public function getOrnaments() : Array
        {
            return Ornament.getAllOrnaments();
        }// end function

        public function getOptionalFeatureByKeyword(param1:String) : OptionalFeature
        {
            return OptionalFeature.getOptionalFeatureByKeyword(param1);
        }// end function

        public function getEffect(param1:uint) : Effect
        {
            return Effect.getEffectById(param1);
        }// end function

        public function getAlmanaxEvent() : AlmanaxEvent
        {
            return AlmanaxManager.getInstance().event;
        }// end function

        public function getAlmanaxZodiac() : AlmanaxZodiac
        {
            return AlmanaxManager.getInstance().zodiac;
        }// end function

        public function getAlmanaxMonth() : AlmanaxMonth
        {
            return AlmanaxManager.getInstance().month;
        }// end function

        public function getAlmanaxCalendar(param1:uint) : AlmanaxCalendar
        {
            return AlmanaxCalendar.getAlmanaxCalendarById(param1);
        }// end function

        public function getExternalNotification(param1:int) : ExternalNotification
        {
            return ExternalNotification.getExternalNotificationById(param1);
        }// end function

        public function getExternalNotifications() : Array
        {
            return ExternalNotification.getExternalNotifications();
        }// end function

    }
}

import com.ankamagames.berilia.interfaces.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.dofus.datacenter.abuse.*;

import com.ankamagames.dofus.datacenter.alignments.*;

import com.ankamagames.dofus.datacenter.almanax.*;

import com.ankamagames.dofus.datacenter.appearance.*;

import com.ankamagames.dofus.datacenter.breeds.*;

import com.ankamagames.dofus.datacenter.communication.*;

import com.ankamagames.dofus.datacenter.effects.*;

import com.ankamagames.dofus.datacenter.externalnotifications.*;

import com.ankamagames.dofus.datacenter.guild.*;

import com.ankamagames.dofus.datacenter.houses.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.datacenter.jobs.*;

import com.ankamagames.dofus.datacenter.livingObjects.*;

import com.ankamagames.dofus.datacenter.misc.*;

import com.ankamagames.dofus.datacenter.monsters.*;

import com.ankamagames.dofus.datacenter.notifications.*;

import com.ankamagames.dofus.datacenter.npcs.*;

import com.ankamagames.dofus.datacenter.quest.*;

import com.ankamagames.dofus.datacenter.servers.*;

import com.ankamagames.dofus.datacenter.spells.*;

import com.ankamagames.dofus.datacenter.world.*;

import com.ankamagames.dofus.internalDatacenter.almanax.*;

import com.ankamagames.dofus.internalDatacenter.appearance.*;

import com.ankamagames.dofus.internalDatacenter.communication.*;

import com.ankamagames.dofus.internalDatacenter.guild.*;

import com.ankamagames.dofus.internalDatacenter.house.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.internalDatacenter.jobs.*;

import com.ankamagames.dofus.internalDatacenter.spells.*;

import com.ankamagames.dofus.internalDatacenter.userInterface.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.logic.game.common.frames.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.roleplay.frames.*;

import com.ankamagames.dofus.network.types.game.data.items.effects.*;

import com.ankamagames.dofus.types.data.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.types.positions.*;

import flash.utils.*;

class Smiley extends Object
{
    public var pictoId:String;
    public var triggers:Vector.<String>;
    public var position:int;
    public var currentTrigger:String;

    function Smiley(param1:String) : void
    {
        this.pictoId = param1;
        this.position = -1;
        return;
    }// end function

}

