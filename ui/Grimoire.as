package 
{
   import flash.display.Sprite;
   import ui.Book;
   import ui.SpellTab;
   import ui.ObjectTab;
   import ui.AlignmentTab;
   import ui.BestiaryTab;
   import ui.QuestTab;
   import ui.JobTab;
   import ui.KrosmasterTab;
   import ui.items.JobRecipeItem;
   import ui.items.SkillItem;
   import ui.items.GiftXmlItem;
   import ui.JobCraftOptions;
   import ui.CalendarTab;
   import ui.AchievementTab;
   import ui.TitleTab;
   import ui.CompanionTab;
   import d2api.JobsApi;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.NotificationApi;
   import d2api.TimeApi;
   import d2api.PlayedCharacterApi;
   import d2api.QuestApi;
   import d2data.AlmanaxMonth;
   import d2data.AlmanaxZodiac;
   import d2data.AlmanaxEvent;
   import d2data.AlmanaxCalendar;
   import d2data.Npc;
   import d2data.MonsterSuperRace;
   import d2data.Area;
   import d2data.MonsterRace;
   import d2data.SubArea;
   import ui.API;
   import d2hooks.*;
   import d2actions.*;
   import enum.EnumTab;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   
   public class Grimoire extends Sprite
   {
      
      public function Grimoire() {
         super();
      }
      
      private static var _self:Grimoire;
      
      public static function getInstance() : Grimoire {
         return _self;
      }
      
      protected var grimoire:Book = null;
      
      protected var spellTab:SpellTab = null;
      
      protected var objectTab:ObjectTab = null;
      
      protected var alignmentTab:AlignmentTab = null;
      
      protected var bestiaryTab:BestiaryTab = null;
      
      protected var questTab:QuestTab = null;
      
      protected var jobTab:JobTab = null;
      
      protected var krosmasterTab:KrosmasterTab = null;
      
      protected var jobRecipeItem:JobRecipeItem = null;
      
      protected var skillItem:SkillItem = null;
      
      protected var giftXmlItem:GiftXmlItem = null;
      
      protected var jobCraftOptions:JobCraftOptions = null;
      
      protected var calendarTab:CalendarTab = null;
      
      protected var achievementTab:AchievementTab = null;
      
      protected var titleTab:TitleTab = null;
      
      protected var companionTab:CompanionTab = null;
      
      public var jobsApi:JobsApi;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var notifApi:NotificationApi;
      
      public var timeApi:TimeApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var questApi:QuestApi;
      
      public var previousUi:String;
      
      public var currentUi:String;
      
      public var tabOpened:String = "";
      
      private var _spellList:Object;
      
      private var _recipeSlotsNumber:int;
      
      private var _dateId:int;
      
      private var _monthInfo:AlmanaxMonth;
      
      private var _zodiacInfo:AlmanaxZodiac;
      
      private var _eventInfo:AlmanaxEvent;
      
      private var _calendar:AlmanaxCalendar;
      
      private var _meryde:Npc;
      
      private var _finishedAchievementsId:Array;
      
      private var _objectivesTextByAchievement:Array;
      
      private var _lastAchievementOpenedId:int;
      
      private var _lastAchievementSearchCriteria:String = "";
      
      private var _lastAchievementCategoryOpenedId:int;
      
      private var _lastAchievementScrollValue:int;
      
      private var _monsterRaces:Array;
      
      private var _monsterAreas:Array;
      
      private var _titleCurrentTab:int;
      
      private var _bestiaryDisplayCriteriaDrop:Boolean = false;
      
      private var _bestiarySearchOnName:Boolean = true;
      
      private var _bestiarySearchOnDrop:Boolean = true;
      
      private var _achievementSearchOnName:Boolean = true;
      
      private var _achievementSearchOnObjective:Boolean = true;
      
      private var _achievementSearchOnReward:Boolean = true;
      
      private var _questSearchOnName:Boolean = true;
      
      private var _questSearchOnCategory:Boolean = true;
      
      public function main() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function get recipeSlotsNumber() : int {
         return this._recipeSlotsNumber;
      }
      
      public function set recipeSlotsNumber(value:int) : void {
         this._recipeSlotsNumber = value;
      }
      
      public function get calendarInfos() : Object {
         var calendarObj:Object = 
            {
               "month":this._monthInfo,
               "zodiac":this._zodiacInfo,
               "event":this._eventInfo,
               "calendar":this._calendar,
               "meryde":this._meryde
            };
         return calendarObj;
      }
      
      public function isCalendarDisabled() : Boolean {
         return this._dateId == -1;
      }
      
      public function get finishedAchievementsIds() : Array {
         return this._finishedAchievementsId;
      }
      
      public function get objectivesTextByAchievement() : Array {
         return this._objectivesTextByAchievement;
      }
      
      public function set objectivesTextByAchievement(a:Array) : void {
         this._objectivesTextByAchievement = a;
      }
      
      public function get monsterRaces() : Array {
         return this._monsterRaces;
      }
      
      public function set monsterRaces(a:Array) : void {
         this._monsterRaces = a;
      }
      
      public function get monsterAreas() : Array {
         return this._monsterAreas;
      }
      
      public function set monsterAreas(a:Array) : void {
         this._monsterAreas = a;
      }
      
      public function get lastAchievementOpenedId() : int {
         return this._lastAchievementOpenedId;
      }
      
      public function set lastAchievementOpenedId(id:int) : void {
         this._lastAchievementOpenedId = id;
      }
      
      public function get lastAchievementCategoryOpenedId() : int {
         return this._lastAchievementCategoryOpenedId;
      }
      
      public function set lastAchievementCategoryOpenedId(id:int) : void {
         this._lastAchievementCategoryOpenedId = id;
      }
      
      public function get lastAchievementScrollValue() : int {
         return this._lastAchievementScrollValue;
      }
      
      public function set lastAchievementScrollValue(v:int) : void {
         this._lastAchievementScrollValue = v;
      }
      
      public function get lastAchievementSearchCriteria() : String {
         return this._lastAchievementSearchCriteria;
      }
      
      public function set lastAchievementSearchCriteria(s:String) : void {
         this._lastAchievementSearchCriteria = s;
      }
      
      public function get titleCurrentTab() : int {
         return this._titleCurrentTab;
      }
      
      public function set titleCurrentTab(t:int) : void {
         this._titleCurrentTab = t;
      }
      
      public function get bestiaryDisplayCriteriaDrop() : Boolean {
         return this._bestiaryDisplayCriteriaDrop;
      }
      
      public function set bestiaryDisplayCriteriaDrop(b:Boolean) : void {
         this._bestiaryDisplayCriteriaDrop = b;
      }
      
      public function get bestiarySearchOnDrop() : Boolean {
         return this._bestiarySearchOnDrop;
      }
      
      public function set bestiarySearchOnDrop(b:Boolean) : void {
         this._bestiarySearchOnDrop = b;
      }
      
      public function get bestiarySearchOnName() : Boolean {
         return this._bestiarySearchOnName;
      }
      
      public function set bestiarySearchOnName(b:Boolean) : void {
         this._bestiarySearchOnName = b;
      }
      
      public function get achievementSearchOnName() : Boolean {
         return this._achievementSearchOnName;
      }
      
      public function set achievementSearchOnName(b:Boolean) : void {
         this._achievementSearchOnName = b;
      }
      
      public function get achievementSearchOnObjective() : Boolean {
         return this._achievementSearchOnObjective;
      }
      
      public function set achievementSearchOnObjective(b:Boolean) : void {
         this._achievementSearchOnObjective = b;
      }
      
      public function get achievementSearchOnReward() : Boolean {
         return this._achievementSearchOnReward;
      }
      
      public function set achievementSearchOnReward(b:Boolean) : void {
         this._achievementSearchOnReward = b;
      }
      
      public function get questSearchOnName() : Boolean {
         return this._questSearchOnName;
      }
      
      public function set questSearchOnName(b:Boolean) : void {
         this._questSearchOnName = b;
      }
      
      public function get questSearchOnCategory() : Boolean {
         return this._questSearchOnCategory;
      }
      
      public function set questSearchOnCategory(b:Boolean) : void {
         this._questSearchOnCategory = b;
      }
      
      private function onOpenGrimoire(tab:String = null, param:Object = null) : void {
         if((this.tabOpened == EnumTab.QUEST_TAB && tab == EnumTab.QUEST_TAB || this.tabOpened == EnumTab.ACHIEVEMENT_TAB && tab == EnumTab.ACHIEVEMENT_TAB || this.tabOpened == EnumTab.TITLE_TAB && tab == EnumTab.TITLE_TAB || this.tabOpened == EnumTab.BESTIARY_TAB && tab == EnumTab.BESTIARY_TAB) && (param) && (param.forceOpen))
         {
            return;
         }
         if((tab == EnumTab.CALENDAR_TAB) && (!this.questApi.getCompletedQuests()))
         {
            return;
         }
         if((tab == EnumTab.SPELL_TAB) && (!this.playerApi.characteristics()))
         {
            return;
         }
         if(this.tabOpened == "")
         {
            if(tab == EnumTab.JOB_TAB)
            {
               if((!this.jobsApi.getKnownJobs()) || (this.jobsApi.getKnownJobs().length == 0))
               {
                  return;
               }
            }
            else if(tab == EnumTab.CALENDAR_TAB)
            {
               if(this._dateId == -1)
               {
                  return;
               }
            }
            else if(tab == EnumTab.TITLE_TAB)
            {
               if(this.playerApi.isInFight())
               {
                  return;
               }
            }
            
            
            this.tabOpened = tab;
            if(this.uiApi.getUi(UIEnum.CHARACTER_SHEET_UI))
            {
               this.uiApi.unloadUi(UIEnum.CHARACTER_SHEET_UI);
            }
            this.uiApi.loadUi(UIEnum.GRIMOIRE,UIEnum.GRIMOIRE,[tab,param]);
            this.sysApi.disableWorldInteraction();
         }
         else if(this.tabOpened == tab)
         {
            this.uiApi.unloadUi(UIEnum.GRIMOIRE);
            this.sysApi.enableWorldInteraction();
         }
         else
         {
            if(tab == EnumTab.JOB_TAB)
            {
               if((!this.jobsApi.getKnownJobs()) || (this.jobsApi.getKnownJobs().length == 0))
               {
                  return;
               }
            }
            else if(tab == EnumTab.CALENDAR_TAB)
            {
               if(this._dateId == -1)
               {
                  return;
               }
            }
            else if(tab == EnumTab.TITLE_TAB)
            {
               if(this.playerApi.isInFight())
               {
                  return;
               }
            }
            
            
            this.tabOpened = tab;
            this.uiApi.getUi(UIEnum.GRIMOIRE).uiClass.openTab(tab,param);
         }
         
      }
      
      private function onSpellsList(spellList:Object) : void {
         this._spellList = spellList;
      }
      
      private function onOpenSpellInterface(spellId:uint) : void {
         if(!this.uiApi.getUi(UIEnum.GRIMOIRE))
         {
            if(!this.playerApi.characteristics())
            {
               return;
            }
            this.uiApi.loadUi(UIEnum.GRIMOIRE,UIEnum.GRIMOIRE,[EnumTab.SPELL_TAB,spellId]);
            this.sysApi.disableWorldInteraction();
         }
         else if(!this.uiApi.getUi(EnumTab.SPELL_TAB))
         {
            Book.getInstance().openTab(EnumTab.SPELL_TAB,spellId);
         }
         else
         {
            SpellTab.getInstance().selectSpell(spellId);
         }
         
      }
      
      private function onCalendarDate(dateId:int) : void {
         var calendarUi:Object = null;
         var lastNotif:* = 0;
         var notifId:uint = 0;
         if(dateId != this._dateId)
         {
            calendarUi = this.uiApi.getUi(EnumTab.CALENDAR_TAB);
            this._dateId = dateId;
            if(dateId > -1)
            {
               this._calendar = this.dataApi.getAlmanaxCalendar(dateId);
               this._monthInfo = this.dataApi.getAlmanaxMonth();
               this._zodiacInfo = this.dataApi.getAlmanaxZodiac();
               this._eventInfo = this.dataApi.getAlmanaxEvent();
               this._meryde = this.dataApi.getNpc(this._calendar.npcId);
               if((calendarUi) && (calendarUi.uiClass))
               {
                  calendarUi.uiClass.updateCalendarInfos();
               }
            }
            else if(calendarUi)
            {
               this.uiApi.unloadUi(UIEnum.GRIMOIRE);
               this.sysApi.enableWorldInteraction();
            }
            
         }
         if(!this.sysApi.getData("hideAlmanaxDailyNotif"))
         {
            lastNotif = this.sysApi.getData("lastAlmanaxNotif");
            if(lastNotif != this._dateId)
            {
               notifId = this.notifApi.prepareNotification(this.timeApi.getDofusDate(),this.uiApi.getText("ui.almanax.offeringTo",this._meryde.name),2,"notifAlmanax");
               this.notifApi.addButtonToNotification(notifId,this.uiApi.getText("ui.almanax.almanax"),"OpenBook",["calendarTab"],true,130);
               this.notifApi.sendNotification(notifId);
               this.sysApi.setData("lastAlmanaxNotif",this._dateId);
            }
         }
      }
      
      private function onAchievementList(finishedAchievementsIds:Object) : void {
         var id:* = 0;
         for each(id in finishedAchievementsIds)
         {
            this._finishedAchievementsId.push(id);
         }
      }
      
      private function onAchievementFinished(finishedAchievementId:int) : void {
         this._finishedAchievementsId.push(finishedAchievementId);
      }
   }
}
