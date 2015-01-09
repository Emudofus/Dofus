package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.JobsApi;
    import d2api.SoundApi;
    import d2api.UtilApi;
    import flash.utils.Dictionary;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2hooks.EstateToSellList;
    import d2enums.ShortcutHookListEnum;
    import d2actions.LeaveDialogRequest;
    import d2actions.HouseToSellFilter;
    import d2actions.HouseToSellListRequest;
    import d2actions.PaddockToSellFilter;
    import d2actions.PaddockToSellListRequest;

    public class EstateAgency 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var jobsApi:JobsApi;
        public var soundApi:SoundApi;
        public var utilApi:UtilApi;
        private var _bDescendingSort:Boolean = false;
        private var _currentPage:uint;
        private var _maxPage:uint;
        private var _estates:Array;
        private var _estateType:uint = 2;
        private var _moreBtnList:Dictionary;
        private var _housesAreas:Array;
        private var _paddocksAreas:Array;
        private var _skills:Array;
        private var _houseFilters:Array;
        private var _paddockFilters:Array;
        private var _aAtLeastNbRoom:Array;
        private var _aAtLeastNbChest:Array;
        private var _aSkillRequested:Array;
        private var _aAtLeastNbMount:Array;
        private var _aAtLeastNbMachine:Array;
        private var _aHousesAreaRequested:Array;
        private var _aPaddocksAreaRequested:Array;
        public var listCtr:Object;
        public var filterCtr:Object;
        public var gd_estates:Object;
        public var cb_estateType:Object;
        public var cb_filterRoomMount:Object;
        public var cb_filterChestMachine:Object;
        public var cb_filterSubarea:Object;
        public var cb_filterSkill:Object;
        public var btn_tabName:Object;
        public var btn_tabLoc:Object;
        public var btn_tabCost:Object;
        public var btn_prevPage:Object;
        public var btn_nextPage:Object;
        public var btn_filter:Object;
        public var btn_close:Object;
        public var lbl_page:Object;
        public var inp_filterMaxPrice:Object;

        public function EstateAgency()
        {
            this._moreBtnList = new Dictionary(true);
            this._housesAreas = new Array();
            this._paddocksAreas = new Array();
            this._skills = new Array();
            this._houseFilters = new Array();
            this._paddockFilters = new Array();
            super();
        }

        public function main(args:Object):void
        {
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
            this.sysApi.addHook(EstateToSellList, this.onEstateToSellList);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this._estateType = args.type;
            this.inp_filterMaxPrice.restrict = "0-9";
            var labelsEstate:Array = new Array(this.uiApi.getText("ui.common.housesWord"), this.uiApi.getText("ui.common.mountPark"));
            this.cb_estateType.dataProvider = labelsEstate;
            this.cb_estateType.selectedIndex = this._estateType;
            this.initFilters();
            this.onEstateToSellList(args.list, args.index, args.total, this._estateType);
        }

        public function unload():void
        {
            this.uiApi.unloadUi("estateForm");
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
        }

        public function updateEstateLine(data:*, components:*, selected:Boolean):void
        {
            if (!(this._moreBtnList[components.btn_more.name]))
            {
                this.uiApi.addComponentHook(components.btn_more, "onRelease");
            };
            this._moreBtnList[components.btn_more.name] = data;
            if (data)
            {
                components.lbl_name.text = data.name;
                components.lbl_loc.text = data.area;
                components.lbl_cost.text = this.utilApi.kamasToString(data.price);
                components.btn_more.visible = true;
            }
            else
            {
                components.lbl_name.text = "";
                components.lbl_loc.text = "";
                components.lbl_cost.text = "";
                components.btn_more.visible = false;
            };
        }

        private function initFilters():void
        {
            var skill:*;
            var skillName:*;
            var area:*;
            var areaName:*;
            var areap:*;
            var areaNamep:*;
            this._aAtLeastNbRoom = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbRoom"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "1"), "m", true), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "2"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "3"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "4"), "m", false));
            this._aAtLeastNbChest = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbChest"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "1"), "m", true), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "2"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "3"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "4"), "m", false));
            this._aSkillRequested = new Array(this.uiApi.getText("ui.estate.filter.skillRequested"));
            for each (skill in this.dataApi.getHouseSkills())
            {
                this._skills.push(skill);
            };
            this._skills.sortOn("name");
            for each (skillName in this._skills)
            {
                this._aSkillRequested.push(skillName.name);
            };
            this._aAtLeastNbMount = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbMount"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "5"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "10"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "15"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "20"), "m", false));
            this._aAtLeastNbMachine = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbMachine"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "5"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "10"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "15"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "20"), "m", false));
            this._aHousesAreaRequested = new Array(this.uiApi.getText("ui.estate.filter.areaRequested"));
            for each (area in this.dataApi.getAllArea(true))
            {
                this._housesAreas.push(area);
            };
            this._housesAreas.sortOn("name");
            for each (areaName in this._housesAreas)
            {
                this._aHousesAreaRequested.push(areaName.name);
            };
            this._aPaddocksAreaRequested = new Array(this.uiApi.getText("ui.estate.filter.areaRequested"));
            for each (areap in this.dataApi.getAllArea(false, true))
            {
                this._paddocksAreas.push(areap);
            };
            this._paddocksAreas.sortOn("name");
            for each (areaNamep in this._paddocksAreas)
            {
                this._aPaddocksAreaRequested.push(areaNamep.name);
            };
            this._houseFilters = [0, 0, 0, 0, 0];
            this._paddockFilters = [0, 0, 0, 0, 0];
            this.updateFilters();
        }

        private function updateFilters():void
        {
            if (this._estateType == 0)
            {
                this.cb_filterSubarea.dataProvider = this._aHousesAreaRequested;
                this.cb_filterRoomMount.dataProvider = this._aAtLeastNbRoom;
                this.cb_filterChestMachine.dataProvider = this._aAtLeastNbChest;
                this.cb_filterSkill.dataProvider = this._aSkillRequested;
                this.cb_filterSkill.visible = true;
                this.cb_filterChestMachine.selectedIndex = this._houseFilters[0];
                this.cb_filterRoomMount.selectedIndex = this._houseFilters[1];
                this.cb_filterSkill.selectedIndex = this._houseFilters[2];
                this.cb_filterSubarea.selectedIndex = this._houseFilters[3];
                this.inp_filterMaxPrice.text = (((this._houseFilters[4] == 0)) ? "" : this._houseFilters[4]);
            }
            else
            {
                if (this._estateType == 1)
                {
                    this.cb_filterSubarea.dataProvider = this._aPaddocksAreaRequested;
                    this.cb_filterRoomMount.dataProvider = this._aAtLeastNbMount;
                    this.cb_filterChestMachine.dataProvider = this._aAtLeastNbMachine;
                    this.cb_filterSkill.visible = false;
                    this.cb_filterChestMachine.selectedIndex = this._paddockFilters[0];
                    this.cb_filterRoomMount.selectedIndex = this._paddockFilters[1];
                    this.cb_filterSubarea.selectedIndex = this._paddockFilters[3];
                    this.inp_filterMaxPrice.text = (((this._paddockFilters[4] == 0)) ? "" : this._paddockFilters[4]);
                };
            };
        }

        public function onEstateToSellList(list:Object, pageIndex:uint, totalPage:uint, type:uint=0):void
        {
            var obj:*;
            var estates:Array = new Array();
            for each (obj in list)
            {
                estates.push(obj);
            };
            this.gd_estates.dataProvider = estates;
            this._currentPage = pageIndex;
            this._maxPage = totalPage;
            this.lbl_page.text = ((pageIndex + "/") + this._maxPage);
            if (pageIndex == 1)
            {
                this.btn_prevPage.disabled = true;
            }
            else
            {
                this.btn_prevPage.disabled = false;
            };
            if (pageIndex == this._maxPage)
            {
                this.btn_nextPage.disabled = true;
            }
            else
            {
                this.btn_nextPage.disabled = false;
            };
            if (type != this._estateType)
            {
                this._estateType = type;
                this.updateFilters();
            };
        }

        public function onRelease(target:Object):void
        {
            var _local_2:int;
            var _local_3:Object;
            var skillId:int;
            var skill:*;
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_filter:
                    _local_2 = -1;
                    if (!(this._estateType))
                    {
                        for each (_local_3 in this._housesAreas)
                        {
                            if (_local_3.name == this.cb_filterSubarea.value)
                            {
                                _local_2 = _local_3.id;
                            };
                        };
                        skillId = 0;
                        for each (skill in this._skills)
                        {
                            if (skill.name == this.cb_filterSkill.value)
                            {
                                skillId = skill.id;
                            };
                        };
                        this._houseFilters[0] = this.cb_filterChestMachine.selectedIndex;
                        this._houseFilters[1] = this.cb_filterRoomMount.selectedIndex;
                        this._houseFilters[2] = this.cb_filterSkill.selectedIndex;
                        this._houseFilters[3] = this.cb_filterSubarea.selectedIndex;
                        this._houseFilters[4] = 0;
                        if (this.inp_filterMaxPrice.text != "")
                        {
                            this._houseFilters[4] = this.inp_filterMaxPrice.text;
                        };
                        this.sysApi.sendAction(new HouseToSellFilter(_local_2, this._houseFilters[1], this._houseFilters[0], skillId, this._houseFilters[4]));
                        this.sysApi.sendAction(new HouseToSellListRequest(1));
                    }
                    else
                    {
                        for each (_local_3 in this._paddocksAreas)
                        {
                            if (_local_3.name == this.cb_filterSubarea.value)
                            {
                                _local_2 = _local_3.id;
                            };
                        };
                        this._paddockFilters[0] = this.cb_filterChestMachine.selectedIndex;
                        this._paddockFilters[1] = this.cb_filterRoomMount.selectedIndex;
                        this._paddockFilters[3] = this.cb_filterSubarea.selectedIndex;
                        this._paddockFilters[4] = 0;
                        if (this.inp_filterMaxPrice.text != "")
                        {
                            this._paddockFilters[4] = this.inp_filterMaxPrice.text;
                        };
                        this.sysApi.sendAction(new PaddockToSellFilter(_local_2, (this._paddockFilters[1] * 5), (this._paddockFilters[0] * 5), this._paddockFilters[4]));
                        this.sysApi.sendAction(new PaddockToSellListRequest(1));
                    };
                    break;
                case this.btn_nextPage:
                    if ((this._currentPage + 1) <= this._maxPage)
                    {
                        if (!(this._estateType))
                        {
                            this.sysApi.sendAction(new HouseToSellListRequest(++this._currentPage));
                        }
                        else
                        {
                            this.sysApi.sendAction(new PaddockToSellListRequest(++this._currentPage));
                        };
                    };
                    break;
                case this.btn_prevPage:
                    if ((this._currentPage - 1) >= 0)
                    {
                        if (!(this._estateType))
                        {
                            this.sysApi.sendAction(new HouseToSellListRequest(--this._currentPage));
                        }
                        else
                        {
                            this.sysApi.sendAction(new PaddockToSellListRequest(--this._currentPage));
                        };
                    };
                    break;
                case this.btn_tabName:
                    if (this._bDescendingSort)
                    {
                        this.gd_estates.sortOn("name", Array.CASEINSENSITIVE);
                    }
                    else
                    {
                        this.gd_estates.sortOn("name", (Array.CASEINSENSITIVE | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabLoc:
                    if (this._bDescendingSort)
                    {
                        this.gd_estates.sortOn("area");
                    }
                    else
                    {
                        this.gd_estates.sortOn("area", Array.DESCENDING);
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabCost:
                    if (this._bDescendingSort)
                    {
                        this.gd_estates.sortOn("price", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_estates.sortOn("price", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                default:
                    if (target.name.indexOf("btn_more") != -1)
                    {
                        this.uiApi.unloadUi("estateForm");
                        this.uiApi.loadUi("estateForm", "estateForm", [this._estateType, this._moreBtnList[target.name].infos]);
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
        }

        public function onRollOut(target:Object):void
        {
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != 7)
            {
                switch (target)
                {
                    case this.cb_estateType:
                        if (!(this.cb_estateType.selectedIndex))
                        {
                            this.sysApi.sendAction(new HouseToSellListRequest(1));
                        }
                        else
                        {
                            this.sysApi.sendAction(new PaddockToSellListRequest(1));
                        };
                        break;
                    case this.cb_filterRoomMount:
                        break;
                    case this.cb_filterChestMachine:
                        break;
                    case this.cb_filterSubarea:
                        break;
                    case this.cb_filterSkill:
                        break;
                };
            };
        }


    }
}//package ui

