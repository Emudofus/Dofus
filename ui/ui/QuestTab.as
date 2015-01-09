package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.QuestApi;
    import d2api.DataApi;
    import d2api.SoundApi;
    import d2api.UtilApi;
    import d2api.AveragePricesApi;
    import d2api.PlayedCharacterApi;
    import d2api.MapApi;
    import flash.utils.Dictionary;
    import d2components.Label;
    import flash.utils.Timer;
    import d2components.GraphicContainer;
    import d2components.Slot;
    import d2components.Texture;
    import d2components.TextArea;
    import d2components.Input;
    import d2components.ComboBox;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2hooks.QuestListUpdated;
    import d2hooks.QuestInfosUpdated;
    import d2hooks.TextureLoadFailed;
    import d2hooks.OpenBook;
    import d2hooks.FlagRemoved;
    import d2hooks.KeyUp;
    import flash.events.TimerEvent;
    import d2actions.QuestListRequest;
    import d2enums.StatesEnum;
    import d2data.QuestObjective;
    import d2enums.CompassTypeEnum;
    import d2data.QuestCategory;
    import flash.utils.getTimer;
    import d2data.Quest;
    import d2actions.QuestInfosRequest;
    import d2data.ItemWrapper;
    import d2data.EmoteWrapper;
    import d2data.JobWrapper;
    import d2data.QuestStep;
    import d2data.MapPosition;
    import d2data.SubArea;
    import d2hooks.AddMapFlag;
    import d2enums.SelectMethodEnum;
    import d2hooks.*;
    import d2actions.*;

    public class QuestTab 
    {

        private static var MAX_QUEST_FLAGS:int = 6;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var questApi:QuestApi;
        public var dataApi:DataApi;
        public var soundApi:SoundApi;
        public var utilApi:UtilApi;
        public var averagePricesApi:AveragePricesApi;
        public var playerApi:PlayedCharacterApi;
        public var mapApi:MapApi;
        [Module(name="Ankama_Cartography")]
        public var modCartography:Object;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _questsToShow:Array;
        private var _questActiveList:Array;
        private var _questCompletedList:Array;
        private var _questStepsList:Array;
        private var _iconRewards:Array;
        private var _questInfos:Object;
        private var _currentStep:uint;
        private var _displayedStep:uint;
        private var _currentIndexForStep:uint;
        private var _selectedQuest:uint;
        private var _gridLines:Array;
        private var _closedCategories:Array;
        private var _showCompletedQuest:Boolean;
        private var _bDescendingSort:Boolean = false;
        private var _aSlotsReward:Array;
        private var _rewards:Array;
        private var _previousRewardSelected:Object;
        private var _aSlotsObjective:Dictionary;
        private var _aObjectivesDialog:Dictionary;
        private var _selectedQuestCategory:int;
        private var _forceOpenCategory:Boolean = false;
        private var _stepNpcMessage:String;
        private var _boostBtnList:Dictionary;
        private var _displayTooltip:Boolean;
        private var _isInit:Boolean;
        private var _currentCategorySelected:Label;
        private var _previousSelectedItem:Object;
        private var _lockSearchTimer:Timer;
        private var _previousSearchCriteria:String;
        private var _searchCriteria:String;
        private var _searchTextByCriteriaList:Dictionary;
        private var _searchResultByCriteriaList:Dictionary;
        private var _searchOnName:Boolean;
        private var _searchOnCategory:Boolean;
        public var ctr_itemBlock:GraphicContainer;
        public var ctr_item:GraphicContainer;
        public var tx_reward_1:Slot;
        public var tx_reward_2:Slot;
        public var tx_reward_3:Slot;
        public var tx_reward_4:Slot;
        public var tx_reward_5:Slot;
        public var tx_reward_6:Slot;
        public var tx_reward_7:Slot;
        public var tx_reward_8:Slot;
        public var tx_reward_9:Slot;
        public var tx_reward_10:Slot;
        public var tx_dialog:Texture;
        public var tx_achieve:Texture;
        public var tx_rewardsXp:Texture;
        public var tx_rewardsKama:Texture;
        public var tx_inputBg:Texture;
        public var ent_npc:Object;
        public var txa_description:TextArea;
        public var lbl_stepName:Label;
        public var lbl_nbQuests:Label;
        public var lbl_objectives:Label;
        public var lbl_rewardsXp:Label;
        public var lbl_rewardsKama:Label;
        public var lbl_noQuest:Label;
        public var inp_search:Input;
        public var cbx_steps:ComboBox;
        public var btn_tabComplete:ButtonContainer;
        public var btn_tabName:ButtonContainer;
        public var btn_showCompletedQuests:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var btn_loc:ButtonContainer;
        public var btn_resetSearch:ButtonContainer;
        public var btn_searchFilter:ButtonContainer;
        public var gd_objectives:Grid;
        public var gd_quests:Grid;

        public function QuestTab()
        {
            this._boostBtnList = new Dictionary(true);
            this._searchTextByCriteriaList = new Dictionary(true);
            this._searchResultByCriteriaList = new Dictionary(true);
            super();
        }

        public function main(oParam:Object=null):void
        {
            var slot:Slot;
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.sysApi.addHook(QuestListUpdated, this.onQuestListUpdated);
            this.sysApi.addHook(QuestInfosUpdated, this.onQuestInfosUpdated);
            this.sysApi.addHook(TextureLoadFailed, this.onTextureLoadFailed);
            this.sysApi.addHook(OpenBook, this.onUpdateQuestTab);
            this.sysApi.addHook(FlagRemoved, this.onFlagRemoved);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addComponentHook(this.gd_quests, "onSelectItem");
            this._lockSearchTimer = new Timer(500, 1);
            this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._isInit = false;
            this._questActiveList = new Array();
            this._questCompletedList = new Array();
            this._questStepsList = new Array();
            this._iconRewards = new Array();
            this._aSlotsReward = new Array(this.tx_reward_1, this.tx_reward_2, this.tx_reward_3, this.tx_reward_4, this.tx_reward_5, this.tx_reward_6, this.tx_reward_7, this.tx_reward_8, this.tx_reward_9, this.tx_reward_10);
            this._gridLines = new Array();
            this._aSlotsObjective = new Dictionary();
            this._aObjectivesDialog = new Dictionary();
            this._searchTextByCriteriaList["_searchOnName"] = this.uiApi.getText("ui.common.name");
            this._searchTextByCriteriaList["_searchOnCategory"] = this.uiApi.getText("ui.common.category");
            this._searchOnCategory = Grimoire.getInstance().questSearchOnCategory;
            this._searchOnName = Grimoire.getInstance().questSearchOnName;
            for each (slot in this._aSlotsReward)
            {
                this.registerSlot(slot);
            };
            this.ctr_itemBlock.visible = false;
            this.sysApi.sendAction(new QuestListRequest());
            this.uiApi.addComponentHook(this.tx_dialog, "onRollOver");
            this.uiApi.addComponentHook(this.tx_dialog, "onRollOut");
            this.uiApi.addComponentHook(this.cbx_steps, "onSelectItem");
            this.uiApi.addShortcutHook("leftArrow", this.onShortCut);
            this.uiApi.addShortcutHook("rightArrow", this.onShortCut);
            if (((oParam) && (oParam.quest)))
            {
                this._selectedQuest = oParam.quest.id;
                this._forceOpenCategory = true;
            }
            else
            {
                this._selectedQuest = this.sysApi.getData("lastQuestSelected");
                this._forceOpenCategory = false;
            };
            if (this.dataApi.getQuest(this._selectedQuest))
            {
                this._selectedQuestCategory = this.dataApi.getQuest(this._selectedQuest).category.id;
            };
            this._closedCategories = this.sysApi.getData("closedQuestCategories");
            this._showCompletedQuest = this.sysApi.getData("showCompletedQuest");
            this._displayTooltip = this.sysApi.getOption("displayTooltips", "dofus");
        }

        public function unload():void
        {
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._lockSearchTimer.stop();
            this._lockSearchTimer = null;
            this.uiApi.unloadUi(("itemBox_" + this.uiApi.me().name));
        }

        public function updateItem(data:*, componentsRef:*, selected:Boolean):void
        {
            var quest:Object;
            var lvlQuest:String;
            if (data)
            {
                if (!(this._boostBtnList[componentsRef.questCtr.name]))
                {
                    this.uiApi.addComponentHook(componentsRef.questCtr, "onRollOver");
                    this.uiApi.addComponentHook(componentsRef.questCtr, "onRollOut");
                };
                this._boostBtnList[componentsRef.questCtr.name] = data;
                componentsRef.lbl_questName.y = 6;
                componentsRef.lbl_questName.visible = true;
                if (data.isCategory)
                {
                    quest = this.dataApi.getQuestCategory(data.id);
                    if (quest != null)
                    {
                        componentsRef.lbl_questName.text = quest.name;
                        componentsRef.lbl_questName.x = 35;
                        componentsRef.lbl_questName.cssClass = "opposite";
                        componentsRef.questCtr.bgColor = this.sysApi.getConfigEntry("colors.grid.title");
                        if ((((((data.id == this._selectedQuestCategory)) && ((data.visible == false)))) || (((selected) && (this._isInit)))))
                        {
                            this._currentCategorySelected = componentsRef.lbl_questName;
                            (componentsRef.lbl_questName as Label).colorText = this.sysApi.getConfigEntry("colors.grid.selected");
                        };
                        if (data.visible)
                        {
                            componentsRef.tx_questComplete.uri = this.uiApi.createUri(this.uiApi.me().getConstant("flechebas_uri"));
                        }
                        else
                        {
                            componentsRef.tx_questComplete.uri = this.uiApi.createUri(this.uiApi.me().getConstant("flecheright_uri"));
                        };
                        componentsRef.tx_questComplete.width = 20;
                        componentsRef.tx_questComplete.height = 20;
                        componentsRef.tx_questComplete.y = 10;
                        componentsRef.tx_questComplete.x = 6;
                        componentsRef.lbl_questName.selectable = false;
                        componentsRef.tx_dungeonQuest.uri = null;
                        componentsRef.btn_quest.selected = false;
                        componentsRef.btn_quest.disabled = false;
                        componentsRef.btn_quest.state = StatesEnum.STATE_NORMAL;
                        delete this._gridLines[data.id];
                    }
                    else
                    {
                        this.clearLine(componentsRef);
                    };
                }
                else
                {
                    if (this._gridLines.indexOf(componentsRef.questCtr) == -1)
                    {
                        this._gridLines[data.id] = componentsRef.questCtr;
                    };
                    quest = this.dataApi.getQuest(data.id);
                    if (quest != null)
                    {
                        lvlQuest = "[";
                        if ((((quest.levelMin == quest.levelMax)) || ((quest.levelMin > quest.levelMax))))
                        {
                            lvlQuest = (lvlQuest + quest.levelMin);
                        }
                        else
                        {
                            lvlQuest = (lvlQuest + ((quest.levelMin + "-") + quest.levelMax));
                        };
                        lvlQuest = (lvlQuest + "]");
                        componentsRef.lbl_questName.text = (quest.name + (((((quest.levelMin == quest.levelMax)) && ((quest.levelMin == 0)))) ? "" : (" " + lvlQuest)));
                        componentsRef.lbl_questName.x = 28;
                        if (data.status)
                        {
                            componentsRef.tx_questComplete.uri = this.uiApi.createUri(this.uiApi.me().getConstant("active_uri"));
                            componentsRef.tx_questComplete.x = -6;
                            componentsRef.lbl_questName.cssClass = "p";
                        }
                        else
                        {
                            componentsRef.tx_questComplete.uri = this.uiApi.createUri(this.uiApi.me().getConstant("complete_uri"));
                            componentsRef.tx_questComplete.x = -4;
                            componentsRef.lbl_questName.cssClass = "p4";
                        };
                        componentsRef.questCtr.bgColor = (((data.id)==this._selectedQuest) ? this.sysApi.getConfigEntry("colors.grid.selected") : -1);
                        if (quest.isDungeonQuest)
                        {
                            componentsRef.tx_dungeonQuest.uri = this.uiApi.createUri(this.uiApi.me().getConstant("dungeon_icon"));
                            componentsRef.tx_dungeonQuest.visible = true;
                            componentsRef.lbl_questName.x = (componentsRef.lbl_questName.x + 33);
                        }
                        else
                        {
                            componentsRef.tx_dungeonQuest.visible = false;
                        };
                        componentsRef.tx_questComplete.width = 42;
                        componentsRef.tx_questComplete.height = 40;
                        componentsRef.tx_questComplete.y = 0;
                        componentsRef.btn_quest.selected = selected;
                        componentsRef.btn_quest.disabled = false;
                    }
                    else
                    {
                        this.clearLine(componentsRef);
                    };
                };
            }
            else
            {
                this.clearLine(componentsRef);
            };
        }

        private function clearLine(componentsRef:*):void
        {
            componentsRef.questCtr.bgColor = -1;
            componentsRef.lbl_questName.visible = false;
            componentsRef.tx_questComplete.uri = null;
            componentsRef.tx_dungeonQuest.uri = null;
            if (componentsRef.btn_quest.selected)
            {
                componentsRef.btn_quest.selected = false;
            };
            componentsRef.btn_quest.disabled = true;
        }

        public function updateObjectivesItem(data:*, componentsRef:*, selected:Boolean):void
        {
            var objective:QuestObjective;
            var dialog:String;
            var flagList:*;
            var flag:Object;
            if (data)
            {
                this.uiApi.addComponentHook(componentsRef.btn_loc, "onRelease");
                this.uiApi.addComponentHook(componentsRef.btn_loc, "onRollOver");
                this.uiApi.addComponentHook(componentsRef.btn_loc, "onRollOut");
                objective = this.dataApi.getQuestObjective(data.id);
                this._aSlotsObjective[componentsRef.btn_loc] = objective;
                componentsRef.lbl_objective.text = objective.text;
                if (objective)
                {
                    dialog = objective.dialog;
                    if (this._questInfos.objectivesDialogParams[objective.id])
                    {
                        dialog = this.utilApi.applyTextParams(dialog, this._questInfos.objectivesDialogParams[objective.id], "#");
                    };
                    this._aObjectivesDialog[componentsRef.tx_infos] = dialog;
                    if (objective.dialog != "")
                    {
                        this.uiApi.addComponentHook(componentsRef.tx_infos, "onRollOver");
                        this.uiApi.addComponentHook(componentsRef.tx_infos, "onRollOut");
                        componentsRef.tx_infos.visible = true;
                    }
                    else
                    {
                        componentsRef.tx_infos.visible = false;
                    };
                };
                if (!(data.status))
                {
                    componentsRef.tx_achieve.visible = true;
                    componentsRef.btn_loc.visible = false;
                    componentsRef.lbl_objective.cssClass = "p4";
                }
                else
                {
                    componentsRef.tx_achieve.visible = false;
                    if (((!((data.currentCompletion == -1))) && (!((data.maxCompletion == -1)))))
                    {
                        componentsRef.lbl_objective.text = (componentsRef.lbl_objective.text + ((((" (" + data.currentCompletion) + "/") + data.maxCompletion) + ")"));
                    };
                    if (((objective.coords) || (objective.mapId)))
                    {
                        componentsRef.btn_loc.visible = true;
                        componentsRef.btn_loc.selected = false;
                        componentsRef.lbl_objective.cssClass = "p";
                        flagList = this.modCartography.getFlags(this.mapApi.getCurrentWorldMap().id);
                        for each (flag in flagList)
                        {
                            if (flag.id == ((((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) + "_") + this._selectedQuest) + "_") + objective.id))
                            {
                                componentsRef.btn_loc.selected = true;
                            };
                        };
                    }
                    else
                    {
                        componentsRef.btn_loc.visible = false;
                        componentsRef.lbl_objective.cssClass = "p";
                    };
                };
            }
            else
            {
                componentsRef.lbl_objective.text = "";
                componentsRef.tx_achieve.visible = false;
                componentsRef.tx_infos.visible = false;
                componentsRef.btn_loc.visible = false;
            };
        }

        private function registerSlot(slot:Slot):void
        {
            this.uiApi.addComponentHook(slot, "onRollOver");
            this.uiApi.addComponentHook(slot, "onRollOut");
            this.uiApi.addComponentHook(slot, "onRelease");
        }

        private function updateQuestGrid():void
        {
            var list:Object;
            var o:Object;
            var i:int;
            var txtPendingQuests:String;
            var txtCompletedQuests:String;
            var isCatVisible:Boolean;
            var p:Object;
            var iQ:*;
            var ts:uint;
            var critSplit:Array;
            var knownQuests:Array;
            var qId:int;
            var nameCatResult:Array;
            var nameNameResult:Array;
            var catCatResult:Array;
            var catNameResult:Array;
            var catId:int;
            var nameId:int;
            var j:int;
            var nameResult:Object;
            var categoryResult:Object;
            var questCat:QuestCategory;
            var q:Object;
            var currentCriteria:String;
            var wannabeCriteria:String;
            var crit:String;
            var realDP:Array = new Array();
            if (!(this._searchCriteria))
            {
                if (this._showCompletedQuest)
                {
                    this.btn_showCompletedQuests.selected = true;
                }
                else
                {
                    if (((((!(this.btn_showCompletedQuests.selected)) && (this._forceOpenCategory))) && ((!(this._questActiveList.indexOf(this.dataApi.getQuest(this._selectedQuest))) == -1))))
                    {
                        this.btn_showCompletedQuests.selected = true;
                        this.sysApi.setData("showCompletedQuest", true);
                    };
                };
                this._questsToShow = new Array();
                this._gridLines = new Array();
                list = this.questApi.getAllQuestsOrderByCategory(this.btn_showCompletedQuests.selected);
                while (i < list.length)
                {
                    if (!(((list[i] == null)) || ((list[i].data.length == 0))))
                    {
                        isCatVisible = !(this.isCatClosed(list[i].id));
                        o = {
                            "id":list[i].id,
                            "isCategory":true,
                            "visible":isCatVisible
                        };
                        this._questsToShow.push(o);
                        realDP.push(o);
                        for each (p in list[i].data)
                        {
                            this._questsToShow.push(p);
                            if (isCatVisible)
                            {
                                realDP.push(p);
                            };
                        };
                    };
                    i = (i + 1);
                };
                txtPendingQuests = this.uiApi.processText(this.uiApi.getText("ui.grimoire.pendingQuests", this._questActiveList.length), "n", (this._questActiveList.length <= 1));
                txtCompletedQuests = this.uiApi.processText(this.uiApi.getText("ui.grimoire.completedQuests", this._questCompletedList.length), "n", (this._questCompletedList.length <= 1));
                this.lbl_nbQuests.text = ((txtPendingQuests + " - ") + txtCompletedQuests);
                this.gd_quests.dataProvider = realDP;
                if (realDP.length > 0)
                {
                    this.lbl_noQuest.visible = false;
                    for (iQ in realDP)
                    {
                        if ((((realDP[iQ].id == this._selectedQuest)) && (realDP[iQ].status)))
                        {
                            this.gd_quests.selectedIndex = iQ;
                        };
                    };
                    this.selectQuest();
                }
                else
                {
                    this.updateEmptyStep();
                    this.lbl_noQuest.visible = true;
                    this.lbl_noQuest.text = this.uiApi.getText("ui.grimoire.quest.noQuest");
                };
            }
            else
            {
                if (this._previousSearchCriteria != ((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnCategory))
                {
                    ts = getTimer();
                    critSplit = ((this._previousSearchCriteria) ? this._previousSearchCriteria.split("#") : []);
                    if (this._searchCriteria != critSplit[0])
                    {
                        nameResult = this.dataApi.queryString(Quest, "name", this._searchCriteria);
                        categoryResult = this.dataApi.queryString(QuestCategory, "name", this._searchCriteria);
                        this._searchResultByCriteriaList["_searchOnName"] = nameResult;
                        this._searchResultByCriteriaList["_searchOnCategory"] = categoryResult;
                        if (((nameResult) || (categoryResult)))
                        {
                            this.sysApi.log(2, (((("Result : " + (((nameResult) ? nameResult.length : 0) + ((categoryResult) ? categoryResult.length : 0))) + " in ") + (getTimer() - ts)) + " ms"));
                        };
                    };
                    if (((!(this._searchOnName)) && (!(this._searchOnCategory))))
                    {
                        this.gd_quests.dataProvider = new Array();
                        this.lbl_noQuest.visible = true;
                        this.lbl_noQuest.text = this.uiApi.getText("ui.search.needCriterion");
                        this._previousSearchCriteria = ((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnCategory);
                        return;
                    };
                    this.lbl_noQuest.visible = false;
                    this._questsToShow = new Array();
                    this._gridLines = new Array();
                    knownQuests = new Array();
                    for each (qId in this.questApi.getActiveQuests())
                    {
                        knownQuests.push(qId);
                    };
                    for each (qId in this.questApi.getCompletedQuests())
                    {
                        knownQuests.push(qId);
                    };
                    nameCatResult = new Array();
                    nameNameResult = new Array();
                    catCatResult = new Array();
                    catNameResult = new Array();
                    for each (catId in this._searchResultByCriteriaList["_searchOnCategory"])
                    {
                        catCatResult.push(catId);
                        questCat = this.dataApi.getQuestCategory(catId);
                        for each (qId in questCat.questIds)
                        {
                            catNameResult.push(qId);
                        };
                    };
                    for each (nameId in this._searchResultByCriteriaList["_searchOnName"])
                    {
                        if (knownQuests.indexOf(nameId) != -1)
                        {
                            nameNameResult.push(nameId);
                            nameCatResult.push(this.dataApi.getQuest(nameId).categoryId);
                        };
                    };
                    list = this.questApi.getAllQuestsOrderByCategory(true);
                    while (j < list.length)
                    {
                        if (!(((list[j] == null)) || ((list[j].data.length == 0))))
                        {
                            if (((((this._searchOnCategory) && (catCatResult))) && (!((catCatResult.indexOf(list[j].id) == -1)))))
                            {
                                o = {
                                    "id":list[j].id,
                                    "isCategory":true,
                                    "visible":true
                                };
                                this._questsToShow.push(o);
                                realDP.push(o);
                            }
                            else
                            {
                                if (((((this._searchOnName) && (nameCatResult))) && (!((nameCatResult.indexOf(list[j].id) == -1)))))
                                {
                                    o = {
                                        "id":list[j].id,
                                        "isCategory":true,
                                        "visible":true
                                    };
                                    this._questsToShow.push(o);
                                    realDP.push(o);
                                };
                            };
                            for each (q in list[j].data)
                            {
                                if (((((this._searchOnName) && (nameNameResult))) && (!((nameNameResult.indexOf(q.id) == -1)))))
                                {
                                    this._questsToShow.push(q);
                                    realDP.push(q);
                                }
                                else
                                {
                                    if (((((this._searchOnCategory) && (catNameResult))) && (!((catNameResult.indexOf(q.id) == -1)))))
                                    {
                                        this._questsToShow.push(q);
                                        realDP.push(q);
                                    };
                                };
                            };
                        };
                        j = (j + 1);
                    };
                    this.gd_quests.dataProvider = realDP;
                    if (realDP.length > 0)
                    {
                        this.lbl_noQuest.visible = false;
                    }
                    else
                    {
                        this.lbl_noQuest.visible = true;
                        this.lbl_noQuest.text = this.uiApi.getText("ui.search.noResult");
                        currentCriteria = "";
                        wannabeCriteria = "";
                        for (crit in this._searchTextByCriteriaList)
                        {
                            if (this[crit])
                            {
                                currentCriteria = (currentCriteria + (this._searchTextByCriteriaList[crit] + ", "));
                            }
                            else
                            {
                                if (this._searchResultByCriteriaList[crit].length > 0)
                                {
                                    wannabeCriteria = (wannabeCriteria + (this._searchTextByCriteriaList[crit] + ", "));
                                };
                            };
                        };
                        if (currentCriteria.length > 0)
                        {
                            currentCriteria = currentCriteria.slice(0, -2);
                        };
                        if (wannabeCriteria.length > 0)
                        {
                            wannabeCriteria = wannabeCriteria.slice(0, -2);
                        };
                        if (wannabeCriteria.length == 0)
                        {
                            this.lbl_noQuest.text = this.uiApi.getText("ui.search.noResultFor", this._searchCriteria);
                        }
                        else
                        {
                            this.lbl_noQuest.text = this.uiApi.getText("ui.search.noResultsBut", currentCriteria, wannabeCriteria);
                        };
                    };
                };
            };
        }

        private function selectQuest():void
        {
            if (this.ctr_itemBlock.visible)
            {
                this.ctr_itemBlock.visible = false;
            };
            this.sysApi.sendAction(new QuestInfosRequest(this._selectedQuest));
        }

        private function updateStep():void
        {
            var i:uint;
            var txtKamas:uint;
            var txtXp:uint;
            var iconUri:Object;
            var o:Object;
            var reward:Object;
            var rewardId:uint;
            var quest:Quest;
            var objectives:Array;
            var obv:Object;
            var objWrapper:ObjectiveWrapper;
            var item:ItemWrapper;
            var emote:EmoteWrapper;
            var job:JobWrapper;
            var spell:Object;
            var cbxDP:Array = new Array();
            var len:uint = this._questStepsList.length;
            i = 1;
            while (i <= len)
            {
                cbxDP.push({
                    "label":((this.uiApi.getText("ui.grimoire.quest.step") + " ") + i),
                    "value":i
                });
                i = (i + 1);
            };
            this.cbx_steps.dataProvider = cbxDP;
            this.cbx_steps.selectedIndex = this._currentIndexForStep;
            var step:QuestStep = (this.dataApi.getQuestStep(this._displayedStep) as QuestStep);
            if ((((step.name == null)) || ((step.name == ""))))
            {
                quest = this.dataApi.getQuest(this._selectedQuest);
                this.lbl_stepName.text = quest.name;
            }
            else
            {
                this.lbl_stepName.text = step.name;
            };
            if (this._questStepsList.indexOf(this._displayedStep) <= this._questStepsList.indexOf(this._currentStep))
            {
                this.txa_description.text = step.description;
                this.lbl_objectives.text = "";
                this.tx_dialog.disabled = false;
                objectives = new Array();
                for each (obv in step.objectives)
                {
                    if (this._questInfos.objectives[obv.id] != undefined)
                    {
                        objWrapper = ObjectiveWrapper.create(obv.id, this._questInfos.objectives[obv.id]);
                        if (this._questInfos.objectivesData[obv.id] != null)
                        {
                            objWrapper.currentCompletion = this._questInfos.objectivesData[obv.id].current;
                            objWrapper.maxCompletion = this._questInfos.objectivesData[obv.id].max;
                        };
                        objectives.push(objWrapper);
                    };
                };
                this.gd_objectives.dataProvider = objectives;
            }
            else
            {
                this.txa_description.text = this.uiApi.getText("ui.grimoire.quest.descriptionNonAvailable");
                this.lbl_objectives.text = this.uiApi.getText("ui.grimoire.quest.objectivesNonAvailable");
                this.tx_dialog.disabled = true;
                this.gd_objectives.dataProvider = new Array();
            };
            this._stepNpcMessage = step.dialog;
            if (this._stepNpcMessage == "")
            {
                this.tx_dialog.disabled = true;
            };
            if ((((this.gd_objectives.dataProvider.length == 0)) && ((this._questActiveList.length > 0))))
            {
                this.lbl_objectives.text = this.uiApi.getText("ui.grimoire.quest.objectivesNonAvailable");
            }
            else
            {
                this.lbl_objectives.text = "";
            };
            if (step.kamasReward != 0)
            {
                txtKamas = step.kamasReward;
            }
            else
            {
                txtKamas = 0;
            };
            var xpReward:uint = step.experienceReward;
            if (xpReward != 0)
            {
                txtXp = xpReward;
            }
            else
            {
                txtXp = 0;
            };
            this.formateRewardsLbl(txtXp, txtKamas);
            this.clearSlots();
            this._iconRewards = new Array();
            this._rewards = new Array();
            var cpt:uint;
            for each (reward in step.itemsReward)
            {
                this._rewards[cpt] = reward[0];
                item = this.dataApi.getItemWrapper(reward[0], 0, 0, reward[1]);
                this.displaySlot(this._aSlotsReward[cpt], item);
                this._iconRewards.push(item.name);
                cpt++;
            };
            for each (rewardId in step.emotesReward)
            {
                emote = this.dataApi.getEmoteWrapper(rewardId);
                this.displaySlot(this._aSlotsReward[cpt], emote);
                this._iconRewards.push(emote.emote.name);
                cpt++;
            };
            for each (rewardId in step.jobsReward)
            {
                job = this.dataApi.getJobWrapper(rewardId);
                this.displaySlot(this._aSlotsReward[cpt], job);
                this._iconRewards.push(job.job.name);
                cpt++;
            };
            for each (rewardId in step.spellsReward)
            {
                spell = this.dataApi.getSpellWrapper(rewardId);
                this.displaySlot(this._aSlotsReward[cpt], spell);
                this._iconRewards.push(spell.spell.name);
                cpt++;
            };
        }

        private function updateEmptyStep():void
        {
            this.lbl_stepName.text = "";
            this.txa_description.text = "";
            this.tx_dialog.disabled = true;
            this.gd_objectives.dataProvider = new Array();
            if (this._questActiveList.length > 0)
            {
                this.lbl_objectives.text = this.uiApi.getText("ui.grimoire.quest.objectivesNonAvailable");
            };
            this.formateRewardsLbl(0, 0);
            this.clearSlots();
        }

        private function clearSlots():void
        {
            var slot:Slot;
            for each (slot in this._aSlotsReward)
            {
                slot.data = null;
                slot.buttonMode = false;
            };
        }

        private function formateRewardsLbl(xp:uint, kamas:uint):void
        {
            var defaultX:uint = 810;
            if (kamas > 0)
            {
                this.lbl_rewardsKama.x = defaultX;
                this.lbl_rewardsKama.visible = (this.tx_rewardsKama.visible = true);
                this.lbl_rewardsKama.text = this.utilApi.formateIntToString(kamas);
                this.tx_rewardsKama.x = ((this.lbl_rewardsKama.x + this.lbl_rewardsKama.width) + 2);
            }
            else
            {
                this.lbl_rewardsKama.visible = (this.tx_rewardsKama.visible = false);
            };
            if (xp > 0)
            {
                this.tx_rewardsXp.visible = (this.lbl_rewardsXp.visible = true);
                this.lbl_rewardsXp.text = this.utilApi.formateIntToString(xp);
                this.lbl_rewardsXp.x = (((kamas)>0) ? ((((this.lbl_rewardsKama.x - this.lbl_rewardsKama.width) - 40) + (this.lbl_rewardsKama.width - this.lbl_rewardsKama.textWidth))) : (defaultX));
                this.tx_rewardsXp.x = ((this.lbl_rewardsXp.x + this.lbl_rewardsXp.width) + 6);
            }
            else
            {
                this.tx_rewardsXp.visible = (this.lbl_rewardsXp.visible = false);
            };
        }

        private function displaySlot(slot:Slot, data:Object):void
        {
            slot.data = data;
            slot.buttonMode = true;
        }

        private function showOrHideCategory(categoryId:uint, type:uint=0):void
        {
            var newVisibleState:Boolean;
            var quest:Object;
            this._closedCategories = new Array();
            var newDp:Array = new Array();
            this._gridLines = new Array();
            var isVisible:Boolean;
            for each (quest in this._questsToShow)
            {
                if (quest.isCategory)
                {
                    newDp.push(quest);
                    if (quest.id == categoryId)
                    {
                        switch (type)
                        {
                            case 0:
                                newVisibleState = !(quest.visible);
                                break;
                            case 1:
                                newVisibleState = true;
                                break;
                            case 2:
                                newVisibleState = false;
                                break;
                        };
                        if (newVisibleState != quest.visible)
                        {
                            quest.visible = newVisibleState;
                        }
                        else
                        {
                            return;
                        };
                    };
                    isVisible = quest.visible;
                    if (!(isVisible))
                    {
                        this._closedCategories.push(quest.id);
                    };
                }
                else
                {
                    if (isVisible)
                    {
                        newDp.push(quest);
                    };
                };
            };
            this.sysApi.setData("closedQuestCategories", this._closedCategories);
            this.gd_quests.dataProvider = newDp;
        }

        private function isCatClosed(catId:int):Boolean
        {
            if (((this._forceOpenCategory) && ((this._selectedQuestCategory == catId))))
            {
                this._forceOpenCategory = false;
                return (false);
            };
            if (((!(this._closedCategories)) || ((this._closedCategories.length == 0))))
            {
                return (false);
            };
            return ((this._closedCategories.indexOf(catId) > -1));
        }

        private function selectLine(index:int=-1):void
        {
            var i:int;
            var line:GraphicContainer;
            var selectedColor:Number = this.sysApi.getConfigEntry("colors.grid.selected");
            var bgColor:Number = this.sysApi.getConfigEntry("colors.grid.bg");
            var len:uint = this._gridLines.length;
            i = 0;
            while (i < len)
            {
                if (this._gridLines[i] == null)
                {
                }
                else
                {
                    line = this._gridLines[i];
                    if ((((i == index)) && (!((index == -1)))))
                    {
                        line.bgColor = selectedColor;
                    }
                    else
                    {
                        if (line.bgColor == selectedColor)
                        {
                            line.bgColor = bgColor;
                        };
                    };
                };
                i++;
            };
        }

        private function changeSearchOnName():void
        {
            this._searchOnName = !(this._searchOnName);
            Grimoire.getInstance().questSearchOnName = this._searchOnName;
            if (((!(this._searchOnName)) && (!(this._searchOnCategory))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg.disabled = false;
            };
            if (((this._searchCriteria) && (!((this._searchCriteria == "")))))
            {
                this.updateQuestGrid();
            };
        }

        private function changeSearchOnCategory():void
        {
            this._searchOnCategory = !(this._searchOnCategory);
            Grimoire.getInstance().questSearchOnCategory = this._searchOnCategory;
            if (((!(this._searchOnName)) && (!(this._searchOnCategory))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg.disabled = false;
            };
            if (((this._searchCriteria) && (!((this._searchCriteria == "")))))
            {
                this.updateQuestGrid();
            };
        }

        public function onRelease(target:Object):void
        {
            var itemId:uint;
            var itemw:Object;
            var flagList:*;
            var nbQuestFlags:int;
            var flagIdList:Array;
            var flag:Object;
            var objective:QuestObjective;
            var newFlagId:String;
            var flagX:Number;
            var flagY:Number;
            var worldMapId:int;
            var objectiveWorldMapId:int;
            var flagText:String;
            var entranceMapIds:Object;
            var exitMapIds:Object;
            var mapPos:MapPosition;
            var subArea:SubArea;
            var _local_21:Array;
            var slotIndex:int = this._aSlotsReward.indexOf(target);
            if (((!((slotIndex == -1))) && (!((this._aSlotsReward[slotIndex].data == null)))))
            {
                itemId = this._rewards[(parseInt(target.name.substr(10)) - 1)];
                if (((itemId) && (((((this.ctr_itemBlock.visible) && (!((target == this._previousRewardSelected))))) || (!(this.ctr_itemBlock.visible))))))
                {
                    this._previousRewardSelected = target;
                    itemw = this.dataApi.getItemWrapper(itemId);
                    this.modCommon.createItemBox(("itemBox_" + this.uiApi.me().name), this.ctr_item, itemw, true);
                    this.ctr_itemBlock.visible = true;
                }
                else
                {
                    this.ctr_itemBlock.visible = false;
                };
            }
            else
            {
                if (target.name.substr(0, 7) == "btn_loc")
                {
                    flagList = this.modCartography.getFlags(this.mapApi.getCurrentWorldMap().id);
                    nbQuestFlags = 0;
                    flagIdList = new Array();
                    for each (flag in flagList)
                    {
                        if (flag.id.indexOf(("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST)) == 0)
                        {
                            flagIdList.push(flag.id);
                            nbQuestFlags++;
                        };
                    };
                    if (nbQuestFlags > MAX_QUEST_FLAGS)
                    {
                        return;
                    };
                    objective = this._aSlotsObjective[target];
                    if (objective)
                    {
                        newFlagId = ((((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) + "_") + this._selectedQuest) + "_") + objective.id);
                        if (flagIdList.indexOf(newFlagId) > -1)
                        {
                            target.selected = false;
                        }
                        else
                        {
                            if (nbQuestFlags == MAX_QUEST_FLAGS)
                            {
                                return;
                            };
                            target.selected = true;
                        };
                        flagX = ((objective.coords) ? objective.coords.x : NaN);
                        flagY = ((objective.coords) ? objective.coords.y : NaN);
                        worldMapId = this.mapApi.getCurrentWorldMap().id;
                        flagText = ((this.uiApi.getText("ui.common.quests") + "\n") + objective.text);
                        if (objective.mapId)
                        {
                            mapPos = this.mapApi.getMapPositionById(objective.mapId);
                            subArea = this.mapApi.getSubArea(mapPos.subAreaId);
                            entranceMapIds = subArea.entranceMapIds;
                            exitMapIds = subArea.exitMapIds;
                            objectiveWorldMapId = subArea.worldmap.id;
                            if (worldMapId != objectiveWorldMapId)
                            {
                                if (worldMapId == 1)
                                {
                                    if (entranceMapIds.length > 0)
                                    {
                                        mapPos = this.mapApi.getMapPositionById(entranceMapIds[0]);
                                    }
                                    else
                                    {
                                        worldMapId = objectiveWorldMapId;
                                    };
                                }
                                else
                                {
                                    subArea = this.mapApi.getCurrentSubArea();
                                    if (exitMapIds.length > 0)
                                    {
                                        mapPos = this.mapApi.getMapPositionById(exitMapIds[0]);
                                    }
                                    else
                                    {
                                        worldMapId = objectiveWorldMapId;
                                    };
                                };
                            };
                            flagX = mapPos.posX;
                            flagY = mapPos.posY;
                        };
                        if (((!(isNaN(flagX))) && (!(isNaN(flagY)))))
                        {
                            flagText = (flagText + ((((" (" + flagX) + ",") + flagY) + ")"));
                            this.sysApi.dispatchHook(AddMapFlag, newFlagId, flagText, worldMapId, flagX, flagY, 0x66CC00, true);
                        };
                    };
                };
            };
            var index:int;
            switch (target)
            {
                case this.btn_tabComplete:
                    if (this._bDescendingSort)
                    {
                        this.gd_quests.sortOn("complete");
                    }
                    else
                    {
                        this.gd_quests.sortOn("complete", Array.DESCENDING);
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabName:
                    if (this._bDescendingSort)
                    {
                        this.gd_quests.sortOn("name", Array.CASEINSENSITIVE);
                    }
                    else
                    {
                        this.gd_quests.sortOn("name", (Array.CASEINSENSITIVE | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_showCompletedQuests:
                    this.sysApi.setData("showCompletedQuest", this.btn_showCompletedQuests.selected);
                    this._showCompletedQuest = this.btn_showCompletedQuests.selected;
                    this.updateQuestGrid();
                    break;
                case this.btn_close:
                    if (this.ctr_itemBlock.visible)
                    {
                        this.ctr_itemBlock.visible = false;
                    };
                    break;
                case this.btn_resetSearch:
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this.updateQuestGrid();
                    break;
                case this.btn_searchFilter:
                    _local_21 = new Array();
                    _local_21.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
                    _local_21.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"], this.changeSearchOnName, null, false, null, this._searchOnName, false));
                    _local_21.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnCategory"], this.changeSearchOnCategory, null, false, null, this._searchOnCategory, false));
                    this.modContextMenu.createContextMenu(_local_21);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            this.ctr_itemBlock.visible = false;
            switch (target)
            {
                case this.gd_quests:
                    this._isInit = true;
                    _local_4 = this.gd_quests.selectedItem;
                    if (((((((((!((_local_4.id == this._selectedQuest))) && (!(_local_4.isCategory)))) && (!((selectMethod == SelectMethodEnum.AUTO))))) && (!((selectMethod == SelectMethodEnum.LEFT_ARROW))))) && (!((selectMethod == SelectMethodEnum.RIGHT_ARROW)))))
                    {
                        this.selectLine(_local_4.id);
                        this._selectedQuest = _local_4.id;
                        this._selectedQuestCategory = this.dataApi.getQuest(this._selectedQuest).category.id;
                        this.selectQuest();
                        this._previousSelectedItem = _local_4;
                    }
                    else
                    {
                        if (((((_local_4.isCategory) || (((!((this._previousSelectedItem == null))) && (this._previousSelectedItem.isCategory))))) && (!((selectMethod == SelectMethodEnum.AUTO)))))
                        {
                            if ((((selectMethod == SelectMethodEnum.LEFT_ARROW)) || ((selectMethod == SelectMethodEnum.RIGHT_ARROW))))
                            {
                                _local_4 = this._previousSelectedItem;
                            }
                            else
                            {
                                if (selectMethod == SelectMethodEnum.CLICK)
                                {
                                    this.showOrHideCategory(_local_4.id);
                                }
                                else
                                {
                                    if (_local_4.isCategory)
                                    {
                                        this.selectLine();
                                        this._previousSelectedItem = _local_4;
                                        this._selectedQuest = NaN;
                                        this._selectedQuestCategory = NaN;
                                    };
                                };
                            };
                        };
                    };
                    break;
                case this.cbx_steps:
                    if (this.cbx_steps.selectedIndex != this._currentIndexForStep)
                    {
                        this._currentIndexForStep = this.cbx_steps.selectedIndex;
                        this._displayedStep = this._questStepsList[this.cbx_steps.selectedIndex];
                        this.updateStep();
                    };
                    break;
            };
        }

        public function onShortCut(s:String):Boolean
        {
            if ((((this._previousSelectedItem == null)) || (!(this.gd_quests.selectedItem.isCategory))))
            {
                return (false);
            };
            switch (s)
            {
                case "leftArrow":
                    this.showOrHideCategory(this.gd_quests.selectedItem.id, 1);
                    return (true);
                case "rightArrow":
                    this.showOrHideCategory(this.gd_quests.selectedItem.id, 2);
                    return (true);
            };
            return (false);
        }

        public function onRollOver(target:Object):void
        {
            var index:int;
            var content:String;
            var itemId:uint;
            var infosObjectiveText:String;
            var point:uint;
            var relPoint:uint;
            var data:Object;
            var slotIndex:int = this._aSlotsReward.indexOf(target);
            if (((!((slotIndex == -1))) && (!((this._aSlotsReward[slotIndex].data == null)))))
            {
                index = (parseInt(target.name.substr(10)) - 1);
                content = this._iconRewards[index];
                itemId = this._rewards[index];
                if (itemId)
                {
                    content = (content + this.averagePricesApi.getItemAveragePriceString(this.dataApi.getItemWrapper(itemId), true));
                };
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(content), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            }
            else
            {
                if (target == this.tx_dialog)
                {
                    if (this._stepNpcMessage != "")
                    {
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._stepNpcMessage), target, false, "standard", 3, 5, 3, null, null, null, "TextInfo");
                    };
                }
                else
                {
                    if ((((target.name.substr(0, 8) == "questCtr")) && (!(this._boostBtnList[target.name].isCategory))))
                    {
                        (target as GraphicContainer).bgColor = this.sysApi.getConfigEntry("colors.grid.over");
                    }
                    else
                    {
                        if (target.name.substr(0, 15) == "tx_dungeonQuest")
                        {
                            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.dungeonQuest")), target, false, "standard", 3, 5, 3, null, null, null, "TextInfo");
                        }
                        else
                        {
                            if (target.name.indexOf("tx_infos") != -1)
                            {
                                infosObjectiveText = this._aObjectivesDialog[target];
                                if (infosObjectiveText != "")
                                {
                                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(infosObjectiveText), target, false, "standard", 3, 5, 3, null, null, null, "TextInfo");
                                };
                            }
                            else
                            {
                                if (target.name.substr(0, 7) == "btn_loc")
                                {
                                    point = 7;
                                    relPoint = 1;
                                    data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tooltip.questMarker"));
                                    this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
                                };
                            };
                        };
                    };
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
            if ((((target.name.substr(0, 8) == "questCtr")) && (!(this._boostBtnList[target.name].isCategory))))
            {
                if (this._boostBtnList[target.name].id == this._selectedQuest)
                {
                    (target as GraphicContainer).bgColor = this.sysApi.getConfigEntry("colors.grid.selected");
                }
                else
                {
                    (target as GraphicContainer).bgColor = this.sysApi.getConfigEntry("colors.grid.bg");
                };
            };
        }

        private function onUpdateQuestTab(tab:String=null, param:Object=null):void
        {
            var quest:Object;
            var newQuest:Quest;
            var i:uint;
            var len:uint;
            var o:Object;
            if ((((((tab == "questTab")) && (param))) && (param.forceOpen)))
            {
                newQuest = (param.quest as Quest);
                len = this.gd_quests.dataProvider.length;
                i = 0;
                while (i < len)
                {
                    quest = this.gd_quests.dataProvider[i];
                    if (((!(quest.isCategory)) && ((quest.id == newQuest.id))))
                    {
                        this.gd_quests.selectedIndex = i;
                        return;
                    };
                    i++;
                };
                for each (o in this._questsToShow)
                {
                    if (((!(o.isCategory)) && ((o.id == newQuest.id))))
                    {
                        this._selectedQuest = newQuest.id;
                        this.showOrHideCategory(newQuest.category.id);
                        return;
                    };
                };
            };
        }

        public function onQuestListUpdated():void
        {
            var questA:*;
            var questC:*;
            this._questActiveList = new Array();
            this._questCompletedList = new Array();
            var selectedStillHere:Boolean;
            for each (questA in this.questApi.getActiveQuests())
            {
                if (this._selectedQuest == questA)
                {
                    selectedStillHere = true;
                };
                this._questActiveList.push({
                    "id":questA,
                    "status":true
                });
            };
            for each (questC in this.questApi.getCompletedQuests())
            {
                if (this._selectedQuest == questA)
                {
                    selectedStillHere = true;
                };
                this._questCompletedList.push({
                    "id":questC,
                    "status":true
                });
            };
            if (((!(selectedStillHere)) && ((this._questActiveList.length > 0))))
            {
                this._selectedQuest = this._questActiveList[0].id;
            };
            this.updateQuestGrid();
        }

        public function onQuestInfosUpdated(questId:uint, infosAvailable:Boolean):void
        {
            var st:*;
            this.sysApi.setData("lastQuestSelected", questId);
            if ((((questId == this._selectedQuest)) && (infosAvailable)))
            {
                this._questInfos = this.questApi.getQuestInformations(this._selectedQuest);
                this._questStepsList = new Array();
                for (st in this.dataApi.getQuest(questId).stepIds)
                {
                    this._questStepsList.push(this.dataApi.getQuest(questId).stepIds[st]);
                    if (this.dataApi.getQuest(questId).stepIds[st] == this._questInfos.stepId)
                    {
                        this._currentIndexForStep = st;
                    };
                };
                this._currentStep = (this._displayedStep = this._questInfos.stepId);
                this.updateStep();
            }
            else
            {
                this.updateEmptyStep();
            };
        }

        private function onFlagRemoved(flagId:String, worldmapId:int):void
        {
            if (flagId.indexOf(((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) + "_") + this._selectedQuest)) == 0)
            {
                this.updateStep();
            };
        }

        public function onTextureLoadFailed(target:Object, behavior:Boolean):void
        {
            target.uri = this.uiApi.createUri((this.sysApi.getConfigEntry("config.gfx.path.item.bitmap") + "error.png"));
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (this.inp_search.haveFocus)
            {
                this._lockSearchTimer.reset();
                this._lockSearchTimer.start();
            };
        }

        public function onTimeOut(e:TimerEvent):void
        {
            if (this.inp_search.text.length > 2)
            {
                this._searchCriteria = this.inp_search.text.toLowerCase();
                this.updateQuestGrid();
            }
            else
            {
                if (this._searchCriteria)
                {
                    this._searchCriteria = null;
                };
                if (this.inp_search.text.length == 0)
                {
                    this.updateQuestGrid();
                };
            };
        }


    }
}//package ui

class ObjectiveWrapper 
{

    public var id:int;
    public var status:Boolean;
    public var currentCompletion:int = -1;
    public var maxCompletion:int = -1;


    public static function create(pId:int, pStatus:Boolean):ObjectiveWrapper
    {
        var o:ObjectiveWrapper = new (ObjectiveWrapper)();
        o.id = pId;
        o.status = pStatus;
        return (o);
    }


    public function addCompletion(pCurrentNb:int, pMaxNb:int):void
    {
        this.currentCompletion = pCurrentNb;
        this.maxCompletion = pMaxNb;
    }


}

