package d2api
{
   import d2data.Server;
   import d2data.ServerPopulation;
   import d2data.Breed;
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
   
   public class DataApi extends Object
   {
      
      public function DataApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getNotifications() : Object {
         return null;
      }
      
      public function getServer(id:int) : Server {
         return null;
      }
      
      public function getServerPopulation(id:int) : ServerPopulation {
         return null;
      }
      
      public function getBreed(id:int) : Breed {
         return null;
      }
      
      public function getBreeds() : Object {
         return null;
      }
      
      public function getHead(id:int) : Head {
         return null;
      }
      
      public function getHeads() : Object {
         return null;
      }
      
      public function getSpell(id:int) : Spell {
         return null;
      }
      
      public function getSpells() : Object {
         return null;
      }
      
      public function getSpellWrapper(id:uint, level:uint = 1) : SpellWrapper {
         return null;
      }
      
      public function getEmoteWrapper(id:uint, position:uint = 0) : EmoteWrapper {
         return null;
      }
      
      public function getButtonWrapper(buttonId:uint, position:int, uriName:String, callback:Function, name:String, shortcut:String = "") : ButtonWrapper {
         return null;
      }
      
      public function getJobs() : Object {
         return null;
      }
      
      public function getJobWrapper(id:uint) : JobWrapper {
         return null;
      }
      
      public function getTitleWrapper(id:uint) : TitleWrapper {
         return null;
      }
      
      public function getOrnamentWrapper(id:uint) : OrnamentWrapper {
         return null;
      }
      
      public function getSpellLevel(id:int) : SpellLevel {
         return null;
      }
      
      public function getSpellLevelBySpell(spell:Spell, level:int) : SpellLevel {
         return null;
      }
      
      public function getSpellType(id:int) : SpellType {
         return null;
      }
      
      public function getSpellState(id:int) : SpellState {
         return null;
      }
      
      public function getChatChannel(id:int) : ChatChannel {
         return null;
      }
      
      public function getAllChatChannels() : Object {
         return null;
      }
      
      public function getSubArea(id:int) : SubArea {
         return null;
      }
      
      public function getSubAreaFromMap(mapId:int) : SubArea {
         return null;
      }
      
      public function getAllSubAreas() : Object {
         return null;
      }
      
      public function getArea(id:int) : Area {
         return null;
      }
      
      public function getSuperArea(id:int) : SuperArea {
         return null;
      }
      
      public function getAllArea(withHouses:Boolean = false, withPaddocks:Boolean = false) : Object {
         return null;
      }
      
      public function getWorldPoint(id:int) : WorldPoint {
         return null;
      }
      
      public function getItem(id:int, returnDefaultItemIfNull:Boolean = true) : Item {
         return null;
      }
      
      public function getItems() : Object {
         return null;
      }
      
      public function getIncarnationLevel(incarnationId:int, level:int) : IncarnationLevel {
         return null;
      }
      
      public function getNewGenericSlotData() : Object {
         return null;
      }
      
      public function getItemIconUri(iconId:uint) : Object {
         return null;
      }
      
      public function getItemName(id:int) : String {
         return null;
      }
      
      public function getItemType(id:int) : String {
         return null;
      }
      
      public function getItemSet(id:int) : ItemSet {
         return null;
      }
      
      public function getPet(id:int) : Pet {
         return null;
      }
      
      public function getSetEffects(GIDList:Object, setBonus:Object = null) : Object {
         return null;
      }
      
      public function getMonsterFromId(monsterId:uint) : Monster {
         return null;
      }
      
      public function getMonsters() : Object {
         return null;
      }
      
      public function getMonsterMiniBossFromId(monsterId:uint) : MonsterMiniBoss {
         return null;
      }
      
      public function getMonsterRaceFromId(raceId:uint) : MonsterRace {
         return null;
      }
      
      public function getMonsterRaces() : Object {
         return null;
      }
      
      public function getMonsterSuperRaceFromId(raceId:uint) : MonsterSuperRace {
         return null;
      }
      
      public function getMonsterSuperRaces() : Object {
         return null;
      }
      
      public function getCompanion(companionId:uint) : Companion {
         return null;
      }
      
      public function getAllCompanions() : Object {
         return null;
      }
      
      public function getCompanionCharacteristic(companionCharacteristicId:uint) : CompanionCharacteristic {
         return null;
      }
      
      public function getCompanionSpell(companionSpellId:uint) : CompanionSpell {
         return null;
      }
      
      public function getNpc(npcId:uint) : Npc {
         return null;
      }
      
      public function getNpcAction(actionId:uint) : NpcAction {
         return null;
      }
      
      public function getAlignmentSide(sideId:uint) : AlignmentSide {
         return null;
      }
      
      public function getAlignmentBalance(percent:uint) : AlignmentBalance {
         return null;
      }
      
      public function getRankName(rankId:uint) : RankName {
         return null;
      }
      
      public function getAllRankNames() : Object {
         return null;
      }
      
      public function getItemWrapper(itemGID:uint, itemPosition:int = 0, itemUID:uint = 0, itemQuantity:uint = 0, itemEffects:* = null) : ItemWrapper {
         return null;
      }
      
      public function getItemFromUId(objectUID:uint) : ItemWrapper {
         return null;
      }
      
      public function getSkill(skillId:uint) : Skill {
         return null;
      }
      
      public function getHouseSkills() : Object {
         return null;
      }
      
      public function getInfoMessage(infoMsgId:uint) : InfoMessage {
         return null;
      }
      
      public function getAllInfoMessages() : Object {
         return null;
      }
      
      public function getSmiliesWrapperForPlayers() : Object {
         return null;
      }
      
      public function getSmiley(id:uint) : Smiley {
         return null;
      }
      
      public function getAllSmiley() : Object {
         return null;
      }
      
      public function getTaxCollectorName(id:uint) : TaxCollectorName {
         return null;
      }
      
      public function getTaxCollectorFirstname(id:uint) : TaxCollectorFirstname {
         return null;
      }
      
      public function getEmblems() : Object {
         return null;
      }
      
      public function getEmblemSymbol(symbolId:int) : EmblemSymbol {
         return null;
      }
      
      public function getAllEmblemSymbolCategories() : Object {
         return null;
      }
      
      public function getQuest(questId:int) : Quest {
         return null;
      }
      
      public function getQuestCategory(questCatId:int) : QuestCategory {
         return null;
      }
      
      public function getQuestObjective(questObjectiveId:int) : QuestObjective {
         return null;
      }
      
      public function getQuestStep(questStepId:int) : QuestStep {
         return null;
      }
      
      public function getAchievement(achievementId:int) : Achievement {
         return null;
      }
      
      public function getAchievements() : Object {
         return null;
      }
      
      public function getAchievementCategory(achievementCatId:int) : AchievementCategory {
         return null;
      }
      
      public function getAchievementCategories() : Object {
         return null;
      }
      
      public function getAchievementReward(rewardId:int) : AchievementReward {
         return null;
      }
      
      public function getAchievementRewards() : Object {
         return null;
      }
      
      public function getAchievementObjective(objectiveId:int) : AchievementObjective {
         return null;
      }
      
      public function getAchievementObjectives() : Object {
         return null;
      }
      
      public function getHouse(houseId:int) : House {
         return null;
      }
      
      public function getLivingObjectSkins(item:ItemWrapper) : Object {
         return null;
      }
      
      public function getAbuseReasonName(abuseReasonId:uint) : AbuseReasons {
         return null;
      }
      
      public function getAllAbuseReasons() : Object {
         return null;
      }
      
      public function getPresetIcons() : Object {
         return null;
      }
      
      public function getPresetIcon(iconId:uint) : PresetIcon {
         return null;
      }
      
      public function getDungeons() : Object {
         return null;
      }
      
      public function getDungeon(dungeonId:uint) : Dungeon {
         return null;
      }
      
      public function getMapInfo(mapId:uint) : MapPosition {
         return null;
      }
      
      public function getWorldMap(mapId:uint) : WorldMap {
         return null;
      }
      
      public function getAllWorldMaps() : Object {
         return null;
      }
      
      public function getHintCategory(hintId:uint) : HintCategory {
         return null;
      }
      
      public function getHintCategories() : Object {
         return null;
      }
      
      public function getHousesInformations() : Object {
         return null;
      }
      
      public function getHouseInformations(doorId:uint) : HouseWrapper {
         return null;
      }
      
      public function getSpellPair(pairId:uint) : SpellPair {
         return null;
      }
      
      public function getBomb(bombId:uint) : SpellBomb {
         return null;
      }
      
      public function getPack(packId:uint) : Pack {
         return null;
      }
      
      public function getLegendaryTreasureHunt(huntId:uint) : LegendaryTreasureHunt {
         return null;
      }
      
      public function getLegendaryTreasureHunts() : Object {
         return null;
      }
      
      public function getTitle(titleId:uint) : Title {
         return null;
      }
      
      public function getTitles() : Object {
         return null;
      }
      
      public function getTitleCategory(titleCatId:uint) : TitleCategory {
         return null;
      }
      
      public function getTitleCategories() : Object {
         return null;
      }
      
      public function getOrnament(oId:uint) : Ornament {
         return null;
      }
      
      public function getOrnaments() : Object {
         return null;
      }
      
      public function getOptionalFeatureByKeyword(key:String) : OptionalFeature {
         return null;
      }
      
      public function getEffect(effectId:uint) : Effect {
         return null;
      }
      
      public function getAlmanaxEvent() : AlmanaxEvent {
         return null;
      }
      
      public function getAlmanaxZodiac() : AlmanaxZodiac {
         return null;
      }
      
      public function getAlmanaxMonth() : AlmanaxMonth {
         return null;
      }
      
      public function getAlmanaxCalendar(calendarId:uint) : AlmanaxCalendar {
         return null;
      }
      
      public function getExternalNotification(pExtNotifId:int) : ExternalNotification {
         return null;
      }
      
      public function getExternalNotifications() : Object {
         return null;
      }
      
      public function getActionDescriptionByName(name:String) : ActionDescription {
         return null;
      }
      
      public function queryString(dataClass:Class, field:String, pattern:String) : Object {
         return null;
      }
      
      public function queryEquals(dataClass:Class, field:String, value:*) : Object {
         return null;
      }
      
      public function queryUnion(... ids) : Object {
         return null;
      }
      
      public function queryIntersection(... ids) : Object {
         return null;
      }
      
      public function queryGreaterThan(dataClass:Class, field:String, value:*) : Object {
         return null;
      }
      
      public function querySmallerThan(dataClass:Class, field:String, value:*) : Object {
         return null;
      }
      
      public function queryReturnInstance(dataClass:Class, ids:Object) : Object {
         return null;
      }
      
      public function querySort(dataClass:Class, ids:Object, fields:*, ascending:* = true) : Object {
         return null;
      }
      
      public function querySortI18nId(data:*, fields:*, ascending:* = true) : * {
         return null;
      }
      
      public function getAllZaaps() : Object {
         return null;
      }
      
      public function getUnknowZaaps(knwonZaapList:Object) : Object {
         return null;
      }
   }
}
