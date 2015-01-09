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
    import d2hooks.AchievementList;
    import d2hooks.AchievementDetailedList;
    import d2hooks.AchievementDetails;
    import d2hooks.AchievementFinished;
    import d2hooks.OpenBook;
    import d2hooks.AchievementRewardSuccess;
    import d2hooks.GuildInformationsMemberUpdate;
    import d2hooks.KeyUp;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import d2actions.AchievementDetailsRequest;
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
    import d2actions.AchievementDetailedListRequest;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2enums.LocationEnum;
    import flash.ui.Keyboard;
    import d2hooks.MouseShiftClick;
    import d2actions.AchievementRewardRequest;
    import flash.utils.clearTimeout;
    import d2hooks.*;
    import d2actions.*;

    public class AchievementTab 
    {

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
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
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

        public function AchievementTab()
        {
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

        public function main(oParam:Object=null):void
        {
            var ach:Achievement;
            var cat:AchievementCategory;
            var hasChild:Boolean;
            var mainCat:Object;
            var meMember:GuildMember;
            var myId:int;
            var mem:GuildMember;
            var category:AchievementCategory;
            this.sysApi.addHook(AchievementList, this.onAchievementList);
            this.sysApi.addHook(AchievementDetailedList, this.onAchievementDetailedList);
            this.sysApi.addHook(AchievementDetails, this.onAchievementDetails);
            this.sysApi.addHook(AchievementFinished, this.onAchievementFinished);
            this.sysApi.addHook(OpenBook, this.onOpenAchievement);
            this.sysApi.addHook(AchievementRewardSuccess, this.onAchievementRewardSuccess);
            this.sysApi.addHook(GuildInformationsMemberUpdate, this.onGuildInformationsMemberUpdate);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addComponentHook(this.gd_categories, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_hideCompletedAchievements, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.lbl_myPoints, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_myPoints, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_globalProgress, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_globalProgress, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OUT);
            GAUGE_WIDTH_OBJECTIVE = int(this.uiApi.me().getConstant("gauge_width_objective"));
            GAUGE_WIDTH_CATEGORY = int(this.uiApi.me().getConstant("gauge_width_category"));
            GAUGE_WIDTH_TOTAL = int(this.uiApi.me().getConstant("gauge_width_total"));
            this._lockSearchTimer = new Timer(500, 1);
            this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this.btn_hideCompletedAchievements.selected = this._hideAchievedAchievement;
            this._searchOnName = Grimoire.getInstance().achievementSearchOnName;
            this._searchOnObjective = Grimoire.getInstance().achievementSearchOnObjective;
            this._searchOnReward = Grimoire.getInstance().achievementSearchOnReward;
            this._searchTextByCriteriaList["_searchOnName"] = this.uiApi.getText("ui.common.name");
            this._searchTextByCriteriaList["_searchOnObjective"] = this.uiApi.getText("ui.grimoire.quest.objectives");
            this._searchTextByCriteriaList["_searchOnReward"] = this.uiApi.getText("ui.grimoire.quest.rewards");
            this._dataAchievements = this.dataApi.getAchievements();
            for each (ach in this._dataAchievements)
            {
                this._totalSuccesPoints = (this._totalSuccesPoints + ach.points);
            };
            this._dataCategories = this.dataApi.getAchievementCategories();
            for each (cat in this._dataCategories)
            {
                if (cat.parentId == 0)
                {
                    this._categories.push({
                        "id":cat.id,
                        "name":cat.name,
                        "icon":cat.icon,
                        "achievements":cat.achievements,
                        "subcats":new Array(),
                        "color":cat.color,
                        "order":cat.order
                    });
                };
            };
            this._categories.sortOn("order", Array.NUMERIC);
            this._categories.splice(0, 0, {
                "id":0,
                "name":this.uiApi.getText("ui.achievement.synthesis"),
                "achievements":null,
                "subcats":null
            });
            for each (mainCat in this._categories)
            {
                hasChild = false;
                for each (cat in this._dataCategories)
                {
                    if (((!((mainCat.id == 0))) && ((cat.parentId == mainCat.id))))
                    {
                        mainCat.subcats.push({
                            "id":cat.id,
                            "name":cat.name,
                            "parentId":cat.parentId,
                            "achievements":cat.achievements,
                            "order":cat.order
                        });
                        hasChild = true;
                    };
                };
                if (hasChild)
                {
                    mainCat.name = (mainCat.name + " (+)");
                };
                if (mainCat.id != 0)
                {
                    mainCat.subcats.sortOn("order", Array.NUMERIC);
                };
            };
            this.gd_categories.dataProvider = this._categories;
            if (this.socialApi.hasGuild())
            {
                myId = this.playerApi.id();
                for each (mem in this.socialApi.getGuildMembers())
                {
                    if (mem.id == myId)
                    {
                        meMember = mem;
                        break;
                    };
                };
                this._myGuildXp = meMember.experienceGivenPercent;
            };
            this._hideAchievedAchievement = this.sysApi.getData("hideCompletedAchievements");
            this.btn_hideCompletedAchievements.selected = this._hideAchievedAchievement;
            this._textShadow = new GlowFilter(this.sysApi.getConfigEntry("colors.grid.bg"), 1, 11, 11, 4);
            this.lbl_titleProgress.filters = [this._textShadow];
            this._finishedAchievementsId = Grimoire.getInstance().finishedAchievementsIds;
            this._objectivesTextByAchievementId = Grimoire.getInstance().objectivesTextByAchievement;
            var openAchId:int;
            var lastAchievementSearchCriteria:String = Grimoire.getInstance().lastAchievementSearchCriteria;
            var lastAchievementOpenedId:int = Grimoire.getInstance().lastAchievementOpenedId;
            var lastAchievementCategoryOpenedId:int = Grimoire.getInstance().lastAchievementCategoryOpenedId;
            var lastAchievementScrollValue:int = Grimoire.getInstance().lastAchievementScrollValue;
            if (((oParam) && (oParam.achievementId)))
            {
                openAchId = oParam.achievementId;
            }
            else
            {
                if (((lastAchievementSearchCriteria) && (!((lastAchievementSearchCriteria == "")))))
                {
                    this._searchCriteria = lastAchievementSearchCriteria.toLowerCase();
                    this.inp_search.text = this._searchCriteria;
                    this._currentScrollValue = lastAchievementScrollValue;
                    if (lastAchievementOpenedId > 0)
                    {
                        this.sysApi.sendAction(new AchievementDetailsRequest(lastAchievementOpenedId));
                        this._selectedAchievementId = lastAchievementOpenedId;
                    };
                    this.updateAchievementGrid(this._currentSelectedCatId);
                }
                else
                {
                    if (lastAchievementOpenedId > 0)
                    {
                        openAchId = lastAchievementOpenedId;
                    }
                    else
                    {
                        if (lastAchievementCategoryOpenedId > 0)
                        {
                            this._currentScrollValue = lastAchievementScrollValue;
                            category = this.dataApi.getAchievementCategory(lastAchievementCategoryOpenedId);
                            this.updateCategories(category, true);
                        };
                    };
                };
            };
            if (openAchId > 0)
            {
                this._selectedAchievementId = openAchId;
                this._forceOpenAchievement = true;
            };
            if ((((((openAchId > 0)) || ((lastAchievementCategoryOpenedId > 0)))) || (this._searchCriteria)))
            {
                this.ctr_achievements.visible = true;
                this.ctr_summary.visible = false;
            }
            else
            {
                this.gd_categories.selectedIndex = 0;
                this.ctr_achievements.visible = false;
                this.ctr_summary.visible = true;
            };
            this.onAchievementList(this._finishedAchievementsId);
        }

        public function unload():void
        {
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._lockSearchTimer.stop();
            this._lockSearchTimer = null;
            this.sysApi.setData("hideCompletedAchievements", this._hideAchievedAchievement);
            Grimoire.getInstance().lastAchievementSearchCriteria = this._searchCriteria;
            Grimoire.getInstance().lastAchievementCategoryOpenedId = this._currentSelectedCatId;
            Grimoire.getInstance().lastAchievementOpenedId = this._selectedAndOpenedAchievementId;
            Grimoire.getInstance().lastAchievementScrollValue = this.gd_achievements.verticalScrollValue;
        }

        public function updateSummary(data:*, componentsRef:*, selected:Boolean):void
        {
            var percent:int;
            if (!(this._catIlluBtnList[componentsRef.ctr_illu.name]))
            {
                this.uiApi.addComponentHook(componentsRef.ctr_illu, ComponentHookList.ON_RELEASE);
            };
            this._catIlluBtnList[componentsRef.ctr_illu.name] = data;
            if (!(this._catProgressBarList[componentsRef.ctr_progress.name]))
            {
                this.uiApi.addComponentHook(componentsRef.ctr_progress, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.ctr_progress, ComponentHookList.ON_ROLL_OUT);
            };
            this._catProgressBarList[componentsRef.ctr_progress.name] = data;
            if (data)
            {
                percent = Math.floor(((data.value / data.total) * 100));
                if (percent > 100)
                {
                    percent = 100;
                };
                componentsRef.lbl_name.text = data.name;
                componentsRef.lbl_name.filters = [this._textShadow];
                componentsRef.lbl_percent.text = (percent + "%");
                componentsRef.tx_illu.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("illusUi") + "illu_") + data.icon) + ".png"));
                componentsRef.ctr_illu.handCursor = true;
                this._colorTransform.color = data.color;
                componentsRef.tx_progress.transform.colorTransform = this._colorTransform;
                componentsRef.tx_progress.width = (percent * (GAUGE_WIDTH_CATEGORY / 100));
                componentsRef.ctr_summary.visible = true;
            }
            else
            {
                componentsRef.ctr_summary.visible = false;
            };
        }

        public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            var _local_5:int;
            var _local_6:int;
            var ach:Object;
            var percent:int;
            switch (this.getCatLineType(data, line))
            {
                case CTR_CAT_TYPE_CAT:
                    if (data.icon)
                    {
                        componentsRef.tx_catIcon.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("assets") + "") + data.icon));
                    }
                    else
                    {
                        componentsRef.tx_catIcon.uri = null;
                    };
                case CTR_CAT_TYPE_SUBCAT:
                    componentsRef.lbl_catName.text = data.name;
                    _local_5 = 0;
                    _local_6 = 0;
                    if ((((((data.id > 0)) && (data.achievements))) && ((data.achievements.length > 0))))
                    {
                        for each (ach in data.achievements)
                        {
                            if (ach)
                            {
                                _local_6++;
                                if (this._finishedAchievementsId.indexOf(ach.id) != -1)
                                {
                                    _local_5++;
                                };
                            };
                        };
                        percent = Math.floor(((_local_5 / _local_6) * 100));
                        componentsRef.lbl_catPercent.text = (percent + "%");
                    }
                    else
                    {
                        componentsRef.lbl_catPercent.text = "";
                    };
                    componentsRef.btn_cat.selected = selected;
                    break;
            };
        }

        public function getCatLineType(data:*, line:uint):String
        {
            if (!(data))
            {
                return ("");
            };
            switch (line)
            {
                case 0:
                    if (((data) && (data.hasOwnProperty("subcats"))))
                    {
                        return (CTR_CAT_TYPE_CAT);
                    };
                    return (CTR_CAT_TYPE_SUBCAT);
                default:
                    return (CTR_CAT_TYPE_SUBCAT);
            };
        }

        public function getCatDataLength(data:*, selected:Boolean)
        {
            if (selected)
            {
                trace(((data.title + " : ") + (2 + ((selected) ? data.subcats.length : 0))));
            };
            return ((2 + ((selected) ? data.subcats.length : 0)));
        }

        public function updateAchievement(data:*, compRef:*, selected:Boolean, line:uint):void
        {
            var _local_5:Object;
            var _local_6:Object;
            var _local_7:Boolean;
            var _local_8:Object;
            var _local_9:Array;
            var achId:int;
            var value:int;
            var maxValue:int;
            var i:int;
            var rewardId:uint;
            var item:ItemWrapper;
            var emote:EmoteWrapper;
            var spell:SpellWrapper;
            var title:TitleWrapper;
            var ornament:OrnamentWrapper;
            switch (this.getAchievementLineType(data, line))
            {
                case CTR_ACH_ACHIEVEMENT:
                    if (!(this._ctrAchPointsList[compRef.ctr_achPoints.name]))
                    {
                        this.uiApi.addComponentHook(compRef.ctr_achPoints, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.ctr_achPoints, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._ctrAchPointsList[compRef.ctr_achPoints.name] = data;
                    if (!(this._ctrAchBtnsList[compRef.btn_ach.name]))
                    {
                        this.uiApi.addComponentHook(compRef.btn_ach, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrAchBtnsList[compRef.btn_ach.name] = data;
                    compRef.btn_ach.handCursor = true;
                    compRef.lbl_name.text = data.name;
                    compRef.lbl_points.text = data.points;
                    compRef.lbl_description.text = data.description;
                    compRef.tx_icon.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("achievementPath") + data.iconId) + ".png"));
                    if (((this._catFinishedAchievements[data.id]) || (!((this._finishedAchievementsId.indexOf(data.id) == -1)))))
                    {
                        compRef.tx_bg.gotoAndStop = 2;
                    }
                    else
                    {
                        compRef.tx_bg.gotoAndStop = 1;
                    };
                    break;
                case CTR_ACH_OBJECTIVES:
                    this._selectedAndOpenedAchievementId = this._selectedAchievementId;
                    if (this._catProgressingAchievements[this._selectedAchievementId])
                    {
                        _local_5 = this._catProgressingAchievements[this._selectedAchievementId];
                    }
                    else
                    {
                        if (this._catFinishedAchievements[this._selectedAchievementId])
                        {
                            _local_5 = this._catFinishedAchievements[this._selectedAchievementId];
                        };
                    };
                    if (!(_local_5)) break;
                    for each (_local_8 in _local_5.finishedObjective)
                    {
                        if (_local_8.id == data.objectiveData.id)
                        {
                            _local_6 = _local_8;
                            _local_7 = true;
                        };
                    };
                    if (!(_local_7))
                    {
                        for each (_local_8 in _local_5.startedObjectives)
                        {
                            if (_local_8.id == data.objectiveData.id)
                            {
                                _local_6 = _local_8;
                            };
                        };
                    };
                    if (!(_local_6)) break;
                    if (_local_6.maxValue == 1)
                    {
                        compRef.lbl_objectiveBin.text = data.objectiveData.name;
                        if (((_local_7) || ((_local_6.value == 1))))
                        {
                            compRef.tx_objectiveBin.gotoAndStop = "selected";
                            compRef.lbl_objectiveBin.alpha = 0.5;
                        }
                        else
                        {
                            compRef.tx_objectiveBin.gotoAndStop = "normal";
                            compRef.lbl_objectiveBin.alpha = 1;
                        };
                        compRef.ctr_objectiveBin.visible = true;
                        compRef.ctr_objectiveProgress.visible = false;
                        if (data.objectiveData.criterion.indexOf("OA") == 0)
                        {
                            if (!(this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name]))
                            {
                                this.uiApi.addComponentHook(compRef.ctr_objectiveBin, ComponentHookList.ON_ROLL_OVER);
                                this.uiApi.addComponentHook(compRef.ctr_objectiveBin, ComponentHookList.ON_ROLL_OUT);
                                this.uiApi.addComponentHook(compRef.ctr_objectiveBin, ComponentHookList.ON_RELEASE);
                            };
                            achId = int(data.objectiveData.criterion.substr(3));
                            this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = achId;
                            compRef.lbl_objectiveBin.text = (compRef.lbl_objectiveBin.text + (" " + this.uiApi.getText("ui.common.fakeLinkSee")));
                            compRef.ctr_objectiveBin.handCursor = true;
                        }
                        else
                        {
                            compRef.ctr_objectiveBin.handCursor = false;
                            this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = 0;
                        };
                    }
                    else
                    {
                        maxValue = _local_6.maxValue;
                        if (_local_7)
                        {
                            value = maxValue;
                        }
                        else
                        {
                            value = _local_6.value;
                        };
                        compRef.lbl_objectiveProgress.text = ((value + "/") + maxValue);
                        compRef.tx_objectiveProgress.width = int(((value / maxValue) * GAUGE_WIDTH_OBJECTIVE));
                        this._colorTransform.color = data.color;
                        compRef.tx_objectiveProgress.transform.colorTransform = this._colorTransform;
                        compRef.ctr_objectiveBin.visible = false;
                        compRef.ctr_objectiveProgress.visible = true;
                    };
                    break;
                case CTR_ACH_REWARDS:
                    compRef.lbl_rewardsKama.text = this.utilApi.formateIntToString(data.kamas);
                    compRef.lbl_rewardsXp.text = this.utilApi.formateIntToString(data.xp);
                    if (data.rewardable)
                    {
                        compRef.btn_accept.visible = true;
                    }
                    else
                    {
                        compRef.btn_accept.visible = false;
                    };
                    _local_9 = new Array();
                    if (data.rewardData)
                    {
                        i = 0;
                        while (i < data.rewardData.itemsReward.length)
                        {
                            item = this.dataApi.getItemWrapper(data.rewardData.itemsReward[i], 0, 0, data.rewardData.itemsQuantityReward[i]);
                            _local_9.push(item);
                            i++;
                        };
                        for each (rewardId in data.rewardData.emotesReward)
                        {
                            emote = this.dataApi.getEmoteWrapper(rewardId);
                            _local_9.push(emote);
                        };
                        for each (rewardId in data.rewardData.spellsReward)
                        {
                            spell = this.dataApi.getSpellWrapper(rewardId);
                            _local_9.push(spell);
                        };
                        for each (rewardId in data.rewardData.titlesReward)
                        {
                            title = this.dataApi.getTitleWrapper(rewardId);
                            _local_9.push(title);
                        };
                        for each (rewardId in data.rewardData.ornamentsReward)
                        {
                            ornament = this.dataApi.getOrnamentWrapper(rewardId);
                            _local_9.push(ornament);
                        };
                    };
                    compRef.gd_rewards.dataProvider = _local_9;
                    if (!(this._rewardsListList[compRef.gd_rewards.name]))
                    {
                        this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OUT);
                    };
                    this._rewardsListList[compRef.gd_rewards.name] = data;
                    if (!(this._btnsAcceptRewardList[compRef.btn_accept.name]))
                    {
                        this.uiApi.addComponentHook(compRef.btn_accept, ComponentHookList.ON_RELEASE);
                        this.uiApi.addComponentHook(compRef.btn_accept, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_accept, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._btnsAcceptRewardList[compRef.btn_accept.name] = this._selectedAchievementId;
                    break;
            };
        }

        public function getAchievementLineType(data:*, line:uint):String
        {
            if (!(data))
            {
                return ("");
            };
            switch (line)
            {
                case 0:
                    if (((data) && (data.hasOwnProperty("rewardData"))))
                    {
                        return (CTR_ACH_REWARDS);
                    };
                    if (((data) && (data.hasOwnProperty("objectiveData"))))
                    {
                        return (CTR_ACH_OBJECTIVES);
                    };
                    return (CTR_ACH_ACHIEVEMENT);
                default:
                    return (CTR_ACH_OBJECTIVES);
            };
        }

        public function getAchievementDataLength(data:*, selected:Boolean)
        {
            return (1);
        }

        private function updateAchievementGrid(catId:int):void
        {
            var ach:Achievement;
            var category:AchievementCategory;
            var tempAchs:Array;
            var ts:uint;
            var result:Object;
            var titleName:String;
            var critSplit:Array;
            var options:String;
            var nameResult:Object;
            var objectiveResult:Object;
            var rewardResult:Object;
            var achObj:Object;
            var currentCriteria:String;
            var wannabeCriteria:String;
            var crit:String;
            var index:int;
            var indexToScroll:int;
            var achievements:Array = new Array();
            this._selectedAndOpenedAchievementId = 0;
            if (!(this._searchCriteria))
            {
                if (catId == 0)
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
                    for each (ach in category.achievements)
                    {
                        if (ach)
                        {
                            if (((this._hideAchievedAchievement) && ((this._finishedAchievementsId.indexOf(ach.id) > -1))))
                            {
                            }
                            else
                            {
                                tempAchs.push(ach);
                            };
                        };
                    };
                    tempAchs.sortOn("order", Array.NUMERIC);
                    for each (ach in tempAchs)
                    {
                        achievements.push(ach);
                        achievements.push(null);
                        achievements.push(null);
                        if (ach.id == this._selectedAchievementId)
                        {
                            indexToScroll = index;
                            achievements = achievements.concat(this.addObjectivesAndRewards(ach, category));
                        };
                        index++;
                        index++;
                        index++;
                    };
                };
            }
            else
            {
                if (this._previousSearchCriteria != ((((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward))
                {
                    ts = getTimer();
                    titleName = (((this.playerApi.getPlayedCharacterInfo().sex == 0)) ? "nameMale" : "nameFemale");
                    critSplit = ((this._previousSearchCriteria) ? this._previousSearchCriteria.split("#") : []);
                    if (this._searchCriteria != critSplit[0])
                    {
                        nameResult = this.dataApi.queryUnion(this.dataApi.queryString(Achievement, "description", this._searchCriteria), this.dataApi.queryString(Achievement, "name", this._searchCriteria));
                        objectiveResult = this.dataApi.queryEquals(Achievement, "objectiveIds", this.dataApi.queryString(AchievementObjective, "name", this._searchCriteria));
                        rewardResult = this.dataApi.queryEquals(Achievement, "rewardIds", this.dataApi.queryUnion(this.dataApi.queryEquals(AchievementReward, "itemsReward", this.dataApi.queryString(Item, "name", this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "emotesReward", this.dataApi.queryString(Emoticon, "name", this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "spellsReward", this.dataApi.queryString(Spell, "name", this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "titlesReward", this.dataApi.queryString(Title, titleName, this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "ornamentsReward", this.dataApi.queryString(Ornament, "name", this._searchCriteria))));
                        this._searchResultByCriteriaList["_searchOnName"] = nameResult;
                        this._searchResultByCriteriaList["_searchOnObjective"] = objectiveResult;
                        this._searchResultByCriteriaList["_searchOnReward"] = rewardResult;
                        if (((((nameResult) || (objectiveResult))) || (rewardResult)))
                        {
                            this.sysApi.log(2, (((("Result : " + ((((nameResult) ? nameResult.length : 0) + ((objectiveResult) ? objectiveResult.length : 0)) + ((rewardResult) ? rewardResult.length : 0))) + " in ") + (getTimer() - ts)) + " ms"));
                        };
                    };
                    options = ((((("" + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward);
                    switch (options)
                    {
                        case "truetruetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnObjective"], this._searchResultByCriteriaList["_searchOnReward"]));
                            break;
                        case "truetruefalse":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnObjective"]));
                            break;
                        case "truefalsetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnReward"]));
                            break;
                        case "truefalsefalse":
                            result = this.dataApi.queryReturnInstance(Achievement, this._searchResultByCriteriaList["_searchOnName"]);
                            break;
                        case "falsetruetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnObjective"], this._searchResultByCriteriaList["_searchOnReward"]));
                            break;
                        case "falsetruefalse":
                            result = this.dataApi.queryReturnInstance(Achievement, this._searchResultByCriteriaList["_searchOnObjective"]);
                            break;
                        case "falsefalsetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this._searchResultByCriteriaList["_searchOnReward"]);
                            break;
                        case "falsefalsefalse":
                            this.gd_achievements.dataProvider = new Array();
                            this.lbl_noAchievement.visible = true;
                            this.lbl_noAchievement.text = this.uiApi.getText("ui.search.needCriterion");
                            this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward);
                            return;
                    };
                    for each (ach in result)
                    {
                        if (((this._hideAchievedAchievement) && ((this._finishedAchievementsId.indexOf(ach.id) > -1))))
                        {
                        }
                        else
                        {
                            achievements.push(ach);
                            achievements.push(null);
                            achievements.push(null);
                            if (ach.id == this._selectedAchievementId)
                            {
                                achievements = achievements.concat(this.addObjectivesAndRewards(ach, ach.category));
                            };
                        };
                    };
                }
                else
                {
                    for each (achObj in this.gd_achievements.dataProvider)
                    {
                        if (((achObj) && ((achObj is Achievement))))
                        {
                            achievements.push(achObj);
                            achievements.push(null);
                            achievements.push(null);
                            if (achObj.id == this._selectedAchievementId)
                            {
                                indexToScroll = index;
                                achievements = achievements.concat(this.addObjectivesAndRewards((achObj as Achievement), achObj.category));
                            };
                            index++;
                            index++;
                            index++;
                        };
                    };
                };
            };
            this.gd_achievements.dataProvider = achievements;
            if (this._forceOpenAchievement)
            {
                this._forceOpenAchievement = false;
                this.gd_achievements.moveTo(indexToScroll, true);
            };
            if (this._currentScrollValue != 0)
            {
                this.gd_achievements.verticalScrollValue = this._currentScrollValue;
            };
            if (achievements.length > 0)
            {
                this.lbl_noAchievement.visible = false;
            }
            else
            {
                this.lbl_noAchievement.visible = true;
                this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResult");
                if (this._searchCriteria)
                {
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
                        this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultFor", this._searchCriteria);
                    }
                    else
                    {
                        this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultsBut", currentCriteria, wannabeCriteria);
                    };
                };
            };
            this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward);
        }

        private function addObjectivesAndRewards(ach:Achievement, category:AchievementCategory):Array
        {
            var objectiveId:int;
            var reward:Object;
            var rewardId:int;
            var finishedLevel:int;
            var rewardable:Boolean;
            var o:AchievementObjective;
            var r:AchievementReward;
            var level:int;
            var ar:AchievementRewardable;
            var achievements:Array = new Array();
            for each (objectiveId in ach.objectiveIds)
            {
                o = this.dataApi.getAchievementObjective(objectiveId);
                if (o)
                {
                    if (category.parentId == 0)
                    {
                        achievements.push({
                            "objectiveData":o,
                            "color":category.color
                        });
                    }
                    else
                    {
                        achievements.push({
                            "objectiveData":o,
                            "color":this.dataApi.getAchievementCategory(category.parentId).color
                        });
                    };
                };
            };
            reward = {
                "rewardData":null,
                "kamas":0,
                "xp":0,
                "rewardable":false
            };
            for each (rewardId in ach.rewardIds)
            {
                r = this.dataApi.getAchievementReward(rewardId);
                if (r)
                {
                    level = this.playerApi.getPlayedCharacterInfo().level;
                    if ((((((r.levelMin == -1)) || ((r.levelMin <= level)))) && ((((r.levelMax >= level)) || ((r.levelMax == -1))))))
                    {
                        reward.rewardData = r;
                        break;
                    };
                };
            };
            if (this._finishedAchievementsId.indexOf(ach.id) != -1)
            {
                for each (ar in this.questApi.getRewardableAchievements())
                {
                    if (ar.id == ach.id)
                    {
                        finishedLevel = ar.finishedlevel;
                        rewardable = true;
                        break;
                    };
                };
            };
            reward.kamas = this.questApi.getAchievementKamasReward(ach, finishedLevel);
            reward.xp = this.questApi.getAchievementExperienceReward(ach, finishedLevel);
            reward.rewardable = rewardable;
            achievements.push(reward);
            achievements.push(null);
            achievements.push(null);
            return (achievements);
        }

        private function updateCategories(selectedCategory:Object, forceOpen:Boolean=false, fakeOpen:Boolean=false):void
        {
            var alreadyInTheRightCategory:Boolean;
            var myIndex:int;
            var cat:Object;
            var cat2:Object;
            var subcat:Object;
            if (!(fakeOpen))
            {
                if ((((selectedCategory.id > 0)) && (!((this._currentSelectedCatId == selectedCategory.id)))))
                {
                    this.sysApi.sendAction(new AchievementDetailedListRequest(selectedCategory.id));
                }
                else
                {
                    alreadyInTheRightCategory = true;
                };
                if ((((((selectedCategory.parentId > 0)) && ((this._openCatIndex == selectedCategory.parentId)))) || ((this._openCatIndex == selectedCategory.id))))
                {
                    this._currentSelectedCatId = selectedCategory.id;
                    for each (cat2 in this.gd_categories.dataProvider)
                    {
                        if (cat2.id == this._currentSelectedCatId)
                        {
                            break;
                        };
                        myIndex++;
                    };
                    if (this.gd_categories.selectedIndex != myIndex)
                    {
                        this.gd_categories.silent = true;
                        this.gd_categories.selectedIndex = myIndex;
                        this.gd_categories.silent = false;
                    };
                    if (((this._forceOpenAchievement) && (alreadyInTheRightCategory)))
                    {
                        this.updateAchievementGrid(this._currentSelectedCatId);
                    };
                    if (this._openCatIndex != selectedCategory.id)
                    {
                        return;
                    };
                };
            };
            var bigCatId:int = selectedCategory.id;
            if (selectedCategory.parentId > 0)
            {
                bigCatId = selectedCategory.parentId;
            };
            var index:int = -1;
            var tempCats:Array = new Array();
            var categoryOpened:int = -1;
            for each (cat in this._categories)
            {
                tempCats.push(cat);
                index++;
                if (bigCatId == cat.id)
                {
                    myIndex = index;
                    if (((((!((this._currentSelectedCatId == cat.id))) || ((this._openCatIndex == 0)))) || (forceOpen)))
                    {
                        categoryOpened = cat.id;
                        for each (subcat in cat.subcats)
                        {
                            tempCats.push(subcat);
                            index++;
                            if (subcat.id == selectedCategory.id)
                            {
                                myIndex = index;
                            };
                        };
                    };
                };
            };
            if (categoryOpened >= 0)
            {
                this._openCatIndex = categoryOpened;
            }
            else
            {
                this._openCatIndex = 0;
            };
            if (!(fakeOpen))
            {
                this._currentSelectedCatId = selectedCategory.id;
            };
            this.gd_categories.dataProvider = tempCats;
            if (this.gd_categories.selectedIndex != myIndex)
            {
                this.gd_categories.silent = true;
                this.gd_categories.selectedIndex = myIndex;
                this.gd_categories.silent = false;
            };
            if (((!(fakeOpen)) && ((this._currentSelectedCatId == 0))))
            {
                this.updateAchievementGrid(this._currentSelectedCatId);
            };
        }

        private function updateGeneralInfo():void
        {
            this.lbl_myPoints.text = this.utilApi.kamasToString(this._succesPoints, "");
            var percent:int = Math.floor(((this._finishedAchievementsId.length / this._dataAchievements.length) * 100));
            this.lbl_percent.text = (percent + "%");
            this._colorTransform.color = 16761925;
            this.tx_progress.transform.colorTransform = this._colorTransform;
            this.tx_progress.width = int(((this._finishedAchievementsId.length / this._dataAchievements.length) * GAUGE_WIDTH_TOTAL));
        }

        private function getMountPercentXp():int
        {
            var xpRatio:int;
            if (((((!((this.playerApi.getMount() == null))) && (this.playerApi.isRidding()))) && ((this.playerApi.getMount().xpRatio > 0))))
            {
                xpRatio = this.playerApi.getMount().xpRatio;
            };
            return (xpRatio);
        }

        private function changeSearchOnName():void
        {
            this._searchOnName = !(this._searchOnName);
            Grimoire.getInstance().achievementSearchOnName = this._searchOnName;
            if (((((!(this._searchOnName)) && (!(this._searchOnObjective)))) && (!(this._searchOnReward))))
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
                this.updateAchievementGrid(this.gd_categories.selectedItem);
            };
        }

        private function changeSearchOnObjective():void
        {
            this._searchOnObjective = !(this._searchOnObjective);
            Grimoire.getInstance().achievementSearchOnObjective = this._searchOnObjective;
            if (((((!(this._searchOnName)) && (!(this._searchOnObjective)))) && (!(this._searchOnReward))))
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
                this.updateAchievementGrid(this.gd_categories.selectedItem);
            };
        }

        private function changeSearchOnReward():void
        {
            this._searchOnReward = !(this._searchOnReward);
            Grimoire.getInstance().achievementSearchOnReward = this._searchOnReward;
            if (((((!(this._searchOnName)) && (!(this._searchOnObjective)))) && (!(this._searchOnReward))))
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
                this.updateAchievementGrid(this.gd_categories.selectedItem);
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.gd_categories)
            {
                if (selectMethod != GridItemSelectMethodEnum.AUTO)
                {
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this._currentScrollValue = 0;
                    this.updateCategories(target.selectedItem);
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (((item.data) && (!((target.name.indexOf("gd_rewards") == -1)))))
            {
                data = item.data;
                if ((((data == null)) || (!((data is ItemWrapper)))))
                {
                    return;
                };
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var pos:Object;
            if (((item.data) && (!((target.name.indexOf("gd_rewards") == -1)))))
            {
                pos = {
                    "point":LocationEnum.POINT_BOTTOM,
                    "relativePoint":LocationEnum.POINT_TOP
                };
                if ((item.data is ItemWrapper))
                {
                    text = item.data.name;
                    text = (text + this.averagePricesApi.getItemAveragePriceString(item.data, true));
                }
                else
                {
                    if ((item.data is EmoteWrapper))
                    {
                        text = this.uiApi.getText("ui.common.emote", item.data.emote.name);
                    }
                    else
                    {
                        if ((item.data is SpellWrapper))
                        {
                            text = this.uiApi.getText("ui.common.spell", item.data.spell.name);
                        }
                        else
                        {
                            if ((item.data is TitleWrapper))
                            {
                                text = this.uiApi.getText("ui.common.title", item.data.title.name);
                            }
                            else
                            {
                                if ((item.data is OrnamentWrapper))
                                {
                                    text = this.uiApi.getText("ui.common.ornament", item.data.name);
                                };
                            };
                        };
                    };
                };
                if (text)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            var _local_2:Array;
            var data:Object;
            var achievement:Achievement;
            var category:AchievementCategory;
            var achMetaId:int;
            switch (target)
            {
                case this.btn_resetSearch:
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                    break;
                case this.btn_searchFilter:
                    _local_2 = new Array();
                    _local_2.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"], this.changeSearchOnName, null, false, null, this._searchOnName, false));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnObjective"], this.changeSearchOnObjective, null, false, null, this._searchOnObjective, false));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnReward"], this.changeSearchOnReward, null, false, null, this._searchOnReward, false));
                    this.modContextMenu.createContextMenu(_local_2);
                    break;
                case this.btn_hideCompletedAchievements:
                    this._hideAchievedAchievement = this.btn_hideCompletedAchievements.selected;
                    this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                    break;
                default:
                    if (target.name.indexOf("ctr_illu") != -1)
                    {
                        this._searchCriteria = null;
                        this.inp_search.text = "";
                        this.gd_categories.selectedIndex = (this._catIlluBtnList[target.name].order + 1);
                    }
                    else
                    {
                        if (target.name.indexOf("btn_ach") != -1)
                        {
                            if (this.uiApi.keyIsDown(Keyboard.SHIFT))
                            {
                                this.sysApi.dispatchHook(MouseShiftClick, {"data":this._ctrAchBtnsList[target.name]});
                                break;
                            };
                            data = this._ctrAchBtnsList[target.name];
                            if ((((this._selectedAchievementId == 0)) || (!((this._selectedAchievementId == data.id)))))
                            {
                                this.gd_achievements.selectedItem = data;
                                this._selectedAchievementId = data.id;
                            }
                            else
                            {
                                this._selectedAchievementId = 0;
                            };
                            if ((((((this._selectedAchievementId > 0)) && (!(this._catProgressingAchievements[this._selectedAchievementId])))) && (!(this._catFinishedAchievements[this._selectedAchievementId]))))
                            {
                                this.sysApi.sendAction(new AchievementDetailsRequest(this._selectedAchievementId));
                            }
                            else
                            {
                                this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                                if (((((!((this._searchCriteria == ""))) && (!((this._searchCriteria == null))))) && ((this._selectedAchievementId > 0))))
                                {
                                    achievement = this.dataApi.getAchievement(this._selectedAchievementId);
                                    category = this.dataApi.getAchievementCategory(achievement.categoryId);
                                    this.updateCategories(category, true, true);
                                };
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("ctr_objectiveBin") != -1)
                            {
                                achMetaId = this._ctrObjectiveMetaList[target.name];
                                if (achMetaId > 0)
                                {
                                    this.uiApi.hideTooltip();
                                    this.onOpenAchievement("achievementTab", {
                                        "forceOpen":true,
                                        "achievementId":achMetaId
                                    });
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("btn_accept") != -1)
                                {
                                    this.uiApi.hideTooltip();
                                    this.sysApi.sendAction(new AchievementRewardRequest(this._btnsAcceptRewardList[target.name]));
                                };
                            };
                        };
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var _local_4:String;
            var achMetaId:int;
            var achMeta:Achievement;
            var myMountXp:int;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            switch (target)
            {
                case this.lbl_myPoints:
                    _local_4 = ((this.utilApi.kamasToString(this._succesPoints, "") + " / ") + this.utilApi.kamasToString(this._totalSuccesPoints, ""));
                    text = this.uiApi.processText(this.uiApi.getText("ui.achievement.successPoints", _local_4), "n", false);
                    break;
                case this.ctr_globalProgress:
                    text = ((this._finishedAchievementsId.length + "/") + this._dataAchievements.length);
                    break;
                case this.btn_searchFilter:
                    text = this.uiApi.getText("ui.search.criteria");
                    break;
                default:
                    if (target.name.indexOf("ctr_achPoints") != -1)
                    {
                        text = this.uiApi.getText("ui.achievement.successPointsText");
                    }
                    else
                    {
                        if (target.name.indexOf("ctr_objectiveBin") != -1)
                        {
                            achMetaId = this._ctrObjectiveMetaList[target.name];
                            if (achMetaId > 0)
                            {
                                achMeta = this.dataApi.getAchievement(achMetaId);
                                text = achMeta.description;
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("ctr_progress") != -1)
                            {
                                text = ((this._catProgressBarList[target.name].value + "/") + this._catProgressBarList[target.name].total);
                            }
                            else
                            {
                                if (target.name.indexOf("btn_accept") != -1)
                                {
                                    text = this.uiApi.getText("ui.achievement.rewardsGet");
                                    myMountXp = this.getMountPercentXp();
                                    if (myMountXp)
                                    {
                                        text = (text + ("\n" + this.uiApi.getText("ui.achievement.mountXpPercent", myMountXp)));
                                    };
                                    if (this._myGuildXp)
                                    {
                                        text = (text + ("\n" + this.uiApi.getText("ui.achievement.guildXpPercent", this._myGuildXp)));
                                    };
                                };
                            };
                        };
                    };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
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
                this._currentScrollValue = 0;
                if (this._openCatIndex == 0)
                {
                    this.ctr_achievements.visible = true;
                    this.ctr_summary.visible = false;
                };
                this.updateAchievementGrid(this._currentSelectedCatId);
            }
            else
            {
                if (this._searchCriteria)
                {
                    this._searchCriteria = null;
                };
                if (this.inp_search.text.length == 0)
                {
                    this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                };
            };
        }

        public function onParseObjectives(i:int=0):void
        {
            Grimoire.getInstance().objectivesTextByAchievement = this._objectivesTextByAchievementId;
            this.updateAchievementGrid(this.gd_categories.selectedItem.id);
            this.onCancelSearch();
        }

        private function onCancelSearch():void
        {
            clearTimeout(this._searchSettimoutId);
            if (this._progressPopupName)
            {
                this.uiApi.unloadUi(this._progressPopupName);
                this._progressPopupName = null;
            };
        }

        private function onAchievementList(finishedAchievementsIds:Object):void
        {
            var currentNb:int;
            var totalNb:int;
            var cat:AchievementCategory;
            var ach:Achievement;
            var finishedId:int;
            var total:int;
            var finishedAch:Achievement;
            this._progressCategories = new Array();
            this._finishedAchievementsId = new Array();
            var tempCatArray:Array = new Array();
            this._succesPoints = 0;
            for each (finishedId in finishedAchievementsIds)
            {
                if (this._finishedAchievementsId.indexOf(finishedId) == -1)
                {
                    finishedAch = this.dataApi.getAchievement(finishedId);
                    if (finishedAch)
                    {
                        this._succesPoints = (this._succesPoints + finishedAch.points);
                    };
                    this._finishedAchievementsId.push(finishedId);
                };
            };
            for each (cat in this._dataCategories)
            {
                if (cat.parentId > 0)
                {
                    if (!(tempCatArray[cat.parentId]))
                    {
                        tempCatArray[cat.parentId] = {
                            "value":0,
                            "total":0
                        };
                    };
                    totalNb = 0;
                    currentNb = 0;
                    for each (ach in cat.achievements)
                    {
                        if (ach)
                        {
                            if (this._finishedAchievementsId.indexOf(ach.id) != -1)
                            {
                                currentNb++;
                            };
                            totalNb++;
                        };
                    };
                    tempCatArray[cat.parentId] = {
                        "value":(tempCatArray[cat.parentId].value + currentNb),
                        "total":(tempCatArray[cat.parentId].total + totalNb)
                    };
                };
            };
            for each (cat in this._dataCategories)
            {
                if (cat.parentId == 0)
                {
                    if (!(tempCatArray[cat.id]))
                    {
                        tempCatArray[cat.id] = {
                            "value":0,
                            "total":0
                        };
                    };
                    total = 0;
                    totalNb = 0;
                    currentNb = 0;
                    for each (ach in cat.achievements)
                    {
                        if (ach)
                        {
                            if (this._finishedAchievementsId.indexOf(ach.id) != -1)
                            {
                                currentNb++;
                            };
                            totalNb++;
                        };
                    };
                    if (tempCatArray[cat.id])
                    {
                        currentNb = (currentNb + tempCatArray[cat.id].value);
                        total = (totalNb + tempCatArray[cat.id].total);
                    };
                    this._progressCategories.push({
                        "id":cat.id,
                        "name":cat.name,
                        "value":currentNb,
                        "total":total,
                        "color":cat.color,
                        "icon":cat.icon,
                        "order":cat.order
                    });
                };
            };
            this._progressCategories.sortOn("order", Array.NUMERIC);
            this.gd_summary.dataProvider = this._progressCategories;
            this.updateGeneralInfo();
            if (this._forceOpenAchievement)
            {
                this.onOpenAchievement("achievementTab", {
                    "forceOpen":true,
                    "achievementId":this._selectedAchievementId
                });
            };
        }

        private function onAchievementFinished(finishedAchievementId:int):void
        {
            var cat:Object;
            var finishedAch:Achievement = this.dataApi.getAchievement(finishedAchievementId);
            if (finishedAch)
            {
                this._succesPoints = (this._succesPoints + finishedAch.points);
            };
            var catFrom:AchievementCategory = this.dataApi.getAchievementCategory(finishedAch.categoryId);
            for each (cat in this._progressCategories)
            {
                if ((((cat.id == catFrom.id)) || ((cat.id == catFrom.parentId))))
                {
                    cat.value = (cat.value + 1);
                };
            };
            this.gd_summary.dataProvider = this._progressCategories;
            this._finishedAchievementsId.push(finishedAchievementId);
            this.updateGeneralInfo();
        }

        private function onAchievementDetailedList(finishedAchievements:Object, startedAchievements:Object):void
        {
            var ach:Object;
            for each (ach in finishedAchievements)
            {
                this._catFinishedAchievements[ach.id] = ach;
                this._catProgressingAchievements[ach.id] = null;
            };
            for each (ach in startedAchievements)
            {
                this._catProgressingAchievements[ach.id] = ach;
                this._catFinishedAchievements[ach.id] = null;
            };
            this.updateAchievementGrid(this._currentSelectedCatId);
        }

        private function onAchievementDetails(achievement:Object):void
        {
            if (this._finishedAchievementsId.indexOf(achievement.id) == -1)
            {
                this._catProgressingAchievements[achievement.id] = achievement;
                this._catFinishedAchievements[achievement.id] = null;
            }
            else
            {
                this._catFinishedAchievements[achievement.id] = achievement;
                this._catProgressingAchievements[achievement.id] = null;
            };
            this.updateAchievementGrid(this._currentSelectedCatId);
            var achievementData:Achievement = this.dataApi.getAchievement(achievement.id);
            var category:AchievementCategory = this.dataApi.getAchievementCategory(achievementData.categoryId);
            this.updateCategories(category, true, true);
        }

        private function onAchievementRewardSuccess(achievementId:int):void
        {
            this.updateAchievementGrid(this._currentSelectedCatId);
        }

        public function onGuildInformationsMemberUpdate(member:Object):void
        {
            if (member.id == this.playerApi.id())
            {
                this._myGuildXp = member.experienceGivenPercent;
            };
        }

        private function onOpenAchievement(tab:String=null, param:Object=null):void
        {
            var achievement:Achievement;
            var category:AchievementCategory;
            if ((((((tab == "achievementTab")) && (param))) && (param.forceOpen)))
            {
                this._selectedAchievementId = param.achievementId;
                this.ctr_achievements.visible = true;
                this.ctr_summary.visible = false;
                this._forceOpenAchievement = true;
                this._searchCriteria = null;
                this.inp_search.text = "";
                if (((!((this._finishedAchievementsId.indexOf(this._selectedAchievementId) == -1))) && ((this._hideAchievedAchievement == true))))
                {
                    this._hideAchievedAchievement = false;
                    this.btn_hideCompletedAchievements.selected = false;
                };
                achievement = this.dataApi.getAchievement(this._selectedAchievementId);
                category = this.dataApi.getAchievementCategory(achievement.categoryId);
                this.updateCategories(category, true);
            };
        }


    }
}//package ui

