package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.ContextMenuApi;
    import d2api.AveragePricesApi;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import d2components.Grid;
    import d2components.Input;
    import d2components.Texture;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2hooks.OpenBook;
    import d2hooks.KeyUp;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import d2data.SubArea;
    import d2data.Monster;
    import d2data.MonsterGrade;
    import d2data.MonsterDrop;
    import d2data.ItemWrapper;
    import __AS3__.vec.Vector;
    import flash.utils.getTimer;
    import d2data.Item;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2enums.LocationEnum;
    import d2data.MonsterMiniBoss;
    import flash.ui.Keyboard;
    import d2hooks.MouseShiftClick;
    import flash.utils.clearTimeout;
    import d2data.MonsterRace;
    import d2hooks.*;
    import d2actions.*;
    import __AS3__.vec.*;

    public class BestiaryTab 
    {

        private static var CTR_CAT_TYPE_CAT:String = "ctr_cat";
        private static var CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
        private static var CTR_MONSTER_BASE:String = "ctr_monster";
        private static var CTR_MONSTER_AREAS:String = "ctr_subareas";
        private static var CTR_MONSTER_DETAILS:String = "ctr_details";
        private static var CTR_MONSTER_DROPS:String = "ctr_drops";
        private static var CAT_TYPE_AREA:int = 0;
        private static var CAT_TYPE_RACE:int = 1;
        private static var NB_DROP_PER_LINE:int = 12;
        private static var AREA_LINE_HEIGHT:int;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var menuApi:ContextMenuApi;
        public var averagePricesApi:AveragePricesApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Cartography")]
        public var modCartography:Object;
        private var _currentCategoryType:int;
        private var _openCatIndex:int;
        private var _currentSelectedCatId:int;
        private var _selectedMonsterId:int;
        private var _selectedAndOpenedMonsterId:int;
        private var _uriRareDrop:String;
        private var _uriOkDrop:String;
        private var _uriSpecialSlot:String;
        private var _uriEmptySlot:String;
        private var _uriStatPicto:String;
        private var _uriMonsterSprite:String;
        private var _lastRaceSelected:Object;
        private var _lastAreaSelected:Object;
        private var _categoriesRace:Array;
        private var _categoriesArea:Array;
        private var _monstersListToDisplay:Array;
        private var _lockSearchTimer:Timer;
        private var _previousSearchCriteria:String;
        private var _searchCriteria:String;
        private var _forceOpenMonster:Boolean;
        private var _currentScrollValue:int;
        private var _mapPopup:String;
        private var _ctrBtnMonsterLocation:Dictionary;
        private var _ctrBtnMonster:Dictionary;
        private var _ctrSlotDrop:Dictionary;
        private var _ctrTxLink:Dictionary;
        private var _progressPopupName:String;
        private var _searchSettimoutId:uint;
        private var _searchTextByCriteriaList:Dictionary;
        private var _searchResultByCriteriaList:Dictionary;
        private var _searchOnName:Boolean;
        private var _searchOnDrop:Boolean;
        public var gd_categories:Grid;
        public var gd_monsters:Grid;
        public var inp_search:Input;
        public var tx_inputBg:Texture;
        public var btn_resetSearch:ButtonContainer;
        public var btn_searchFilter:ButtonContainer;
        public var btn_races:ButtonContainer;
        public var btn_subareas:ButtonContainer;
        public var btn_displayCriteriaDrop:ButtonContainer;
        public var lbl_noMonster:Label;

        public function BestiaryTab()
        {
            this._categoriesRace = new Array();
            this._categoriesArea = new Array();
            this._monstersListToDisplay = new Array();
            this._ctrBtnMonsterLocation = new Dictionary(true);
            this._ctrBtnMonster = new Dictionary(true);
            this._ctrSlotDrop = new Dictionary(true);
            this._ctrTxLink = new Dictionary(true);
            this._searchTextByCriteriaList = new Dictionary(true);
            this._searchResultByCriteriaList = new Dictionary(true);
            super();
        }

        public function main(oParam:Object=null):void
        {
            var mySubArea:Object;
            var area:Object;
            var openMonsterId:int;
            var subcat:Object;
            var mId:int;
            this.sysApi.addHook(OpenBook, this.onOpenBestiary);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addComponentHook(this.gd_categories, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_displayCriteriaDrop, ComponentHookList.ON_RELEASE);
            this._lockSearchTimer = new Timer(500, 1);
            this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            AREA_LINE_HEIGHT = int(this.uiApi.me().getConstant("area_line_height"));
            this._uriRareDrop = this.uiApi.me().getConstant("rareDrop_uri");
            this._uriOkDrop = this.uiApi.me().getConstant("okDrop_uri");
            this._uriStatPicto = this.uiApi.me().getConstant("picto_uri");
            this._uriMonsterSprite = this.uiApi.me().getConstant("monsterSprite_uri");
            this._uriSpecialSlot = (this.uiApi.me().getConstant("bitmap") + "specialSlot.png");
            this._uriEmptySlot = (this.uiApi.me().getConstant("bitmap") + "emptySlot.png");
            this._searchTextByCriteriaList["_searchOnName"] = this.uiApi.getText("ui.common.name");
            this._searchTextByCriteriaList["_searchOnDrop"] = this.uiApi.getText("ui.common.loot");
            this._categoriesArea = Grimoire.getInstance().monsterAreas;
            this._categoriesRace = Grimoire.getInstance().monsterRaces;
            var myCurrentSubarea:SubArea = this.playerApi.currentSubArea();
            var myCurrentAreaId:int = myCurrentSubarea.areaId;
            for each (area in this._categoriesArea)
            {
                if (area.realId == myCurrentAreaId)
                {
                    for each (subcat in area.subcats)
                    {
                        if (subcat.realId == myCurrentSubarea.id)
                        {
                            mySubArea = subcat;
                        };
                    };
                };
            };
            this._lastAreaSelected = mySubArea;
            this._lastRaceSelected = this._categoriesRace[0];
            this.btn_displayCriteriaDrop.selected = Grimoire.getInstance().bestiaryDisplayCriteriaDrop;
            this._searchOnDrop = Grimoire.getInstance().bestiarySearchOnDrop;
            this._searchOnName = Grimoire.getInstance().bestiarySearchOnName;
            openMonsterId = 0;
            if (((oParam) && (oParam.monsterId)))
            {
                openMonsterId = oParam.monsterId;
            };
            if (((oParam) && (oParam.monsterIdsList)))
            {
                if (oParam.monsterSearch)
                {
                    this.inp_search.text = oParam.monsterSearch;
                    this._searchOnDrop = true;
                    this._searchOnName = false;
                };
                for each (mId in oParam.monsterIdsList)
                {
                    this._monstersListToDisplay.push(mId);
                };
            };
            if (openMonsterId > 0)
            {
                this._selectedMonsterId = openMonsterId;
                this._forceOpenMonster = true;
                this.onOpenBestiary("bestiaryTab", {
                    "forceOpen":true,
                    "monsterId":this._selectedMonsterId
                });
            }
            else
            {
                this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.btn_subareas, this.uiApi.me());
                this.btn_subareas.selected = true;
                this.gd_categories.dataProvider = this._categoriesArea;
                this.displayCategories(mySubArea, true);
            };
        }

        public function unload():void
        {
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._lockSearchTimer.stop();
            this._lockSearchTimer = null;
            this.uiApi.unloadUi(this._mapPopup);
        }

        public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            switch (this.getCatLineType(data, line))
            {
                case CTR_CAT_TYPE_CAT:
                case CTR_CAT_TYPE_SUBCAT:
                    componentsRef.lbl_catName.text = data.name;
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
                    if (((data) && ((data.parentId == 0))))
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

        public function updateMonsterSubarea(data:*, compRef:*, selected:Boolean):void
        {
            if (data)
            {
                if (!(this._ctrBtnMonsterLocation[compRef.btn_loc.name]))
                {
                    this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_RELEASE);
                };
                this._ctrBtnMonsterLocation[compRef.btn_loc.name] = data;
                compRef.lbl_subarea.text = ((this.dataApi.getArea(data.areaId).name + " - ") + data.name);
                compRef.btn_loc.visible = true;
            }
            else
            {
                compRef.lbl_subarea.text = "";
                compRef.btn_loc.visible = false;
            };
        }

        public function updateMonsterStatLine(data:*, compRef:*, selected:Boolean):void
        {
            if (data)
            {
                compRef.lbl_text.text = data;
            }
            else
            {
                compRef.lbl_text.text = "";
            };
        }

        public function updateMonsterResistLine(data:*, compRef:*, selected:Boolean):void
        {
            if (data)
            {
                compRef.lbl_text.text = data.text;
                compRef.tx_picto.uri = this.uiApi.createUri((this._uriStatPicto + data.gfxId));
            }
            else
            {
                compRef.lbl_text.text = "";
                compRef.tx_picto.uri = null;
            };
        }

        public function updateMonster(data:*, compRef:*, selected:Boolean, line:uint):void
        {
            var _local_5:Monster;
            var _local_6:MonsterGrade;
            var _local_7:MonsterGrade;
            var _local_8:Array;
            var _local_9:int;
            var _local_10:Array;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:Array;
            var _local_22:Array;
            var _local_23:int;
            var _local_24:Object;
            var _local_25:Object;
            var _local_26:int;
            var subarea:SubArea;
            var areaName:String;
            var subareaName:String;
            var subareaId:int;
            var grade:Object;
            var drop:MonsterDrop;
            var item:ItemWrapper;
            var slot:Object;
            switch (this.getMonsterLineType(data, line))
            {
                case CTR_MONSTER_BASE:
                    this.uiApi.addComponentHook(compRef.tx_boss, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.tx_boss, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(compRef.tx_archMonster, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.tx_archMonster, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(compRef.tx_questMonster, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.tx_questMonster, ComponentHookList.ON_ROLL_OUT);
                    if (!(this._ctrTxLink[compRef.btn_linkToMonster.name]))
                    {
                        this.uiApi.addComponentHook(compRef.btn_linkToMonster, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_linkToMonster, ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.btn_linkToMonster, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrTxLink[compRef.btn_linkToMonster.name] = data;
                    if (!(this._ctrTxLink[compRef.btn_linkToArch.name]))
                    {
                        this.uiApi.addComponentHook(compRef.btn_linkToArch, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_linkToArch, ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.btn_linkToArch, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrTxLink[compRef.btn_linkToArch.name] = data;
                    _local_5 = this.dataApi.getMonsterFromId(data);
                    if (!(_local_5))
                    {
                        this.sysApi.log(16, (("On veut le monstre " + data) + " mais il ne semble pas exister !"));
                        break;
                    };
                    if (!(this._ctrBtnMonster[compRef.btn_monster.name]))
                    {
                        this.uiApi.addComponentHook(compRef.btn_monster, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrBtnMonster[compRef.btn_monster.name] = _local_5;
                    compRef.btn_monster.handCursor = true;
                    compRef.lbl_name.text = _local_5.name;
                    if (this.sysApi.getPlayerManager().hasRights)
                    {
                        compRef.lbl_name.text = (compRef.lbl_name.text + ((" (" + _local_5.id) + ")"));
                    };
                    if (_local_5.isBoss)
                    {
                        compRef.tx_boss.visible = true;
                    }
                    else
                    {
                        compRef.tx_boss.visible = false;
                    };
                    if (_local_5.isMiniBoss)
                    {
                        compRef.tx_archMonster.visible = true;
                    }
                    else
                    {
                        compRef.tx_archMonster.visible = false;
                    };
                    if (_local_5.isQuestMonster)
                    {
                        compRef.tx_questMonster.visible = true;
                    }
                    else
                    {
                        compRef.tx_questMonster.visible = false;
                    };
                    compRef.btn_linkToMonster.visible = false;
                    compRef.btn_linkToArch.visible = false;
                    if (_local_5.isMiniBoss)
                    {
                        compRef.btn_linkToMonster.visible = true;
                    }
                    else
                    {
                        if (_local_5.correspondingMiniBossId > 0)
                        {
                            compRef.btn_linkToArch.visible = true;
                        };
                    };
                    if (_local_5.favoriteSubareaId > 0)
                    {
                        subarea = this.dataApi.getSubArea(_local_5.favoriteSubareaId);
                        areaName = this.dataApi.getArea(subarea.areaId).name;
                        subareaName = subarea.name;
                        if (subareaName.indexOf(areaName) != -1)
                        {
                            compRef.lbl_bestSubarea.text = subareaName;
                        }
                        else
                        {
                            compRef.lbl_bestSubarea.text = (((subareaName + " (") + areaName) + ")");
                        };
                        if (!(this._ctrBtnMonsterLocation[compRef.btn_loc.name]))
                        {
                            this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OVER);
                            this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OUT);
                            this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_RELEASE);
                        };
                        this._ctrBtnMonsterLocation[compRef.btn_loc.name] = _local_5;
                        compRef.btn_loc.visible = true;
                        if (((!(subarea.hasCustomWorldMap)) && (!(subarea.area.superArea.hasWorldMap))))
                        {
                            compRef.btn_loc.softDisabled = true;
                        }
                        else
                        {
                            compRef.btn_loc.softDisabled = false;
                        };
                    }
                    else
                    {
                        compRef.lbl_bestSubarea.text = this.uiApi.getText("ui.monster.noFavoriteZone");
                        compRef.btn_loc.visible = false;
                    };
                    _local_6 = _local_5.grades[0];
                    _local_7 = _local_5.grades[(_local_5.grades.length - 1)];
                    compRef.lbl_level.text = ((this.uiApi.getText("ui.common.short.level") + " ") + this.getStringFromValues(_local_6.level, _local_7.level));
                    compRef.tx_sprite.uri = this.uiApi.createUri(((this._uriMonsterSprite + data) + ".png"));
                    break;
                case CTR_MONSTER_AREAS:
                    _local_8 = new Array();
                    for each (subareaId in data.subareasList)
                    {
                        _local_8.push(this.dataApi.getSubArea(subareaId));
                    };
                    if (_local_8.length <= 2)
                    {
                        compRef.gd_subareas.height = (AREA_LINE_HEIGHT * 2);
                    }
                    else
                    {
                        compRef.gd_subareas.height = (AREA_LINE_HEIGHT * 5);
                    };
                    compRef.gd_subareas.dataProvider = _local_8;
                    break;
                case CTR_MONSTER_DETAILS:
                    this._selectedAndOpenedMonsterId = this._selectedMonsterId;
                    _local_9 = (data.grades.length - 1);
                    _local_10 = new Array();
                    _local_10.push(((this.uiApi.getText("ui.short.lifePoints") + this.uiApi.getText("ui.common.colon")) + this.getStringFromValues(data.grades[0].lifePoints, data.grades[_local_9].lifePoints)));
                    _local_10.push(((this.uiApi.getText("ui.short.actionPoints") + this.uiApi.getText("ui.common.colon")) + this.getStringFromValues(data.grades[0].actionPoints, data.grades[_local_9].actionPoints)));
                    _local_10.push(((this.uiApi.getText("ui.short.movementPoints") + this.uiApi.getText("ui.common.colon")) + this.getStringFromValues(data.grades[0].movementPoints, data.grades[_local_9].movementPoints)));
                    compRef.gd_stats.dataProvider = _local_10;
                    _local_11 = -1;
                    _local_12 = -1;
                    _local_13 = -1;
                    _local_14 = -1;
                    _local_15 = -1;
                    _local_16 = -1;
                    _local_17 = -1;
                    _local_18 = -1;
                    _local_19 = -1;
                    _local_20 = -1;
                    for each (grade in data.grades)
                    {
                        if ((((_local_11 == -1)) || ((grade.neutralResistance < _local_11))))
                        {
                            _local_11 = grade.neutralResistance;
                        };
                        if ((((_local_16 == -1)) || ((grade.neutralResistance > _local_16))))
                        {
                            _local_16 = grade.neutralResistance;
                        };
                        if ((((_local_12 == -1)) || ((grade.earthResistance < _local_12))))
                        {
                            _local_12 = grade.earthResistance;
                        };
                        if ((((_local_17 == -1)) || ((grade.earthResistance > _local_17))))
                        {
                            _local_17 = grade.earthResistance;
                        };
                        if ((((_local_13 == -1)) || ((grade.fireResistance < _local_13))))
                        {
                            _local_13 = grade.fireResistance;
                        };
                        if ((((_local_18 == -1)) || ((grade.fireResistance > _local_18))))
                        {
                            _local_18 = grade.fireResistance;
                        };
                        if ((((_local_14 == -1)) || ((grade.waterResistance < _local_14))))
                        {
                            _local_14 = grade.waterResistance;
                        };
                        if ((((_local_19 == -1)) || ((grade.waterResistance > _local_19))))
                        {
                            _local_19 = grade.waterResistance;
                        };
                        if ((((_local_15 == -1)) || ((grade.airResistance < _local_15))))
                        {
                            _local_15 = grade.airResistance;
                        };
                        if ((((_local_20 == -1)) || ((grade.airResistance > _local_20))))
                        {
                            _local_20 = grade.airResistance;
                        };
                    };
                    _local_21 = new Array();
                    _local_21.push({
                        "text":this.getStringFromValues(_local_11, _local_16),
                        "gfxId":"neutral"
                    });
                    _local_21.push({
                        "text":this.getStringFromValues(_local_12, _local_17),
                        "gfxId":"strength"
                    });
                    _local_21.push({
                        "text":this.getStringFromValues(_local_13, _local_18),
                        "gfxId":"intelligence"
                    });
                    _local_21.push({
                        "text":this.getStringFromValues(_local_14, _local_19),
                        "gfxId":"chance"
                    });
                    _local_21.push({
                        "text":this.getStringFromValues(_local_15, _local_20),
                        "gfxId":"agility"
                    });
                    compRef.gd_resists.dataProvider = _local_21;
                    if (data.hasDrops)
                    {
                        compRef.lbl_drops.text = this.uiApi.getText("ui.common.loot");
                    }
                    else
                    {
                        compRef.lbl_drops.text = "";
                    };
                    break;
                case CTR_MONSTER_DROPS:
                    _local_22 = new Array();
                    _local_23 = 0;
                    for each (drop in data.dropsList)
                    {
                        item = this.dataApi.getItemWrapper(drop.objectId, _local_23, 0, 1);
                        _local_23++;
                        _local_22.push(item);
                    };
                    _local_24 = this.uiApi.createUri(this._uriRareDrop);
                    _local_25 = this.uiApi.createUri(this._uriOkDrop);
                    compRef.gd_drops.dataProvider = _local_22;
                    _local_26 = 0;
                    for each (slot in compRef.gd_drops.slots)
                    {
                        if (((data.dropsList[_local_26]) && (data.dropsList[_local_26].hasCriteria)))
                        {
                            slot.forcedBackGroundIconUri = this.uiApi.createUri(this._uriSpecialSlot);
                        }
                        else
                        {
                            if (data.dropsList[_local_26])
                            {
                                slot.forcedBackGroundIconUri = this.uiApi.createUri(this._uriEmptySlot);
                            }
                            else
                            {
                                slot.forcedBackGroundIconUri = null;
                            };
                        };
                        if (((data.dropsList[_local_26]) && ((data.dropsList[_local_26].percentDropForGrade1 < 2))))
                        {
                            slot.customTexture = _local_24;
                        }
                        else
                        {
                            if (((data.dropsList[_local_26]) && ((data.dropsList[_local_26].percentDropForGrade1 < 10))))
                            {
                                slot.customTexture = _local_25;
                            }
                            else
                            {
                                slot.customTexture = null;
                            };
                        };
                        _local_26++;
                    };
                    if (!(this._ctrSlotDrop[compRef.gd_drops.name]))
                    {
                        this.uiApi.addComponentHook(compRef.gd_drops, ComponentHookList.ON_ITEM_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.gd_drops, ComponentHookList.ON_ITEM_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.gd_drops, ComponentHookList.ON_ITEM_RIGHT_CLICK);
                    };
                    this._ctrSlotDrop[compRef.gd_drops.name] = data;
                    break;
            };
        }

        public function getMonsterLineType(data:*, line:uint):String
        {
            if (!(data))
            {
                return ("");
            };
            switch (line)
            {
                case 0:
                    if (data.hasOwnProperty("dropsList"))
                    {
                        return (CTR_MONSTER_DROPS);
                    };
                    if (data.hasOwnProperty("grades"))
                    {
                        return (CTR_MONSTER_DETAILS);
                    };
                    if (data.hasOwnProperty("subareasList"))
                    {
                        return (CTR_MONSTER_AREAS);
                    };
                    return (CTR_MONSTER_BASE);
                default:
                    return (CTR_MONSTER_BASE);
            };
        }

        public function getMonsterDataLength(data:*, selected:Boolean)
        {
            return (1);
        }

        private function updateMonsterGrid(category:Object):void
        {
            var tempMonstersSorted:Object;
            var id:uint;
            var ts:uint;
            var result:Object;
            var critSplit:Array;
            var nameResult:Object;
            var dropResult:Object;
            var mId:*;
            var currentCriteria:String;
            var wannabeCriteria:String;
            var crit:String;
            var index:int;
            var indexToScroll:int;
            var monsters:Array = new Array();
            this._selectedAndOpenedMonsterId = 0;
            var vectoruint:Vector.<uint> = new Vector.<uint>();
            var alternativeSearchResults:int;
            if (((!(this._monstersListToDisplay)) || ((this._monstersListToDisplay.length == 0))))
            {
                if (!(this._searchCriteria))
                {
                    if (category.parentId > 0)
                    {
                        for each (id in category.monsters)
                        {
                            if (id)
                            {
                                vectoruint.push(id);
                            };
                        };
                        tempMonstersSorted = this.dataApi.querySort(Monster, vectoruint, ["isBoss", "isMiniBoss", "name"], [false, true, true]);
                        for each (id in tempMonstersSorted)
                        {
                            monsters.push(id);
                            monsters.push(null);
                            if (id == this._selectedMonsterId)
                            {
                                indexToScroll = index;
                                monsters = monsters.concat(this.addDetails(id, category));
                            };
                            index++;
                            index++;
                        };
                    };
                }
                else
                {
                    if (this._previousSearchCriteria != ((((((this._searchCriteria + "#") + this.btn_displayCriteriaDrop.selected) + "#") + this._searchOnName) + "") + this._searchOnDrop))
                    {
                        ts = getTimer();
                        critSplit = ((this._previousSearchCriteria) ? this._previousSearchCriteria.split("#") : []);
                        if (((!((this._searchCriteria == critSplit[0]))) || (!((this.btn_displayCriteriaDrop.selected.toString() == critSplit[1])))))
                        {
                            nameResult = this.dataApi.queryString(Monster, "name", this._searchCriteria);
                            if (this.btn_displayCriteriaDrop.selected)
                            {
                                dropResult = this.dataApi.queryEquals(Monster, "drops.objectId", this.dataApi.queryString(Item, "name", this._searchCriteria));
                            }
                            else
                            {
                                dropResult = this.dataApi.queryIntersection(this.dataApi.queryEquals(Monster, "drops.objectId", this.dataApi.queryString(Item, "name", this._searchCriteria)), this.dataApi.queryEquals(Monster, "drops.hasCriteria", false));
                            };
                            this._searchResultByCriteriaList["_searchOnName"] = nameResult;
                            this._searchResultByCriteriaList["_searchOnDrop"] = dropResult;
                            if (((nameResult) || (dropResult)))
                            {
                                this.sysApi.log(2, (((("Result : " + (((nameResult) ? nameResult.length : 0) + ((dropResult) ? dropResult.length : 0))) + " in ") + (getTimer() - ts)) + " ms"));
                            };
                        };
                        if (((this._searchOnName) && (this._searchOnDrop)))
                        {
                            result = this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnDrop"]);
                        }
                        else
                        {
                            if (this._searchOnName)
                            {
                                result = this._searchResultByCriteriaList["_searchOnName"];
                            }
                            else
                            {
                                if (this._searchOnDrop)
                                {
                                    result = this._searchResultByCriteriaList["_searchOnDrop"];
                                }
                                else
                                {
                                    this.gd_monsters.dataProvider = new Array();
                                    this.lbl_noMonster.visible = true;
                                    this.lbl_noMonster.text = this.uiApi.getText("ui.search.needCriterion");
                                    this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this.btn_displayCriteriaDrop.selected) + "#") + this._searchOnName) + "") + this._searchOnDrop);
                                    return;
                                };
                            };
                        };
                        for each (id in result)
                        {
                            vectoruint.push(id);
                        };
                        tempMonstersSorted = this.dataApi.querySort(Monster, vectoruint, ["isBoss", "isMiniBoss", "name"], [false, true, true]);
                        for each (id in tempMonstersSorted)
                        {
                            monsters.push(id);
                            monsters.push(null);
                            if (id == this._selectedMonsterId)
                            {
                                indexToScroll = index;
                                monsters = monsters.concat(this.addDetails(id, category));
                            };
                            index++;
                            index++;
                        };
                    }
                    else
                    {
                        for each (mId in this.gd_monsters.dataProvider)
                        {
                            if (((mId) && ((mId is int))))
                            {
                                monsters.push(mId);
                                monsters.push(null);
                                if (mId == this._selectedMonsterId)
                                {
                                    indexToScroll = index;
                                    monsters = monsters.concat(this.addDetails(int(mId), category));
                                };
                                index++;
                                index++;
                            };
                        };
                    };
                };
            }
            else
            {
                for each (id in this._monstersListToDisplay)
                {
                    vectoruint.push(id);
                };
                tempMonstersSorted = this.dataApi.querySort(Monster, vectoruint, ["isBoss", "isMiniBoss", "name"], [false, true, true]);
                for each (id in tempMonstersSorted)
                {
                    monsters.push(id);
                    monsters.push(null);
                    if (id == this._selectedMonsterId)
                    {
                        indexToScroll = index;
                        monsters = monsters.concat(this.addDetails(id, category));
                    };
                    index++;
                    index++;
                };
            };
            if (monsters.length)
            {
                this.gd_monsters.dataProvider = monsters;
                this.lbl_noMonster.visible = false;
            }
            else
            {
                this.gd_monsters.dataProvider = new Array();
                this.lbl_noMonster.visible = true;
                this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResult");
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
                        this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResultFor", this._searchCriteria);
                    }
                    else
                    {
                        this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResultsBut", currentCriteria, wannabeCriteria);
                    };
                };
            };
            if (this._forceOpenMonster)
            {
                this._forceOpenMonster = false;
                this.gd_monsters.moveTo(indexToScroll, true);
            };
            if (this._currentScrollValue != 0)
            {
                this.gd_monsters.verticalScrollValue = this._currentScrollValue;
            };
            this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this.btn_displayCriteriaDrop.selected) + "#") + this._searchOnName) + "") + this._searchOnDrop);
        }

        private function addDetails(monsterId:int, category:Object):Array
        {
            var drop:MonsterDrop;
            var nbDropsLine:int;
            var dropsList:Array;
            var endIndex:int;
            var i:int;
            var result:Array = new Array();
            var monster:Monster = this.dataApi.getMonsterFromId(monsterId);
            var details:Object = {
                "grades":monster.grades,
                "spells":monster.spells,
                "subareas":monster.subareas,
                "hasDrops":true
            };
            var drops:Array = new Array();
            for each (drop in monster.drops)
            {
                if (((this.btn_displayCriteriaDrop.selected) || (!(drop.hasCriteria))))
                {
                    drops.push(drop);
                };
            };
            if (!(drops.length))
            {
                details.hasDrops = false;
            };
            result.push(details);
            result.push(null);
            result.push(null);
            result.push(null);
            if (drops.length)
            {
                nbDropsLine = Math.ceil((drops.length / NB_DROP_PER_LINE));
                i = 0;
                while (i < nbDropsLine)
                {
                    endIndex = ((i + 1) * NB_DROP_PER_LINE);
                    if (endIndex >= drops.length)
                    {
                        dropsList = drops.slice((i * NB_DROP_PER_LINE));
                    }
                    else
                    {
                        dropsList = drops.slice((i * NB_DROP_PER_LINE), endIndex);
                    };
                    result.push({"dropsList":dropsList});
                    i++;
                };
            };
            return (result);
        }

        private function displayCategories(selectedCategory:Object=null, forceOpen:Boolean=false):void
        {
            var myIndex:int;
            var categories:Array;
            var cat:Object;
            var cat2:Object;
            var subcat:Object;
            if (!(selectedCategory))
            {
                selectedCategory = this.gd_categories.selectedItem;
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
                this.updateMonsterGrid(selectedCategory);
                if (this._openCatIndex != selectedCategory.id)
                {
                    return;
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
            if (this._currentCategoryType == CAT_TYPE_AREA)
            {
                categories = this._categoriesArea;
            }
            else
            {
                categories = this._categoriesRace;
            };
            for each (cat in categories)
            {
                tempCats.push(cat);
                index++;
                if (bigCatId == cat.id)
                {
                    myIndex = index;
                    if (((!((this._currentSelectedCatId == cat.id))) || ((this._openCatIndex == 0))))
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
            this._currentSelectedCatId = selectedCategory.id;
            this.gd_categories.dataProvider = tempCats;
            if (this.gd_categories.selectedIndex != myIndex)
            {
                this.gd_categories.silent = true;
                this.gd_categories.selectedIndex = myIndex;
                this.gd_categories.silent = false;
            };
            this.updateMonsterGrid(this.gd_categories.selectedItem);
        }

        private function changeSearchOnName():void
        {
            this._searchOnName = !(this._searchOnName);
            Grimoire.getInstance().bestiarySearchOnName = this._searchOnName;
            if (((!(this._searchOnName)) && (!(this._searchOnDrop))))
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
                this.updateMonsterGrid(this.gd_categories.selectedItem);
            };
        }

        private function changeSearchOnDrop():void
        {
            this._searchOnDrop = !(this._searchOnDrop);
            Grimoire.getInstance().bestiarySearchOnDrop = this._searchOnDrop;
            if (((!(this._searchOnName)) && (!(this._searchOnDrop))))
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
                this.updateMonsterGrid(this.gd_categories.selectedItem);
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
                    this._monstersListToDisplay = new Array();
                    if (this._currentCategoryType == CAT_TYPE_AREA)
                    {
                        this._lastAreaSelected = target.selectedItem;
                    }
                    else
                    {
                        this._lastRaceSelected = target.selectedItem;
                    };
                    this.displayCategories(target.selectedItem);
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (((item.data) && (!((target.name.indexOf("gd_drops") == -1)))))
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
            var data:Object;
            var maxGrade:int;
            var percentDrop1:Number;
            var percentDropn:Number;
            var myPp:int;
            var myTruePp:int;
            var myPercentDrop1:Number;
            var myPercentDropn:Number;
            if (((item.data) && (!((target.name.indexOf("gd_drops") == -1)))))
            {
                pos = {
                    "point":LocationEnum.POINT_BOTTOM,
                    "relativePoint":LocationEnum.POINT_TOP
                };
                data = this._ctrSlotDrop[target.name].dropsList[item.data.position];
                if ((item.data is ItemWrapper))
                {
                    text = item.data.name;
                    text = (text + this.averagePricesApi.getItemAveragePriceString(item.data, true));
                    maxGrade = this.dataApi.getMonsterFromId(data.monsterId).grades.length;
                    if (maxGrade > 5)
                    {
                        maxGrade = 5;
                    };
                    percentDrop1 = this.getRound(data.percentDropForGrade1);
                    percentDropn = this.getRound(data[("percentDropForGrade" + maxGrade)]);
                    myTruePp = (((this.playerApi.characteristics().prospecting.alignGiftBonus + this.playerApi.characteristics().prospecting.base) + this.playerApi.characteristics().prospecting.contextModif) + this.playerApi.characteristics().prospecting.objectsAndMountBonus);
                    myPp = myTruePp;
                    if (myTruePp < 100)
                    {
                        myPp = 100;
                    };
                    myPercentDrop1 = this.getRound(((percentDrop1 * myPp) / 100));
                    myPercentDropn = this.getRound(((data[("percentDropForGrade" + maxGrade)] * myPp) / 100));
                    if (myPercentDrop1 > 100)
                    {
                        myPercentDrop1 = 100;
                    };
                    if (myPercentDropn > 100)
                    {
                        myPercentDropn = 100;
                    };
                    text = (text + ((((((((("\n" + this.uiApi.getText("ui.monster.obtaining")) + " (") + myTruePp) + " ") + this.uiApi.getText("ui.short.prospection")) + ")") + this.uiApi.getText("ui.common.colon")) + this.getStringFromValues(myPercentDrop1, myPercentDropn)) + "%"));
                    text = (text + ((((((("\n" + this.uiApi.getText("ui.monster.obtaining")) + " (") + this.uiApi.getText("ui.common.base")) + ")") + this.uiApi.getText("ui.common.colon")) + this.getStringFromValues(percentDrop1, percentDropn)) + "%"));
                    if (data.findCeil > 0)
                    {
                        text = (text + ((("\n" + this.uiApi.getText("ui.monster.prospectionThreshold")) + this.uiApi.getText("ui.common.colon")) + data.findCeil));
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
            var monster:Monster;
            var text:String;
            var monsterSubAreas:Vector.<uint>;
            var subArea:SubArea;
            var subAreaId:uint;
            var monsterMiniboss:MonsterMiniBoss;
            var monster2:Monster;
            switch (target)
            {
                case this.btn_resetSearch:
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                    break;
                case this.btn_races:
                    if (this._currentCategoryType != CAT_TYPE_RACE)
                    {
                        this._currentCategoryType = CAT_TYPE_RACE;
                        this.displayCategories(this._lastRaceSelected);
                    };
                    break;
                case this.btn_subareas:
                    if (this._currentCategoryType != CAT_TYPE_AREA)
                    {
                        this._currentCategoryType = CAT_TYPE_AREA;
                        this.displayCategories(this._lastAreaSelected);
                    };
                    break;
                case this.btn_searchFilter:
                    _local_2 = new Array();
                    _local_2.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"], this.changeSearchOnName, null, false, null, this._searchOnName, false));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnDrop"], this.changeSearchOnDrop, null, false, null, this._searchOnDrop, false));
                    this.modContextMenu.createContextMenu(_local_2);
                    break;
                case this.btn_displayCriteriaDrop:
                    Grimoire.getInstance().bestiaryDisplayCriteriaDrop = this.btn_displayCriteriaDrop.selected;
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                    break;
                default:
                    if (target.name.indexOf("btn_monster") != -1)
                    {
                        if (this.uiApi.keyIsDown(Keyboard.SHIFT))
                        {
                            this.sysApi.dispatchHook(MouseShiftClick, {"data":this._ctrBtnMonster[target.name]});
                            break;
                        };
                        data = this._ctrBtnMonster[target.name];
                        if (this._selectedMonsterId != data.id)
                        {
                            this.gd_monsters.selectedItem = data;
                            this._selectedMonsterId = data.id;
                        }
                        else
                        {
                            this._selectedMonsterId = 0;
                        };
                        this.updateMonsterGrid(this.gd_categories.selectedItem);
                        if (this._searchCriteria != "")
                        {
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("btn_loc") != -1)
                        {
                            monster = this._ctrBtnMonsterLocation[target.name];
                            text = this.uiApi.processText(this.uiApi.getText("ui.monster.presentInAreas", monster.subareas.length), "m", (monster.subareas.length == 1));
                            monsterSubAreas = new Vector.<uint>(0);
                            for each (subAreaId in monster.subareas)
                            {
                                subArea = this.dataApi.getSubArea(subAreaId);
                                if (((subArea.hasCustomWorldMap) || (subArea.area.superArea.hasWorldMap)))
                                {
                                    monsterSubAreas.push(subAreaId);
                                };
                            };
                            this._mapPopup = this.modCartography.openCartographyPopup(monster.name, monster.favoriteSubareaId, monsterSubAreas, text);
                        }
                        else
                        {
                            if (target.name.indexOf("btn_linkToMonster") != -1)
                            {
                                monsterMiniboss = this.dataApi.getMonsterMiniBossFromId(this._ctrTxLink[target.name]);
                                this.onOpenBestiary("bestiaryTab", {
                                    "forceOpen":true,
                                    "monsterId":monsterMiniboss.monsterReplacingId
                                });
                            }
                            else
                            {
                                if (target.name.indexOf("btn_linkToArch") != -1)
                                {
                                    monster2 = this.dataApi.getMonsterFromId(this._ctrTxLink[target.name]);
                                    this.onOpenBestiary("bestiaryTab", {
                                        "forceOpen":true,
                                        "monsterId":monster2.correspondingMiniBossId
                                    });
                                };
                            };
                        };
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            if (target.name.indexOf("tx_boss") != -1)
            {
                text = this.uiApi.getText("ui.item.boss");
            }
            else
            {
                if (target.name.indexOf("tx_archMonster") != -1)
                {
                    text = this.uiApi.getText("ui.item.miniboss");
                }
                else
                {
                    if (target.name.indexOf("tx_questMonster") != -1)
                    {
                        text = this.uiApi.getText("ui.monster.questMonster");
                    }
                    else
                    {
                        if (target.name.indexOf("btn_linkToArch") != -1)
                        {
                            text = this.uiApi.getText("ui.monster.goToArchMonster");
                        }
                        else
                        {
                            if (target.name.indexOf("btn_linkToMonster") != -1)
                            {
                                text = this.uiApi.getText("ui.monster.goToMonster");
                            }
                            else
                            {
                                if (target.name.indexOf("btn_searchFilter") != -1)
                                {
                                    text = this.uiApi.getText("ui.search.criteria");
                                }
                                else
                                {
                                    if (target.name.indexOf("btn_loc") != -1)
                                    {
                                        if ((target as ButtonContainer).softDisabled)
                                        {
                                            return;
                                        };
                                        text = this.uiApi.getText("ui.monster.showAreas");
                                    };
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
                this._monstersListToDisplay = new Array();
                this.updateMonsterGrid(this.gd_categories.selectedItem);
            }
            else
            {
                if (this._searchCriteria)
                {
                    this._searchCriteria = null;
                };
                if (this.inp_search.text.length == 0)
                {
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                };
            };
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

        private function onOpenBestiary(tab:String=null, param:Object=null):void
        {
            var monster:Monster;
            var monsterRace:MonsterRace;
            var raceDPObject:Object;
            var superRace:Object;
            var race:Object;
            var mId:int;
            if ((((((tab == "bestiaryTab")) && (param))) && (param.forceOpen)))
            {
                this.uiApi.hideTooltip();
                this._monstersListToDisplay = new Array();
                if (param.monsterId)
                {
                    this._selectedMonsterId = param.monsterId;
                    this._forceOpenMonster = true;
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    monster = this.dataApi.getMonsterFromId(this._selectedMonsterId);
                    this.btn_races.selected = true;
                    this._currentCategoryType = CAT_TYPE_RACE;
                    monsterRace = monster.type;
                    for each (superRace in this._categoriesRace)
                    {
                        if (superRace.realId == monsterRace.superRaceId)
                        {
                            for each (race in superRace.subcats)
                            {
                                if (race.realId == monsterRace.id)
                                {
                                    raceDPObject = race;
                                };
                            };
                        };
                    };
                    this._lastRaceSelected = raceDPObject;
                    this.displayCategories(raceDPObject, true);
                };
                if (param.monsterIdsList)
                {
                    if (param.monsterSearch)
                    {
                        this.inp_search.text = param.monsterSearch;
                        this._searchOnDrop = true;
                        this._searchOnName = false;
                    };
                    for each (mId in param.monsterIdsList)
                    {
                        this._monstersListToDisplay.push(mId);
                    };
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                };
            };
        }

        private function getStringFromValues(valueA:Number, valueB:Number):String
        {
            if (valueA == valueB)
            {
                return (("" + valueA));
            };
            return (((((("" + valueA) + " ") + this.uiApi.getText("ui.chat.to")) + " ") + valueB));
        }

        private function getRound(value:Number):Number
        {
            return ((Math.round((value * 1000)) / 1000));
        }


    }
}//package ui

