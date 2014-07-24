package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.JobsApi;
   import d2api.SoundApi;
   import d2api.BindsApi;
   import d2api.ConfigApi;
   import d2api.PlayedCharacterApi;
   import d2api.DataApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2hooks.*;
   import d2actions.*;
   import enum.EnumTab;
   import d2data.OptionalFeature;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   
   public class Book extends Object
   {
      
      public function Book() {
         super();
      }
      
      private static var _shortcutColor:String;
      
      private static var _self:Book;
      
      public static function getInstance() : Book {
         return _self;
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var jobsApi:JobsApi;
      
      public var soundApi:SoundApi;
      
      public var bindsApi:BindsApi;
      
      public var configApi:ConfigApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var dataApi:DataApi;
      
      public var uiCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_ongletSorts:ButtonContainer;
      
      public var btn_ongletQuetes:ButtonContainer;
      
      public var btn_ongletAlignment:ButtonContainer;
      
      public var btn_ongletMetiers:ButtonContainer;
      
      public var btn_ongletCalendar:ButtonContainer;
      
      public var btn_ongletAchievement:ButtonContainer;
      
      public var btn_ongletTitle:ButtonContainer;
      
      public var btn_ongletBestiary:ButtonContainer;
      
      public var btn_ongletKrosmaster:ButtonContainer;
      
      public var btn_ongletCompanion:ButtonContainer;
      
      private var _currentTabUi:String;
      
      private var _spellList:Object;
      
      public function main(oParam:Object = null) : void {
         this.sysApi.addHook(GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(GameFightStart,this.onGameFightStart);
         this.uiApi.addComponentHook(this.btn_ongletSorts,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletSorts,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletSorts,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletQuetes,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletQuetes,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletQuetes,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletAlignment,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletAlignment,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletAlignment,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletMetiers,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletMetiers,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletMetiers,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletCalendar,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletCalendar,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletCalendar,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletAchievement,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletAchievement,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletAchievement,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletTitle,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletTitle,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletTitle,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletBestiary,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletBestiary,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletBestiary,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletKrosmaster,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletKrosmaster,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletKrosmaster,"onRollOut");
         this.uiApi.addComponentHook(this.btn_ongletCompanion,"onRelease");
         this.uiApi.addComponentHook(this.btn_ongletCompanion,"onRollOver");
         this.uiApi.addComponentHook(this.btn_ongletCompanion,"onRollOut");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this._currentTabUi = null;
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
         this.btn_ongletSorts.soundId = SoundEnum.TAB;
         this.btn_ongletQuetes.soundId = SoundEnum.TAB;
         this.btn_ongletAlignment.soundId = SoundEnum.TAB;
         this.btn_ongletMetiers.soundId = SoundEnum.TAB;
         this.btn_ongletCalendar.soundId = SoundEnum.TAB;
         this.btn_ongletAchievement.soundId = SoundEnum.TAB;
         this.btn_ongletTitle.soundId = SoundEnum.TAB;
         this.btn_ongletBestiary.soundId = SoundEnum.TAB;
         this.btn_ongletKrosmaster.soundId = SoundEnum.TAB;
         this.btn_ongletCompanion.soundId = SoundEnum.TAB;
         _self = this;
         this.uiApi.addShortcutHook("closeUi",this.onShortCut);
         this.uiApi.addShortcutHook("openBookSpell",this.onShortCut);
         this.uiApi.addShortcutHook("openBookQuest",this.onShortCut);
         this.uiApi.addShortcutHook("openBookAlignment",this.onShortCut);
         this.uiApi.addShortcutHook("openBookJob",this.onShortCut);
         if(oParam != null)
         {
            this.openTab(oParam[0],oParam[1]);
         }
         else
         {
            this.openTab();
         }
      }
      
      private function onShortCut(s:String) : Boolean {
         switch(s)
         {
            case "openBookSpell":
               if(this._currentTabUi == EnumTab.SPELL_TAB)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(EnumTab.SPELL_TAB);
               }
               return true;
            case "openBookQuest":
               if(this._currentTabUi == EnumTab.QUEST_TAB)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(EnumTab.QUEST_TAB);
               }
               return true;
            case "openBookAlignment":
               if(this._currentTabUi == EnumTab.ALIGNMENT_TAB)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(EnumTab.ALIGNMENT_TAB);
               }
               return true;
            case "openBookJob":
               if((this._currentTabUi == EnumTab.JOB_TAB) || (!this.jobsApi.getKnownJobs()) || (this.jobsApi.getKnownJobs().length == 0))
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(EnumTab.JOB_TAB);
               }
               return true;
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function unload() : void {
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
         this.sysApi.enableWorldInteraction();
         Grimoire.getInstance().tabOpened = "";
         this.closeTab();
      }
      
      public function get spellList() : Object {
         return this._spellList;
      }
      
      public function openTab(tab:String = null, param:Object = null) : void {
         var tabName:String = null;
         var tabToShow:String = null;
         var lastTab:String = null;
         var jobs:Object = this.jobsApi.getKnownJobs();
         var feature:OptionalFeature = this.dataApi.getOptionalFeatureByKeyword("game.krosmaster");
         var disabledTab:Array = new Array();
         disabledTab[EnumTab.JOB_TAB] = jobs == null || jobs.length == 0;
         disabledTab[EnumTab.CALENDAR_TAB] = Grimoire.getInstance().isCalendarDisabled();
         disabledTab[EnumTab.KROSMASTER_TAB] = !this.configApi.isOptionalFeatureActive(feature.id);
         disabledTab[EnumTab.TITLE_TAB] = this.playerApi.isInFight();
         var tutorial:Object = this.uiApi.getUi(UIEnum.TUTORIAL_UI);
         if((tutorial) && (!tutorial.uiClass.tutorialDisabled))
         {
            disabledTab[EnumTab.ALIGNMENT_TAB] = true;
            disabledTab[EnumTab.JOB_TAB] = true;
            disabledTab[EnumTab.CALENDAR_TAB] = true;
            disabledTab[EnumTab.KROSMASTER_TAB] = true;
            disabledTab[EnumTab.ACHIEVEMENT_TAB] = true;
            disabledTab[EnumTab.TITLE_TAB] = true;
            disabledTab[EnumTab.BESTIARY_TAB] = true;
            disabledTab[EnumTab.COMPANION_TAB] = true;
         }
         this.getButtonByTabName(EnumTab.KROSMASTER_TAB).visible = !disabledTab[EnumTab.KROSMASTER_TAB];
         for(tabName in disabledTab)
         {
            this.getButtonByTabName(tabName).disabled = disabledTab[tabName];
         }
         if((tab == null) || (disabledTab[tab]))
         {
            lastTab = this.sysApi.getData("lastGrimoireTab");
            if((lastTab) && (!disabledTab[lastTab]))
            {
               tabToShow = lastTab;
            }
            else
            {
               tabToShow = EnumTab.SPELL_TAB;
            }
         }
         else
         {
            tabToShow = tab;
         }
         if(tabToShow == this._currentTabUi)
         {
            return;
         }
         if(this._currentTabUi)
         {
            this.uiApi.unloadUi(this._currentTabUi);
         }
         this._currentTabUi = tabToShow;
         this.sysApi.setData("lastGrimoireTab",this._currentTabUi);
         Grimoire.getInstance().tabOpened = this._currentTabUi;
         this.uiApi.loadUiInside(tabToShow,this.uiCtr,tabToShow,param);
         this.uiApi.setRadioGroupSelectedItem("tabGroup",this.getButtonByTabName(this._currentTabUi),this.uiApi.me());
         this.getButtonByTabName(this._currentTabUi).selected = true;
      }
      
      private function closeTab(tab:String = null) : void {
         var tabToClose:String = null;
         if(tab == null)
         {
            if(this._currentTabUi)
            {
               tabToClose = this._currentTabUi;
            }
            else
            {
               tabToClose = tab;
            }
         }
         if(tabToClose)
         {
            this.uiApi.unloadUi(tabToClose);
         }
      }
      
      private function getButtonByTabName(tabName:String) : Object {
         var returnButton:Object = null;
         switch(tabName)
         {
            case EnumTab.SPELL_TAB:
               returnButton = this.btn_ongletSorts;
               break;
            case EnumTab.QUEST_TAB:
               returnButton = this.btn_ongletQuetes;
               break;
            case EnumTab.ALIGNMENT_TAB:
               returnButton = this.btn_ongletAlignment;
               break;
            case EnumTab.JOB_TAB:
               returnButton = this.btn_ongletMetiers;
               break;
            case EnumTab.CALENDAR_TAB:
               returnButton = this.btn_ongletCalendar;
               break;
            case EnumTab.ACHIEVEMENT_TAB:
               returnButton = this.btn_ongletAchievement;
               break;
            case EnumTab.TITLE_TAB:
               returnButton = this.btn_ongletTitle;
               break;
            case EnumTab.BESTIARY_TAB:
               returnButton = this.btn_ongletBestiary;
               break;
            case EnumTab.COMPANION_TAB:
               returnButton = this.btn_ongletCompanion;
               break;
            case EnumTab.KROSMASTER_TAB:
               returnButton = this.btn_ongletKrosmaster;
               break;
         }
         return returnButton;
      }
      
      private function onSpellsList(spellList:Object) : void {
         this._spellList = spellList;
      }
      
      public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int) : void {
         if(this._currentTabUi == EnumTab.TITLE_TAB)
         {
            this.openTab(EnumTab.SPELL_TAB);
         }
      }
      
      public function onGameFightStart() : void {
         if(this._currentTabUi == EnumTab.TITLE_TAB)
         {
            this.openTab(EnumTab.SPELL_TAB);
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.sysApi.enableWorldInteraction();
               this.uiApi.unloadUi(UIEnum.GRIMOIRE);
               return;
            case this.btn_ongletSorts:
               this.openTab(EnumTab.SPELL_TAB);
               this.sysApi.dispatchHook(OpenGrimoireSpellTab);
               this.sysApi.enableWorldInteraction();
               break;
            case this.btn_ongletQuetes:
               this.openTab(EnumTab.QUEST_TAB);
               this.sysApi.dispatchHook(OpenGrimoireQuestTab);
               break;
            case this.btn_ongletAlignment:
               this.openTab(EnumTab.ALIGNMENT_TAB);
               this.sysApi.dispatchHook(OpenGrimoireAlignmentTab);
               break;
            case this.btn_ongletMetiers:
               this.openTab(EnumTab.JOB_TAB);
               this.sysApi.dispatchHook(OpenGrimoireJobTab);
               break;
            case this.btn_ongletCalendar:
               this.openTab(EnumTab.CALENDAR_TAB);
               this.sysApi.dispatchHook(OpenGrimoireCalendarTab);
               break;
            case this.btn_ongletAchievement:
               this.openTab(EnumTab.ACHIEVEMENT_TAB);
               break;
            case this.btn_ongletTitle:
               this.openTab(EnumTab.TITLE_TAB);
               break;
            case this.btn_ongletBestiary:
               this.openTab(EnumTab.BESTIARY_TAB);
               break;
            case this.btn_ongletCompanion:
               this.openTab(EnumTab.COMPANION_TAB);
               break;
            case this.btn_ongletKrosmaster:
               this.openTab(EnumTab.KROSMASTER_TAB);
               break;
         }
         if(Grimoire.getInstance().tabOpened != "")
         {
            this.sysApi.disableWorldInteraction();
         }
         else
         {
            this.sysApi.enableWorldInteraction();
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var data:Object = null;
         var point:uint = 8;
         var relPoint:uint = 1;
         var shortcutKey:String = null;
         switch(target)
         {
            case this.btn_ongletSorts:
               tooltipText = this.uiApi.getText("ui.grimoire.mySpell");
               shortcutKey = this.bindsApi.getShortcutBindStr("openBookSpell");
               break;
            case this.btn_ongletQuetes:
               tooltipText = this.uiApi.getText("ui.common.quests");
               shortcutKey = this.bindsApi.getShortcutBindStr("openBookQuest");
               break;
            case this.btn_ongletAlignment:
               tooltipText = this.uiApi.getText("ui.common.alignment");
               shortcutKey = this.bindsApi.getShortcutBindStr("openBookAlignment");
               break;
            case this.btn_ongletMetiers:
               tooltipText = this.uiApi.getText("ui.common.myJobs");
               shortcutKey = this.bindsApi.getShortcutBindStr("openBookJob");
               break;
            case this.btn_ongletCalendar:
               tooltipText = this.uiApi.getText("ui.almanax.almanax");
               shortcutKey = this.bindsApi.getShortcutBindStr("openAlmanax");
               break;
            case this.btn_ongletAchievement:
               tooltipText = this.uiApi.getText("ui.achievement.achievement");
               shortcutKey = this.bindsApi.getShortcutBindStr("openAchievement");
               break;
            case this.btn_ongletTitle:
               tooltipText = this.uiApi.getText("ui.common.titles");
               shortcutKey = this.bindsApi.getShortcutBindStr("openTitle");
               break;
            case this.btn_ongletBestiary:
               tooltipText = this.uiApi.getText("ui.common.bestiary");
               shortcutKey = this.bindsApi.getShortcutBindStr("openBestiary");
               break;
            case this.btn_ongletCompanion:
               tooltipText = this.uiApi.getText("ui.companion.companions");
               break;
            case this.btn_ongletKrosmaster:
               tooltipText = this.uiApi.getText("ui.krosmaster.krosmaster");
               break;
         }
         if(shortcutKey)
         {
            if(!_shortcutColor)
            {
               _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
               _shortcutColor = _shortcutColor.replace("0x","#");
            }
            data = this.uiApi.textTooltipInfo(tooltipText + " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>");
         }
         else
         {
            data = this.uiApi.textTooltipInfo(tooltipText);
         }
         this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
