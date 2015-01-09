package d2api
{
    import d2data.Server;
    import d2data.ServerPopulation;
    import d2data.Breed;
    import d2data.BreedRole;
    import d2data.Head;
    import d2data.Spell;
    import d2data.SpellWrapper;
    import d2data.EmoteWrapper;
    import d2data.ButtonWrapper;
    import d2data.JobWrapper;
    import d2data.TitleWrapper;
    import d2data.OrnamentWrapper;
    import d2data.SpellLevel;
    import d2data.SpellType;
    import d2data.SpellState;
    import d2data.ChatChannel;
    import d2data.SubArea;
    import d2data.Area;
    import d2data.SuperArea;
    import d2data.WorldPoint;
    import d2data.Item;
    import d2data.IncarnationLevel;
    import d2data.Incarnation;
    import d2data.ItemType;
    import d2data.ItemSet;
    import d2data.Pet;
    import d2data.Monster;
    import d2data.MonsterMiniBoss;
    import d2data.MonsterRace;
    import d2data.MonsterSuperRace;
    import d2data.Companion;
    import d2data.CompanionCharacteristic;
    import d2data.CompanionSpell;
    import d2data.Npc;
    import d2data.NpcAction;
    import d2data.AlignmentSide;
    import d2data.AlignmentBalance;
    import d2data.RankName;
    import d2data.ItemWrapper;
    import d2data.Skill;
    import d2data.InfoMessage;
    import d2data.Smiley;
    import d2data.Emoticon;
    import d2data.TaxCollectorName;
    import d2data.TaxCollectorFirstname;
    import d2data.EmblemSymbol;
    import d2data.Quest;
    import d2data.QuestCategory;
    import d2data.QuestObjective;
    import d2data.QuestStep;
    import d2data.Achievement;
    import d2data.AchievementCategory;
    import d2data.AchievementReward;
    import d2data.AchievementObjective;
    import d2data.House;
    import d2data.AbuseReasons;
    import d2data.PresetIcon;
    import d2data.Dungeon;
    import d2data.MapPosition;
    import d2data.WorldMap;
    import d2data.HintCategory;
    import d2data.HouseWrapper;
    import d2data.SpellPair;
    import d2data.SpellBomb;
    import d2data.Pack;
    import d2data.LegendaryTreasureHunt;
    import d2data.Title;
    import d2data.TitleCategory;
    import d2data.Ornament;
    import d2data.OptionalFeature;
    import d2data.Effect;
    import d2data.AlmanaxEvent;
    import d2data.AlmanaxZodiac;
    import d2data.AlmanaxMonth;
    import d2data.AlmanaxCalendar;
    import d2data.ExternalNotification;
    import d2data.ActionDescription;

    public class DataApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getNotifications():Object
        {
            return (null);
        }

        [Trusted]
        public function getServer(id:int):Server
        {
            return (null);
        }

        [Trusted]
        public function getServerPopulation(id:int):ServerPopulation
        {
            return (null);
        }

        [Untrusted]
        public function getBreed(id:int):Breed
        {
            return (null);
        }

        [Untrusted]
        public function getBreeds():Object
        {
            return (null);
        }

        [Untrusted]
        public function getBreedRole(id:int):BreedRole
        {
            return (null);
        }

        [Untrusted]
        public function getBreedRoles():Object
        {
            return (null);
        }

        [Untrusted]
        public function getHead(id:int):Head
        {
            return (null);
        }

        [Untrusted]
        public function getHeads():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSpell(id:int):Spell
        {
            return (null);
        }

        [Untrusted]
        public function getSpells():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSpellWrapper(id:uint, level:uint=1):SpellWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getEmoteWrapper(id:uint, position:uint=0):EmoteWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getButtonWrapper(buttonId:uint, position:int, uriName:String, callback:Function, name:String, shortcut:String=""):ButtonWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getJobs():Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobWrapper(id:uint):JobWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getTitleWrapper(id:uint):TitleWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getOrnamentWrapper(id:uint):OrnamentWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getSpellLevel(id:int):SpellLevel
        {
            return (null);
        }

        [Untrusted]
        public function getSpellLevelBySpell(spell:Spell, level:int):SpellLevel
        {
            return (null);
        }

        [Untrusted]
        public function getSpellType(id:int):SpellType
        {
            return (null);
        }

        [Untrusted]
        public function getSpellState(id:int):SpellState
        {
            return (null);
        }

        [Untrusted]
        public function getChatChannel(id:int):ChatChannel
        {
            return (null);
        }

        [Untrusted]
        public function getAllChatChannels():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSubArea(id:int):SubArea
        {
            return (null);
        }

        [Untrusted]
        public function getSubAreaFromMap(mapId:int):SubArea
        {
            return (null);
        }

        [Untrusted]
        public function getAllSubAreas():Object
        {
            return (null);
        }

        [Untrusted]
        public function getArea(id:int):Area
        {
            return (null);
        }

        [Untrusted]
        public function getSuperArea(id:int):SuperArea
        {
            return (null);
        }

        [Untrusted]
        public function getAllArea(withHouses:Boolean=false, withPaddocks:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function getWorldPoint(id:int):WorldPoint
        {
            return (null);
        }

        [Untrusted]
        public function getItem(id:int, returnDefaultItemIfNull:Boolean=true):Item
        {
            return (null);
        }

        [Untrusted]
        public function getItems():Object
        {
            return (null);
        }

        [Untrusted]
        public function getIncarnationLevel(incarnationId:int, level:int):IncarnationLevel
        {
            return (null);
        }

        [Untrusted]
        public function getIncarnation(incarnationId:int):Incarnation
        {
            return (null);
        }

        [Untrusted]
        public function getNewGenericSlotData():Object
        {
            return (null);
        }

        [Untrusted]
        public function getItemIconUri(iconId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getItemName(id:int):String
        {
            return (null);
        }

        [Untrusted]
        public function getItemType(id:int):ItemType
        {
            return (null);
        }

        [Untrusted]
        public function getItemSet(id:int):ItemSet
        {
            return (null);
        }

        [Untrusted]
        public function getPet(id:int):Pet
        {
            return (null);
        }

        [Untrusted]
        public function getSetEffects(GIDList:Object, aSetBonus:Object=null):Object
        {
            return (null);
        }

        [Untrusted]
        public function getMonsterFromId(monsterId:uint):Monster
        {
            return (null);
        }

        [Untrusted]
        public function getMonsters():Object
        {
            return (null);
        }

        [Untrusted]
        public function getMonsterMiniBossFromId(monsterId:uint):MonsterMiniBoss
        {
            return (null);
        }

        [Untrusted]
        public function getMonsterRaceFromId(raceId:uint):MonsterRace
        {
            return (null);
        }

        [Untrusted]
        public function getMonsterRaces():Object
        {
            return (null);
        }

        [Untrusted]
        public function getMonsterSuperRaceFromId(raceId:uint):MonsterSuperRace
        {
            return (null);
        }

        [Untrusted]
        public function getMonsterSuperRaces():Object
        {
            return (null);
        }

        [Untrusted]
        public function getCompanion(companionId:uint):Companion
        {
            return (null);
        }

        [Untrusted]
        public function getAllCompanions():Object
        {
            return (null);
        }

        [Untrusted]
        public function getCompanionCharacteristic(companionCharacteristicId:uint):CompanionCharacteristic
        {
            return (null);
        }

        [Untrusted]
        public function getCompanionSpell(companionSpellId:uint):CompanionSpell
        {
            return (null);
        }

        [Untrusted]
        public function getNpc(npcId:uint):Npc
        {
            return (null);
        }

        [Untrusted]
        public function getNpcAction(actionId:uint):NpcAction
        {
            return (null);
        }

        [Untrusted]
        public function getAlignmentSide(sideId:uint):AlignmentSide
        {
            return (null);
        }

        [Untrusted]
        public function getAlignmentBalance(percent:uint):AlignmentBalance
        {
            return (null);
        }

        [Untrusted]
        public function getRankName(rankId:uint):RankName
        {
            return (null);
        }

        [Untrusted]
        public function getAllRankNames():Object
        {
            return (null);
        }

        [Untrusted]
        public function getItemWrapper(itemGID:uint, itemPosition:int=0, itemUID:uint=0, itemQuantity:uint=0, itemEffects:*=null):ItemWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getItemFromUId(objectUID:uint):ItemWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getSkill(skillId:uint):Skill
        {
            return (null);
        }

        [Untrusted]
        public function getHouseSkills():Object
        {
            return (null);
        }

        [Untrusted]
        public function getInfoMessage(infoMsgId:uint):InfoMessage
        {
            return (null);
        }

        [Untrusted]
        public function getAllInfoMessages():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSmiliesWrapperForPlayers():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSmiley(id:uint):Smiley
        {
            return (null);
        }

        [Untrusted]
        public function getAllSmiley():Object
        {
            return (null);
        }

        [Untrusted]
        public function getEmoticon(id:uint):Emoticon
        {
            return (null);
        }

        [Untrusted]
        public function getTaxCollectorName(id:uint):TaxCollectorName
        {
            return (null);
        }

        [Untrusted]
        public function getTaxCollectorFirstname(id:uint):TaxCollectorFirstname
        {
            return (null);
        }

        [Untrusted]
        public function getEmblems():Object
        {
            return (null);
        }

        [Untrusted]
        public function getEmblemSymbol(symbolId:int):EmblemSymbol
        {
            return (null);
        }

        [Untrusted]
        public function getAllEmblemSymbolCategories():Object
        {
            return (null);
        }

        [Untrusted]
        public function getQuest(questId:int):Quest
        {
            return (null);
        }

        [Untrusted]
        public function getQuestCategory(questCatId:int):QuestCategory
        {
            return (null);
        }

        [Untrusted]
        public function getQuestObjective(questObjectiveId:int):QuestObjective
        {
            return (null);
        }

        [Untrusted]
        public function getQuestStep(questStepId:int):QuestStep
        {
            return (null);
        }

        [Untrusted]
        public function getAchievement(achievementId:int):Achievement
        {
            return (null);
        }

        [Untrusted]
        public function getAchievements():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAchievementCategory(achievementCatId:int):AchievementCategory
        {
            return (null);
        }

        [Untrusted]
        public function getAchievementCategories():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAchievementReward(rewardId:int):AchievementReward
        {
            return (null);
        }

        [Untrusted]
        public function getAchievementRewards():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAchievementObjective(objectiveId:int):AchievementObjective
        {
            return (null);
        }

        [Untrusted]
        public function getAchievementObjectives():Object
        {
            return (null);
        }

        [Untrusted]
        public function getHouse(houseId:int):House
        {
            return (null);
        }

        [Untrusted]
        public function getLivingObjectSkins(item:ItemWrapper):Object
        {
            return (null);
        }

        [Untrusted]
        public function getAbuseReasonName(abuseReasonId:uint):AbuseReasons
        {
            return (null);
        }

        [Untrusted]
        public function getAllAbuseReasons():Object
        {
            return (null);
        }

        [Untrusted]
        public function getPresetIcons():Object
        {
            return (null);
        }

        [Untrusted]
        public function getPresetIcon(iconId:uint):PresetIcon
        {
            return (null);
        }

        [Untrusted]
        public function getDungeons():Object
        {
            return (null);
        }

        [Untrusted]
        public function getDungeon(dungeonId:uint):Dungeon
        {
            return (null);
        }

        [Untrusted]
        public function getMapInfo(mapId:uint):MapPosition
        {
            return (null);
        }

        [Untrusted]
        public function getWorldMap(mapId:uint):WorldMap
        {
            return (null);
        }

        [Untrusted]
        public function getAllWorldMaps():Object
        {
            return (null);
        }

        [Untrusted]
        public function getHintCategory(hintId:uint):HintCategory
        {
            return (null);
        }

        [Untrusted]
        public function getHintCategories():Object
        {
            return (null);
        }

        [Untrusted]
        public function getHousesInformations():Object
        {
            return (null);
        }

        [Untrusted]
        public function getHouseInformations(doorId:uint):HouseWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getSpellPair(pairId:uint):SpellPair
        {
            return (null);
        }

        [Untrusted]
        public function getBomb(bombId:uint):SpellBomb
        {
            return (null);
        }

        [Untrusted]
        public function getPack(packId:uint):Pack
        {
            return (null);
        }

        [Untrusted]
        public function getLegendaryTreasureHunt(huntId:uint):LegendaryTreasureHunt
        {
            return (null);
        }

        [Untrusted]
        public function getLegendaryTreasureHunts():Object
        {
            return (null);
        }

        [Untrusted]
        public function getTitle(titleId:uint):Title
        {
            return (null);
        }

        [Untrusted]
        public function getTitles():Object
        {
            return (null);
        }

        [Untrusted]
        public function getTitleCategory(titleCatId:uint):TitleCategory
        {
            return (null);
        }

        [Untrusted]
        public function getTitleCategories():Object
        {
            return (null);
        }

        [Untrusted]
        public function getOrnament(oId:uint):Ornament
        {
            return (null);
        }

        [Untrusted]
        public function getOrnaments():Object
        {
            return (null);
        }

        [Untrusted]
        public function getOptionalFeatureByKeyword(key:String):OptionalFeature
        {
            return (null);
        }

        [Untrusted]
        public function getEffect(effectId:uint):Effect
        {
            return (null);
        }

        [Untrusted]
        public function getAlmanaxEvent():AlmanaxEvent
        {
            return (null);
        }

        [Untrusted]
        public function getAlmanaxZodiac():AlmanaxZodiac
        {
            return (null);
        }

        [Untrusted]
        public function getAlmanaxMonth():AlmanaxMonth
        {
            return (null);
        }

        [Untrusted]
        public function getAlmanaxCalendar(calendarId:uint):AlmanaxCalendar
        {
            return (null);
        }

        [Untrusted]
        public function getExternalNotification(pExtNotifId:int):ExternalNotification
        {
            return (null);
        }

        [Untrusted]
        public function getExternalNotifications():Object
        {
            return (null);
        }

        [Untrusted]
        public function getActionDescriptionByName(name:String):ActionDescription
        {
            return (null);
        }

        [Untrusted]
        public function queryString(dataClass:Class, field:String, pattern:String):Object
        {
            return (null);
        }

        [Untrusted]
        public function queryEquals(dataClass:Class, field:String, value:*):Object
        {
            return (null);
        }

        [Untrusted]
        public function queryUnion(... ids):Object
        {
            return (null);
        }

        [Untrusted]
        public function queryIntersection(... ids):Object
        {
            return (null);
        }

        [Untrusted]
        public function queryGreaterThan(dataClass:Class, field:String, value:*):Object
        {
            return (null);
        }

        [Untrusted]
        public function querySmallerThan(dataClass:Class, field:String, value:*):Object
        {
            return (null);
        }

        [Untrusted]
        public function queryReturnInstance(dataClass:Class, ids:Object):Object
        {
            return (null);
        }

        [Untrusted]
        public function querySort(dataClass:Class, ids:Object, fields:*, ascending:*=true):Object
        {
            return (null);
        }

        [Untrusted]
        public function querySortI18nId(data:*, fields:*, ascending:*=true)
        {
            return (null);
        }

        [Untrusted]
        public function getAllZaaps():Object
        {
            return (null);
        }

        [Untrusted]
        public function getUnknowZaaps(knwonZaapList:Object):Object
        {
            return (null);
        }

        [Untrusted]
        public function getAllVeteranRewards():Object
        {
            return (null);
        }

        [Untrusted]
        public function getComicReaderUrl(pComicRemoteId:String):String
        {
            return (null);
        }


    }
}//package d2api

