package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.TooltipApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2api.QuestApi;
   import d2api.PlayedCharacterApi;
   import d2api.ContextMenuApi;
   import d2api.AveragePricesApi;
   import d2api.SocialApi;
   import flash.utils.Timer;
   import flash.geom.ColorTransform;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import d2components.GraphicContainer;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2components.Input;
   import d2components.Texture;
   import d2components.Label;
   import d2data.Achievement;
   import d2data.AchievementCategory;
   import d2network.GuildMember;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import flash.events.TimerEvent;
   import d2data.ItemWrapper;
   import d2data.EmoteWrapper;
   import d2data.SpellWrapper;
   import d2data.TitleWrapper;
   import d2data.OrnamentWrapper;
   import flash.utils.getTimer;
   import d2data.AchievementObjective;
   import d2data.AchievementReward;
   import d2data.Item;
   import d2data.Emoticon;
   import d2data.Spell;
   import d2data.Title;
   import d2data.Ornament;
   import d2network.AchievementRewardable;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import d2enums.LocationEnum;
   import flash.ui.Keyboard;
   import flash.utils.clearTimeout;
   
   public class AchievementTab extends Object
   {
      
      public function AchievementTab() {
         this._categories = new Array();
         this._progressCategories = new Array();
         this._finishedAchievementsId = new Array();
         this._objectivesTextByAchievementId = new Array();
         this._colorTransform = new ColorTransform();
         this._catFinishedAchievements = new Dictionary(true);
         this._catProgressingAchievements = new Dictionary(true);
         this._catIlluBtnList = new Dictionary(true);
         this._catProgressBarList = new Dictionary(true);
         this._ctrAchPointsList = new Dictionary(true);
         this._ctrAchBtnsList = new Dictionary(true);
         this._rewardsListList = new Dictionary(true);
         this._btnsAcceptRewardList = new Dictionary(true);
         this._ctrObjectiveMetaList = new Dictionary(true);
         this._searchTextByCriteriaList = new Dictionary(true);
         this._searchResultByCriteriaList = new Dictionary(true);
         super();
      }
      
      private static var CTR_CAT_TYPE_CAT:String = "ctr_cat";
      
      private static var CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
      
      private static var CTR_ACH_ACHIEVEMENT:String = "ctr_achievement";
      
      private static var CTR_ACH_OBJECTIVES:String = "ctr_objectives";
      
      private static var CTR_ACH_REWARDS:String = "ctr_rewards";
      
      private static var GAUGE_WIDTH_OBJECTIVE:int;
      
      private static var GAUGE_WIDTH_CATEGORY:int;
      
      private static var GAUGE_WIDTH_TOTAL:int;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var tooltipApi:TooltipApi;
      
      public var dataApi:DataApi;
      
      public var utilApi:UtilApi;
      
      public var questApi:QuestApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var menuApi:ContextMenuApi;
      
      public var averagePricesApi:AveragePricesApi;
      
      public var socialApi:SocialApi;
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      private var _succesPoints:int;
      
      private var _totalSuccesPoints:int;
      
      private var _openCatIndex:int;
      
      private var _currentSelectedCatId:int;
      
      private var _selectedAchievementId:int;
      
      private var _selectedAndOpenedAchievementId:int;
      
      private var _myGuildXp:int;
      
      private var _hideAchievedAchievement:Boolean = true;
      
      private var _lockSearchTimer:Timer;
      
      private var _previousSearchCriteria:String;
      
      private var _categories:Array;
      
      private var _progressCategories:Array;
      
      private var _finishedAchievementsId:Array;
      
      private var _objectivesTextByAchievementId:Array;
      
      private var _searchCriteria:String;
      
      private var _colorTransform:ColorTransform;
      
      private var _textShadow:GlowFilter;
      
      private var _forceOpenAchievement:Boolean;
      
      private var _currentScrollValue:int;
      
      private var _catFinishedAchievements:Dictionary;
      
      private var _catProgressingAchievements:Dictionary;
      
      private var _catIlluBtnList:Dictionary;
      
      private var _catProgressBarList:Dictionary;
      
      private var _ctrAchPointsList:Dictionary;
      
      private var _ctrAchBtnsList:Dictionary;
      
      private var _rewardsListList:Dictionary;
      
      private var _btnsAcceptRewardList:Dictionary;
      
      private var _ctrObjectiveMetaList:Dictionary;
      
      private var _dataAchievements:Object;
      
      private var _dataCategories:Object;
      
      private var _progressPopupName:String;
      
      private var _searchSettimoutId:uint;
      
      private var _searchTextByCriteriaList:Dictionary;
      
      private var _searchResultByCriteriaList:Dictionary;
      
      private var _searchOnName:Boolean;
      
      private var _searchOnObjective:Boolean;
      
      private var _searchOnReward:Boolean;
      
      public var ctr_achievements:GraphicContainer;
      
      public var ctr_summary:GraphicContainer;
      
      public var ctr_globalProgress:GraphicContainer;
      
      public var gd_categories:Grid;
      
      public var gd_achievements:Grid;
      
      public var gd_summary:Grid;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var btn_searchFilter:ButtonContainer;
      
      public var btn_hideCompletedAchievements:ButtonContainer;
      
      public var inp_search:Input;
      
      public var tx_inputBg:Texture;
      
      public var lbl_noAchievement:Label;
      
      public var lbl_myPoints:Label;
      
      public var lbl_titleProgress:Label;
      
      public var lbl_percent:Label;
      
      public var lbl_progress:Label;
      
      public var tx_progress:Texture;
      
      public function main(oParam:Object = null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function unload() : void {
         this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this._lockSearchTimer.stop();
         this._lockSearchTimer = null;
         this.sysApi.setData("hideCompletedAchievements",this._hideAchievedAchievement);
         Grimoire.getInstance().lastAchievementSearchCriteria = this._searchCriteria;
         Grimoire.getInstance().lastAchievementCategoryOpenedId = this._currentSelectedCatId;
         Grimoire.getInstance().lastAchievementOpenedId = this._selectedAndOpenedAchievementId;
         Grimoire.getInstance().lastAchievementScrollValue = this.gd_achievements.verticalScrollValue;
      }
      
      public function updateSummary(data:*, componentsRef:*, selected:Boolean) : void {
         var percent:* = 0;
         if(!this._catIlluBtnList[componentsRef.ctr_illu.name])
         {
            this.uiApi.addComponentHook(componentsRef.ctr_illu,ComponentHookList.ON_RELEASE);
         }
         this._catIlluBtnList[componentsRef.ctr_illu.name] = data;
         if(!this._catProgressBarList[componentsRef.ctr_progress.name])
         {
            this.uiApi.addComponentHook(componentsRef.ctr_progress,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ctr_progress,ComponentHookList.ON_ROLL_OUT);
         }
         this._catProgressBarList[componentsRef.ctr_progress.name] = data;
         if(data)
         {
            percent = Math.floor(data.value / data.total * 100);
            if(percent > 100)
            {
               percent = 100;
            }
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_name.filters = [this._textShadow];
            componentsRef.lbl_percent.text = percent + "%";
            componentsRef.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illusUi") + "illu_" + data.icon + ".png");
            componentsRef.ctr_illu.handCursor = true;
            this._colorTransform.color = data.color;
            componentsRef.tx_progress.transform.colorTransform = this._colorTransform;
            componentsRef.tx_progress.width = percent * GAUGE_WIDTH_CATEGORY / 100;
            componentsRef.ctr_summary.visible = true;
         }
         else
         {
            componentsRef.ctr_summary.visible = false;
         }
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void {
         var finishedNb:* = 0;
         var totalNb:* = 0;
         var ach:Object = null;
         var percent:* = 0;
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT_TYPE_CAT:
               if(data.icon)
               {
                  componentsRef.tx_catIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "" + data.icon);
               }
               else
               {
                  componentsRef.tx_catIcon.uri = null;
               }
            case CTR_CAT_TYPE_SUBCAT:
               componentsRef.lbl_catName.text = data.name;
               finishedNb = 0;
               totalNb = 0;
               if((data.id > 0) && (data.achievements) && (data.achievements.length > 0))
               {
                  for each(ach in data.achievements)
                  {
                     if(ach)
                     {
                        totalNb++;
                        if(this._finishedAchievementsId.indexOf(ach.id) != -1)
                        {
                           finishedNb++;
                        }
                     }
                  }
                  percent = Math.floor(finishedNb / totalNb * 100);
                  componentsRef.lbl_catPercent.text = percent + "%";
               }
               else
               {
                  componentsRef.lbl_catPercent.text = "";
               }
               componentsRef.btn_cat.selected = selected;
               break;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String {
         if(!data)
         {
            return "";
         }
         switch(line)
         {
            case 0:
               if((data) && (data.hasOwnProperty("subcats")))
               {
                  return CTR_CAT_TYPE_CAT;
               }
               return CTR_CAT_TYPE_SUBCAT;
            default:
               return CTR_CAT_TYPE_SUBCAT;
         }
      }
      
      public function getCatDataLength(data:*, selected:Boolean) : * {
         if(selected)
         {
            trace(data.title + " : " + (2 + (selected?data.subcats.length:0)));
         }
         return 2 + (selected?data.subcats.length:0);
      }
      
      public function updateAchievement(data:*, compRef:*, selected:Boolean, line:uint) : void {
         var ach:Object = null;
         var objective:Object = null;
         var completed:* = false;
         var obj:Object = null;
         var rewardsSlotContent:Array = null;
         var achId:* = 0;
         var value:* = 0;
         var maxValue:* = 0;
         var i:* = 0;
         var rewardId:uint = 0;
         var item:ItemWrapper = null;
         var emote:EmoteWrapper = null;
         var spell:SpellWrapper = null;
         var title:TitleWrapper = null;
         var ornament:OrnamentWrapper = null;
         switch(this.getAchievementLineType(data,line))
         {
            case CTR_ACH_ACHIEVEMENT:
               if(!this._ctrAchPointsList[compRef.ctr_achPoints.name])
               {
                  this.uiApi.addComponentHook(compRef.ctr_achPoints,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.ctr_achPoints,ComponentHookList.ON_ROLL_OUT);
               }
               this._ctrAchPointsList[compRef.ctr_achPoints.name] = data;
               if(!this._ctrAchBtnsList[compRef.btn_ach.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_ach,ComponentHookList.ON_RELEASE);
               }
               this._ctrAchBtnsList[compRef.btn_ach.name] = data;
               compRef.btn_ach.handCursor = true;
               compRef.lbl_name.text = data.name;
               compRef.lbl_points.text = data.points;
               compRef.lbl_description.text = data.description;
               compRef.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("achievementPath") + data.iconId + ".png");
               if((this._catFinishedAchievements[data.id]) || (!(this._finishedAchievementsId.indexOf(data.id) == -1)))
               {
                  compRef.tx_bg.gotoAndStop = 2;
               }
               else
               {
                  compRef.tx_bg.gotoAndStop = 1;
               }
               break;
            case CTR_ACH_OBJECTIVES:
               this._selectedAndOpenedAchievementId = this._selectedAchievementId;
               if(this._catProgressingAchievements[this._selectedAchievementId])
               {
                  ach = this._catProgressingAchievements[this._selectedAchievementId];
               }
               else if(this._catFinishedAchievements[this._selectedAchievementId])
               {
                  ach = this._catFinishedAchievements[this._selectedAchievementId];
               }
               
               if(!ach)
               {
                  break;
               }
               for each(obj in ach.finishedObjective)
               {
                  if(obj.id == data.objectiveData.id)
                  {
                     objective = obj;
                     completed = true;
                  }
               }
               if(!completed)
               {
                  for each(obj in ach.startedObjectives)
                  {
                     if(obj.id == data.objectiveData.id)
                     {
                        objective = obj;
                     }
                  }
               }
               if(!objective)
               {
                  break;
               }
               if(objective.maxValue == 1)
               {
                  compRef.lbl_objectiveBin.text = data.objectiveData.name;
                  if((completed) || (objective.value == 1))
                  {
                     compRef.tx_objectiveBin.gotoAndStop = "selected";
                     compRef.lbl_objectiveBin.alpha = 0.5;
                  }
                  else
                  {
                     compRef.tx_objectiveBin.gotoAndStop = "normal";
                     compRef.lbl_objectiveBin.alpha = 1;
                  }
                  compRef.ctr_objectiveBin.visible = true;
                  compRef.ctr_objectiveProgress.visible = false;
                  if(data.objectiveData.criterion.indexOf("OA") == 0)
                  {
                     if(!this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name])
                     {
                        this.uiApi.addComponentHook(compRef.ctr_objectiveBin,ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.ctr_objectiveBin,ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.ctr_objectiveBin,ComponentHookList.ON_RELEASE);
                     }
                     achId = int(data.objectiveData.criterion.substr(3));
                     this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = achId;
                     compRef.lbl_objectiveBin.text = compRef.lbl_objectiveBin.text + (" " + this.uiApi.getText("ui.common.fakeLinkSee"));
                     compRef.ctr_objectiveBin.handCursor = true;
                  }
                  else
                  {
                     compRef.ctr_objectiveBin.handCursor = false;
                     this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = 0;
                  }
               }
               else
               {
                  maxValue = objective.maxValue;
                  if(completed)
                  {
                     value = maxValue;
                  }
                  else
                  {
                     value = objective.value;
                  }
                  compRef.lbl_objectiveProgress.text = value + "/" + maxValue;
                  compRef.tx_objectiveProgress.width = int(value / maxValue * GAUGE_WIDTH_OBJECTIVE);
                  this._colorTransform.color = data.color;
                  compRef.tx_objectiveProgress.transform.colorTransform = this._colorTransform;
                  compRef.ctr_objectiveBin.visible = false;
                  compRef.ctr_objectiveProgress.visible = true;
               }
               break;
            case CTR_ACH_REWARDS:
               compRef.lbl_rewardsKama.text = this.utilApi.formateIntToString(data.kamas);
               compRef.lbl_rewardsXp.text = this.utilApi.formateIntToString(data.xp);
               if(data.rewardable)
               {
                  compRef.btn_accept.visible = true;
               }
               else
               {
                  compRef.btn_accept.visible = false;
               }
               rewardsSlotContent = new Array();
               if(data.rewardData)
               {
                  i = 0;
                  while(i < data.rewardData.itemsReward.length)
                  {
                     item = this.dataApi.getItemWrapper(data.rewardData.itemsReward[i],0,0,data.rewardData.itemsQuantityReward[i]);
                     rewardsSlotContent.push(item);
                     i++;
                  }
                  for each(rewardId in data.rewardData.emotesReward)
                  {
                     emote = this.dataApi.getEmoteWrapper(rewardId);
                     rewardsSlotContent.push(emote);
                  }
                  for each(rewardId in data.rewardData.spellsReward)
                  {
                     spell = this.dataApi.getSpellWrapper(rewardId);
                     rewardsSlotContent.push(spell);
                  }
                  for each(rewardId in data.rewardData.titlesReward)
                  {
                     title = this.dataApi.getTitleWrapper(rewardId);
                     rewardsSlotContent.push(title);
                  }
                  for each(rewardId in data.rewardData.ornamentsReward)
                  {
                     ornament = this.dataApi.getOrnamentWrapper(rewardId);
                     rewardsSlotContent.push(ornament);
                  }
               }
               compRef.gd_rewards.dataProvider = rewardsSlotContent;
               if(!this._rewardsListList[compRef.gd_rewards.name])
               {
                  this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OUT);
               }
               this._rewardsListList[compRef.gd_rewards.name] = data;
               if(!this._btnsAcceptRewardList[compRef.btn_accept.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_accept,ComponentHookList.ON_RELEASE);
                  this.uiApi.addComponentHook(compRef.btn_accept,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.btn_accept,ComponentHookList.ON_ROLL_OUT);
               }
               this._btnsAcceptRewardList[compRef.btn_accept.name] = this._selectedAchievementId;
               break;
         }
      }
      
      public function getAchievementLineType(data:*, line:uint) : String {
         if(!data)
         {
            return "";
         }
         switch(line)
         {
            case 0:
               if((data) && (data.hasOwnProperty("rewardData")))
               {
                  return CTR_ACH_REWARDS;
               }
               if((data) && (data.hasOwnProperty("objectiveData")))
               {
                  return CTR_ACH_OBJECTIVES;
               }
               return CTR_ACH_ACHIEVEMENT;
            default:
               return CTR_ACH_OBJECTIVES;
         }
      }
      
      public function getAchievementDataLength(data:*, selected:Boolean) : * {
         return 1;
      }
      
      private function updateAchievementGrid(catId:int) : void {
         var ach:Achievement = null;
         var category:AchievementCategory = null;
         var tempAchs:Array = null;
         var ts:uint = 0;
         var result:Object = null;
         var titleName:String = null;
         var critSplit:Array = null;
         var options:String = null;
         var nameResult:Object = null;
         var objectiveResult:Object = null;
         var rewardResult:Object = null;
         var achObj:Object = null;
         var currentCriteria:String = null;
         var wannabeCriteria:String = null;
         var crit:String = null;
         var index:int = 0;
         var indexToScroll:int = 0;
         var achievements:Array = new Array();
         this._selectedAndOpenedAchievementId = 0;
         if(!this._searchCriteria)
         {
            if(catId == 0)
            {
               this.ctr_achievements.visible = false;
               this.ctr_summary.visible = true;
               this._selectedAchievementId = 0;
            }
            else
            {
               this.ctr_achievements.visible = true;
               this.ctr_summary.visible = false;
               category = this.dataApi.getAchievementCategory(catId);
               tempAchs = new Array();
               for each(ach in category.achievements)
               {
                  if(ach)
                  {
                     if(!((this._hideAchievedAchievement) && (this._finishedAchievementsId.indexOf(ach.id) > -1)))
                     {
                        tempAchs.push(ach);
                     }
                  }
               }
               tempAchs.sortOn("order",Array.NUMERIC);
               for each(ach in tempAchs)
               {
                  achievements.push(ach);
                  achievements.push(null);
                  achievements.push(null);
                  if(ach.id == this._selectedAchievementId)
                  {
                     indexToScroll = index;
                     achievements = achievements.concat(this.addObjectivesAndRewards(ach,category));
                  }
                  index++;
                  index++;
                  index++;
               }
            }
         }
         else if(this._previousSearchCriteria != this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward)
         {
            ts = getTimer();
            titleName = this.playerApi.getPlayedCharacterInfo().sex == 0?"nameMale":"nameFemale";
            critSplit = this._previousSearchCriteria?this._previousSearchCriteria.split("#"):[];
            if(this._searchCriteria != critSplit[0])
            {
               nameResult = this.dataApi.queryUnion(this.dataApi.queryString(Achievement,"description",this._searchCriteria),this.dataApi.queryString(Achievement,"name",this._searchCriteria));
               objectiveResult = this.dataApi.queryEquals(Achievement,"objectiveIds",this.dataApi.queryString(AchievementObjective,"name",this._searchCriteria));
               rewardResult = this.dataApi.queryEquals(Achievement,"rewardIds",this.dataApi.queryUnion(this.dataApi.queryEquals(AchievementReward,"itemsReward",this.dataApi.queryString(Item,"name",this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"emotesReward",this.dataApi.queryString(Emoticon,"name",this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"spellsReward",this.dataApi.queryString(Spell,"name",this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"titlesReward",this.dataApi.queryString(Title,titleName,this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"ornamentsReward",this.dataApi.queryString(Ornament,"name",this._searchCriteria))));
               this._searchResultByCriteriaList["_searchOnName"] = nameResult;
               this._searchResultByCriteriaList["_searchOnObjective"] = objectiveResult;
               this._searchResultByCriteriaList["_searchOnReward"] = rewardResult;
               if((nameResult) || (objectiveResult) || (rewardResult))
               {
                  this.sysApi.log(2,"Result : " + ((nameResult?nameResult.length:0) + (objectiveResult?objectiveResult.length:0) + (rewardResult?rewardResult.length:0)) + " in " + (getTimer() - ts) + " ms");
               }
            }
            options = "" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward;
            switch(options)
            {
               case "truetruetrue":
                  result = this.dataApi.queryReturnInstance(Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"],this._searchResultByCriteriaList["_searchOnObjective"],this._searchResultByCriteriaList["_searchOnReward"]));
                  break;
               case "truetruefalse":
                  result = this.dataApi.queryReturnInstance(Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"],this._searchResultByCriteriaList["_searchOnObjective"]));
                  break;
               case "truefalsetrue":
                  result = this.dataApi.queryReturnInstance(Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"],this._searchResultByCriteriaList["_searchOnReward"]));
                  break;
               case "truefalsefalse":
                  result = this.dataApi.queryReturnInstance(Achievement,this._searchResultByCriteriaList["_searchOnName"]);
                  break;
               case "falsetruetrue":
                  result = this.dataApi.queryReturnInstance(Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnObjective"],this._searchResultByCriteriaList["_searchOnReward"]));
                  break;
               case "falsetruefalse":
                  result = this.dataApi.queryReturnInstance(Achievement,this._searchResultByCriteriaList["_searchOnObjective"]);
                  break;
               case "falsefalsetrue":
                  result = this.dataApi.queryReturnInstance(Achievement,this._searchResultByCriteriaList["_searchOnReward"]);
                  break;
               case "falsefalsefalse":
                  this.gd_achievements.dataProvider = new Array();
                  this.lbl_noAchievement.visible = true;
                  this.lbl_noAchievement.text = this.uiApi.getText("ui.search.needCriterion");
                  this._previousSearchCriteria = this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward;
                  return;
            }
            for each(ach in result)
            {
               if(!((this._hideAchievedAchievement) && (this._finishedAchievementsId.indexOf(ach.id) > -1)))
               {
                  achievements.push(ach);
                  achievements.push(null);
                  achievements.push(null);
                  if(ach.id == this._selectedAchievementId)
                  {
                     achievements = achievements.concat(this.addObjectivesAndRewards(ach,ach.category));
                  }
               }
            }
         }
         else
         {
            for each(achObj in this.gd_achievements.dataProvider)
            {
               if((achObj) && (achObj is Achievement))
               {
                  achievements.push(achObj);
                  achievements.push(null);
                  achievements.push(null);
                  if(achObj.id == this._selectedAchievementId)
                  {
                     indexToScroll = index;
                     achievements = achievements.concat(this.addObjectivesAndRewards(achObj as Achievement,achObj.category));
                  }
                  index++;
                  index++;
                  index++;
               }
            }
         }
         
         this.gd_achievements.dataProvider = achievements;
         if(this._forceOpenAchievement)
         {
            this._forceOpenAchievement = false;
            this.gd_achievements.moveTo(indexToScroll,true);
         }
         if(this._currentScrollValue != 0)
         {
            this.gd_achievements.verticalScrollValue = this._currentScrollValue;
         }
         if(achievements.length > 0)
         {
            this.lbl_noAchievement.visible = false;
         }
         else
         {
            this.lbl_noAchievement.visible = true;
            this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResult");
            if(this._searchCriteria)
            {
               currentCriteria = "";
               wannabeCriteria = "";
               for(crit in this._searchTextByCriteriaList)
               {
                  if(this[crit])
                  {
                     currentCriteria = currentCriteria + (this._searchTextByCriteriaList[crit] + ", ");
                  }
                  else if(this._searchResultByCriteriaList[crit].length > 0)
                  {
                     wannabeCriteria = wannabeCriteria + (this._searchTextByCriteriaList[crit] + ", ");
                  }
                  
               }
               if(currentCriteria.length > 0)
               {
                  currentCriteria = currentCriteria.slice(0,-2);
               }
               if(wannabeCriteria.length > 0)
               {
                  wannabeCriteria = wannabeCriteria.slice(0,-2);
               }
               if(wannabeCriteria.length == 0)
               {
                  this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultFor",this._searchCriteria);
               }
               else
               {
                  this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultsBut",currentCriteria,wannabeCriteria);
               }
            }
         }
         this._previousSearchCriteria = this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward;
      }
      
      private function addObjectivesAndRewards(ach:Achievement, category:AchievementCategory) : Array {
         var objectiveId:* = 0;
         var reward:Object = null;
         var rewardId:* = 0;
         var finishedLevel:* = 0;
         var rewardable:* = false;
         var o:AchievementObjective = null;
         var r:AchievementReward = null;
         var level:* = 0;
         var ar:AchievementRewardable = null;
         var achievements:Array = new Array();
         for each(objectiveId in ach.objectiveIds)
         {
            o = this.dataApi.getAchievementObjective(objectiveId);
            if(o)
            {
               if(category.parentId == 0)
               {
                  achievements.push(
                     {
                        "objectiveData":o,
                        "color":category.color
                     });
               }
               else
               {
                  achievements.push(
                     {
                        "objectiveData":o,
                        "color":this.dataApi.getAchievementCategory(category.parentId).color
                     });
               }
            }
         }
         reward = 
            {
               "rewardData":null,
               "kamas":0,
               "xp":0,
               "rewardable":false
            };
         for each(rewardId in ach.rewardIds)
         {
            r = this.dataApi.getAchievementReward(rewardId);
            if(r)
            {
               level = this.playerApi.getPlayedCharacterInfo().level;
               if(((r.levelMin == -1) || (r.levelMin <= level)) && ((r.levelMax >= level) || (r.levelMax == -1)))
               {
                  reward.rewardData = r;
                  break;
               }
            }
         }
         if(this._finishedAchievementsId.indexOf(ach.id) != -1)
         {
            for each(ar in this.questApi.getRewardableAchievements())
            {
               if(ar.id == ach.id)
               {
                  finishedLevel = ar.finishedlevel;
                  rewardable = true;
                  break;
               }
            }
         }
         reward.kamas = this.questApi.getAchievementKamasReward(ach,finishedLevel);
         reward.xp = this.questApi.getAchievementExperienceReward(ach,finishedLevel);
         reward.rewardable = rewardable;
         achievements.push(reward);
         achievements.push(null);
         achievements.push(null);
         return achievements;
      }
      
      private function updateCategories(selectedCategory:Object, forceOpen:Boolean = false, fakeOpen:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function updateGeneralInfo() : void {
         this.lbl_myPoints.text = this.utilApi.kamasToString(this._succesPoints,"");
         var percent:int = Math.floor(this._finishedAchievementsId.length / this._dataAchievements.length * 100);
         this.lbl_percent.text = percent + "%";
         this._colorTransform.color = 16761925;
         this.tx_progress.transform.colorTransform = this._colorTransform;
         this.tx_progress.width = int(this._finishedAchievementsId.length / this._dataAchievements.length * GAUGE_WIDTH_TOTAL);
      }
      
      private function getMountPercentXp() : int {
         var xpRatio:* = 0;
         if((!(this.playerApi.getMount() == null)) && (this.playerApi.isRidding()) && (this.playerApi.getMount().xpRatio > 0))
         {
            xpRatio = this.playerApi.getMount().xpRatio;
         }
         return xpRatio;
      }
      
      private function changeSearchOnName() : void {
         this._searchOnName = !this._searchOnName;
         Grimoire.getInstance().achievementSearchOnName = this._searchOnName;
         if((!this._searchOnName) && (!this._searchOnObjective) && (!this._searchOnReward))
         {
            this.inp_search.visible = false;
            this.tx_inputBg.disabled = true;
         }
         else
         {
            this.inp_search.visible = true;
            this.tx_inputBg.disabled = false;
         }
         if((this._searchCriteria) && (!(this._searchCriteria == "")))
         {
            this.updateAchievementGrid(this.gd_categories.selectedItem);
         }
      }
      
      private function changeSearchOnObjective() : void {
         this._searchOnObjective = !this._searchOnObjective;
         Grimoire.getInstance().achievementSearchOnObjective = this._searchOnObjective;
         if((!this._searchOnName) && (!this._searchOnObjective) && (!this._searchOnReward))
         {
            this.inp_search.visible = false;
            this.tx_inputBg.disabled = true;
         }
         else
         {
            this.inp_search.visible = true;
            this.tx_inputBg.disabled = false;
         }
         if((this._searchCriteria) && (!(this._searchCriteria == "")))
         {
            this.updateAchievementGrid(this.gd_categories.selectedItem);
         }
      }
      
      private function changeSearchOnReward() : void {
         this._searchOnReward = !this._searchOnReward;
         Grimoire.getInstance().achievementSearchOnReward = this._searchOnReward;
         if((!this._searchOnName) && (!this._searchOnObjective) && (!this._searchOnReward))
         {
            this.inp_search.visible = false;
            this.tx_inputBg.disabled = true;
         }
         else
         {
            this.inp_search.visible = true;
            this.tx_inputBg.disabled = false;
         }
         if((this._searchCriteria) && (!(this._searchCriteria == "")))
         {
            this.updateAchievementGrid(this.gd_categories.selectedItem);
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.gd_categories)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO)
            {
               this._searchCriteria = null;
               this.inp_search.text = "";
               this._currentScrollValue = 0;
               this.updateCategories(target.selectedItem);
            }
         }
      }
      
      public function onItemRightClick(target:Object, item:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if((item.data) && (!(target.name.indexOf("gd_rewards") == -1)))
         {
            data = item.data;
            if((data == null) || (!(data is ItemWrapper)))
            {
               return;
            }
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var text:String = null;
         var pos:Object = null;
         if((item.data) && (!(target.name.indexOf("gd_rewards") == -1)))
         {
            pos = 
               {
                  "point":LocationEnum.POINT_BOTTOM,
                  "relativePoint":LocationEnum.POINT_TOP
               };
            if(item.data is ItemWrapper)
            {
               text = item.data.name;
               text = text + this.averagePricesApi.getItemAveragePriceString(item.data,true);
            }
            else if(item.data is EmoteWrapper)
            {
               text = this.uiApi.getText("ui.common.emote",item.data.emote.name);
            }
            else if(item.data is SpellWrapper)
            {
               text = this.uiApi.getText("ui.common.spell",item.data.spell.name);
            }
            else if(item.data is TitleWrapper)
            {
               text = this.uiApi.getText("ui.common.title",item.data.title.name);
            }
            else if(item.data is OrnamentWrapper)
            {
               text = this.uiApi.getText("ui.common.ornament",item.data.name);
            }
            
            
            
            
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:Object) : void {
         var contextMenu:Array = null;
         var data:Object = null;
         var achievement:Achievement = null;
         var category:AchievementCategory = null;
         var achMetaId:* = 0;
         switch(target)
         {
            case this.btn_resetSearch:
               this._searchCriteria = null;
               this.inp_search.text = "";
               this.updateAchievementGrid(this.gd_categories.selectedItem.id);
               break;
            case this.btn_searchFilter:
               contextMenu = new Array();
               contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"],this.changeSearchOnName,null,false,null,this._searchOnName,false));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnObjective"],this.changeSearchOnObjective,null,false,null,this._searchOnObjective,false));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnReward"],this.changeSearchOnReward,null,false,null,this._searchOnReward,false));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_hideCompletedAchievements:
               this._hideAchievedAchievement = this.btn_hideCompletedAchievements.selected;
               this.updateAchievementGrid(this.gd_categories.selectedItem.id);
               break;
            default:
               if(target.name.indexOf("ctr_illu") != -1)
               {
                  this._searchCriteria = null;
                  this.inp_search.text = "";
                  this.gd_categories.selectedIndex = this._catIlluBtnList[target.name].order + 1;
               }
               else if(target.name.indexOf("btn_ach") != -1)
               {
                  if(this.uiApi.keyIsDown(Keyboard.SHIFT))
                  {
                     this.sysApi.dispatchHook(MouseShiftClick,{"data":this._ctrAchBtnsList[target.name]});
                     break;
                  }
                  data = this._ctrAchBtnsList[target.name];
                  if((this._selectedAchievementId == 0) || (!(this._selectedAchievementId == data.id)))
                  {
                     this.gd_achievements.selectedItem = data;
                     this._selectedAchievementId = data.id;
                  }
                  else
                  {
                     this._selectedAchievementId = 0;
                  }
                  if((this._selectedAchievementId > 0) && (!this._catProgressingAchievements[this._selectedAchievementId]) && (!this._catFinishedAchievements[this._selectedAchievementId]))
                  {
                     this.sysApi.sendAction(new AchievementDetailsRequest(this._selectedAchievementId));
                  }
                  else
                  {
                     this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                     if((!(this._searchCriteria == "")) && (!(this._searchCriteria == null)) && (this._selectedAchievementId > 0))
                     {
                        achievement = this.dataApi.getAchievement(this._selectedAchievementId);
                        category = this.dataApi.getAchievementCategory(achievement.categoryId);
                        this.updateCategories(category,true,true);
                     }
                  }
               }
               else if(target.name.indexOf("ctr_objectiveBin") != -1)
               {
                  achMetaId = this._ctrObjectiveMetaList[target.name];
                  if(achMetaId > 0)
                  {
                     this.uiApi.hideTooltip();
                     this.onOpenAchievement("achievementTab",
                        {
                           "forceOpen":true,
                           "achievementId":achMetaId
                        });
                  }
               }
               else if(target.name.indexOf("btn_accept") != -1)
               {
                  this.uiApi.hideTooltip();
                  this.sysApi.sendAction(new AchievementRewardRequest(this._btnsAcceptRewardList[target.name]));
               }
               
               
               
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var param:String = null;
         var achMetaId:* = 0;
         var achMeta:Achievement = null;
         var myMountXp:* = 0;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         switch(target)
         {
            case this.lbl_myPoints:
               param = this.utilApi.kamasToString(this._succesPoints,"") + " / " + this.utilApi.kamasToString(this._totalSuccesPoints,"");
               text = this.uiApi.processText(this.uiApi.getText("ui.achievement.successPoints",param),"n",false);
               break;
            case this.ctr_globalProgress:
               text = this._finishedAchievementsId.length + "/" + this._dataAchievements.length;
               break;
            case this.btn_searchFilter:
               text = this.uiApi.getText("ui.search.criteria");
               break;
            default:
               if(target.name.indexOf("ctr_achPoints") != -1)
               {
                  text = this.uiApi.getText("ui.achievement.successPointsText");
               }
               else if(target.name.indexOf("ctr_objectiveBin") != -1)
               {
                  achMetaId = this._ctrObjectiveMetaList[target.name];
                  if(achMetaId > 0)
                  {
                     achMeta = this.dataApi.getAchievement(achMetaId);
                     text = achMeta.description;
                  }
               }
               else if(target.name.indexOf("ctr_progress") != -1)
               {
                  text = this._catProgressBarList[target.name].value + "/" + this._catProgressBarList[target.name].total;
               }
               else if(target.name.indexOf("btn_accept") != -1)
               {
                  text = this.uiApi.getText("ui.achievement.rewardsGet");
                  myMountXp = this.getMountPercentXp();
                  if(myMountXp)
                  {
                     text = text + ("\n" + this.uiApi.getText("ui.achievement.mountXpPercent",myMountXp));
                  }
                  if(this._myGuildXp)
                  {
                     text = text + ("\n" + this.uiApi.getText("ui.achievement.guildXpPercent",this._myGuildXp));
                  }
               }
               
               
               
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if(this.inp_search.haveFocus)
         {
            this._lockSearchTimer.reset();
            this._lockSearchTimer.start();
         }
      }
      
      public function onTimeOut(e:TimerEvent) : void {
         if(this.inp_search.text.length > 2)
         {
            this._searchCriteria = this.inp_search.text.toLowerCase();
            this._currentScrollValue = 0;
            if(this._openCatIndex == 0)
            {
               this.ctr_achievements.visible = true;
               this.ctr_summary.visible = false;
            }
            this.updateAchievementGrid(this._currentSelectedCatId);
         }
         else
         {
            if(this._searchCriteria)
            {
               this._searchCriteria = null;
            }
            if(this.inp_search.text.length == 0)
            {
               this.updateAchievementGrid(this.gd_categories.selectedItem.id);
            }
         }
      }
      
      public function onParseObjectives(i:int = 0) : void {
         Grimoire.getInstance().objectivesTextByAchievement = this._objectivesTextByAchievementId;
         this.updateAchievementGrid(this.gd_categories.selectedItem.id);
         this.onCancelSearch();
      }
      
      private function onCancelSearch() : void {
         clearTimeout(this._searchSettimoutId);
         if(this._progressPopupName)
         {
            this.uiApi.unloadUi(this._progressPopupName);
            this._progressPopupName = null;
         }
      }
      
      private function onAchievementList(finishedAchievementsIds:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onAchievementFinished(finishedAchievementId:int) : void {
         var cat:Object = null;
         var finishedAch:Achievement = this.dataApi.getAchievement(finishedAchievementId);
         if(finishedAch)
         {
            this._succesPoints = this._succesPoints + finishedAch.points;
         }
         var catFrom:AchievementCategory = this.dataApi.getAchievementCategory(finishedAch.categoryId);
         for each(cat in this._progressCategories)
         {
            if((cat.id == catFrom.id) || (cat.id == catFrom.parentId))
            {
               cat.value = cat.value + 1;
            }
         }
         this.gd_summary.dataProvider = this._progressCategories;
         this._finishedAchievementsId.push(finishedAchievementId);
         this.updateGeneralInfo();
      }
      
      private function onAchievementDetailedList(finishedAchievements:Object, startedAchievements:Object) : void {
         var ach:Object = null;
         for each(this._catFinishedAchievements[ach.id] in finishedAchievements)
         {
            this._catProgressingAchievements[ach.id] = null;
         }
         for each(this._catProgressingAchievements[ach.id] in startedAchievements)
         {
            this._catFinishedAchievements[ach.id] = null;
         }
         this.updateAchievementGrid(this._currentSelectedCatId);
      }
      
      private function onAchievementDetails(achievement:Object) : void {
         if(this._finishedAchievementsId.indexOf(achievement.id) == -1)
         {
            this._catProgressingAchievements[achievement.id] = achievement;
            this._catFinishedAchievements[achievement.id] = null;
         }
         else
         {
            this._catFinishedAchievements[achievement.id] = achievement;
            this._catProgressingAchievements[achievement.id] = null;
         }
         this.updateAchievementGrid(this._currentSelectedCatId);
         var achievementData:Achievement = this.dataApi.getAchievement(achievement.id);
         var category:AchievementCategory = this.dataApi.getAchievementCategory(achievementData.categoryId);
         this.updateCategories(category,true,true);
      }
      
      private function onAchievementRewardSuccess(achievementId:int) : void {
         this.updateAchievementGrid(this._currentSelectedCatId);
      }
      
      public function onGuildInformationsMemberUpdate(member:Object) : void {
         if(member.id == this.playerApi.id())
         {
            this._myGuildXp = member.experienceGivenPercent;
         }
      }
      
      private function onOpenAchievement(tab:String = null, param:Object = null) : void {
         var achievement:Achievement = null;
         var category:AchievementCategory = null;
         if((tab == "achievementTab") && (param) && (param.forceOpen))
         {
            this._selectedAchievementId = param.achievementId;
            this.ctr_achievements.visible = true;
            this.ctr_summary.visible = false;
            this._forceOpenAchievement = true;
            this._searchCriteria = null;
            this.inp_search.text = "";
            if((!(this._finishedAchievementsId.indexOf(this._selectedAchievementId) == -1)) && (this._hideAchievedAchievement == true))
            {
               this._hideAchievedAchievement = false;
               this.btn_hideCompletedAchievements.selected = false;
            }
            achievement = this.dataApi.getAchievement(this._selectedAchievementId);
            category = this.dataApi.getAchievementCategory(achievement.categoryId);
            this.updateCategories(category,true);
         }
      }
   }
}
