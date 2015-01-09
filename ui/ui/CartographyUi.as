package ui
{
    import d2components.Texture;
    import d2components.ButtonContainer;
    import d2components.Input;
    import d2components.Label;
    import d2components.GraphicContainer;
    import d2components.Tree;
    import flash.utils.Dictionary;
    import d2enums.ComponentHookList;
    import d2hooks.KeyUp;
    import d2hooks.MapDisplay;
    import d2data.PrismSubAreaWrapper;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2actions.PrismsListRegister;
    import d2enums.PrismListenEnum;
    import d2hooks.MapHintsFilter;
    import flash.utils.describeType;
    import d2actions.OpenMap;
    import d2data.SuperArea;
    import d2data.AllianceWrapper;
    import d2enums.PrismStateEnum;
    import d2enums.LocationEnum;
    import d2data.SubArea;
    import d2hooks.*;
    import d2actions.*;

    public class CartographyUi extends CartographyBase 
    {

        private static const INTEGRATION_MODE:Boolean = false;
        private static var _conquestInformationsIsActive:Boolean = false;

        public var tx_bgViewer:Texture;
        public var btnValidSearch:ButtonContainer;
        public var btn_pocketMap:ButtonContainer;
        public var btnFilterFlags:ButtonContainer;
        public var btnFilterPrivate:ButtonContainer;
        public var btnFilterTemple:ButtonContainer;
        public var btnFilterBidHouse:ButtonContainer;
        public var btnFilterCraftHouse:ButtonContainer;
        public var btnFilterMisc:ButtonContainer;
        public var btnFilterTransport:ButtonContainer;
        public var btnFilterConquest:ButtonContainer;
        public var btnFilterDungeon:ButtonContainer;
        public var btnSwitch:ButtonContainer;
        public var tiSearch:Input;
        public var btn_lbl_btnSwitch:Label;
        public var lbl_title:Label;
        public var ctr_right:GraphicContainer;
        public var ctr_locTree:GraphicContainer;
        public var gdZone:Tree;
        private var _dataProvider;
        private var _searchCriteria:String;
        private var _conquestMode:Boolean = false;
        private var _gdConquestProvider:Array;
        private var _lastAreaShapeDisplayed:Array;
        private var _lastLayer:String;
        private var _filterCat:Dictionary;
        private var _mapViewerBorder:int;
        private var _updateConquestAreas:Boolean;
        private var _itemsToExpand:Array;
        private var _selectedItem:Object;

        public function CartographyUi()
        {
            this._gdConquestProvider = new Array();
            this._lastAreaShapeDisplayed = new Array();
            this._filterCat = new Dictionary(true);
            super();
        }

        override public function main(params:Object=null):void
        {
            configApi.setConfigProperty("dofus", "lastMapUiWasPocket", false);
            _conquestInformationsIsActive = ((_conquestInformationsIsActive) || (this._conquestMode));
            uiApi.addComponentHook(this.btnFilterFlags, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterFlags, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterFlags, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterPrivate, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterPrivate, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterPrivate, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterTemple, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterTemple, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterTemple, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterBidHouse, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterBidHouse, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterBidHouse, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterCraftHouse, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterCraftHouse, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterCraftHouse, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterMisc, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterMisc, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterMisc, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterTransport, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterTransport, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterTransport, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterConquest, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterConquest, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterConquest, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btnFilterDungeon, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnFilterDungeon, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btnFilterDungeon, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btn_pocketMap, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_pocketMap, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.tiSearch, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnSwitch, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.gdZone, ComponentHookList.ON_SELECT_ITEM);
            uiApi.addComponentHook(this.gdZone, ComponentHookList.ON_ITEM_ROLL_OVER);
            sysApi.addHook(KeyUp, this.onKeyUp);
            this._mapViewerBorder = uiApi.me().getConstant("map_viewer_border");
            if (mapApi.getCurrentWorldMap())
            {
                this.lbl_title.text = ((uiApi.getText("ui.option.worldOption") + uiApi.getText("ui.common.colon")) + mapApi.getCurrentWorldMap().name);
            }
            else
            {
                this.lbl_title.text = uiApi.getText("ui.cartography.title");
            };
            this._conquestMode = params.conquest;
            this.switchToConquest();
            super.main(params);
            sysApi.dispatchHook(MapDisplay, true);
        }

        override protected function initMap():void
        {
            var prismSubAreaInfo:PrismSubAreaWrapper;
            super.initMap();
            this.btnValidSearch.soundId = SoundEnum.CHECKBOX_CHECKED;
            this.btnSwitch.soundId = SoundEnum.TAB;
            soundApi.playSound(SoundTypeEnum.MAP_OPEN);
            sysApi.showWorld(false);
            this.btnFilterTemple.selected = __hintCategoryFiltersList[1];
            this.btnFilterBidHouse.selected = __hintCategoryFiltersList[2];
            this.btnFilterCraftHouse.selected = __hintCategoryFiltersList[3];
            this.btnFilterMisc.selected = __hintCategoryFiltersList[4];
            this.btnFilterConquest.selected = __hintCategoryFiltersList[5];
            this.btnFilterDungeon.selected = __hintCategoryFiltersList[6];
            this.btnFilterPrivate.selected = __hintCategoryFiltersList[7];
            this.btnFilterFlags.selected = __hintCategoryFiltersList[8];
            this.btnFilterTransport.selected = __hintCategoryFiltersList[9];
            this._filterCat[this.btnFilterTemple] = "layer_1";
            this._filterCat[this.btnFilterBidHouse] = "layer_2";
            this._filterCat[this.btnFilterCraftHouse] = "layer_3";
            this._filterCat[this.btnFilterMisc] = "layer_4";
            this._filterCat[this.btnFilterConquest] = "layer_5";
            this._filterCat[this.btnFilterDungeon] = "layer_6";
            this._filterCat[this.btnFilterPrivate] = "layer_7";
            this._filterCat[this.btnFilterFlags] = "layer_8";
            this._filterCat[this.btnFilterTransport] = "layer_9";
            if (!(__conquestSubAreasInfos))
            {
                if (modCartography.showConquestInformation())
                {
                    this.btnSwitch.disabled = false;
                    sysApi.sendAction(new PrismsListRegister("Cartography", PrismListenEnum.PRISM_LISTEN_ALL));
                    _conquestInformationsIsActive = true;
                }
                else
                {
                    this.btnSwitch.disabled = true;
                };
            }
            else
            {
                if (modCartography.showConquestInformation())
                {
                    this.addAreaShapesFromData(__capturableAreas);
                    this.addAreaShapesFromData(__normalAreas);
                    this.addAreaShapesFromData(__weakenedAreas);
                    this.addAreaShapesFromData(__vulnerableAreas);
                    this.updateConquestSubarea(false);
                    for each (prismSubAreaInfo in __conquestSubAreasInfos)
                    {
                        updatePrismIcon(prismSubAreaInfo);
                    };
                    mapViewer.showLayer("layer_1", false);
                    mapViewer.showLayer("layer_2", false);
                    mapViewer.showLayer("layer_3", false);
                    mapViewer.showLayer("layer_4", false);
                    mapViewer.showLayer("layer_5", true);
                    mapViewer.showLayer("layer_6", false);
                    mapViewer.showLayer("layer_7", false);
                    mapViewer.showLayer("layer_9", false);
                    this.btnFilterTemple.selected = false;
                    this.btnFilterBidHouse.selected = false;
                    this.btnFilterCraftHouse.selected = false;
                    this.btnFilterMisc.selected = false;
                    this.btnFilterTransport.selected = false;
                    this.btnFilterConquest.selected = true;
                    this.btnFilterDungeon.selected = false;
                    this.btnFilterPrivate.selected = false;
                };
            };
        }

        override public function unload():void
        {
            super.unload();
            soundApi.playSound(SoundTypeEnum.MAP_CLOSE);
            _conquestInformationsIsActive = false;
            sysApi.showWorld(true);
            sysApi.dispatchHook(MapDisplay, false);
        }

        protected function updateMapFilter(pTarget:Object):void
        {
            var filterId:int = int(this._filterCat[pTarget].split("_")[1]);
            __hintCategoryFiltersList[filterId] = pTarget.selected;
            if (__layersToShow[this._filterCat[pTarget]])
            {
                mapViewer.showLayer(this._filterCat[pTarget], pTarget.selected);
                mapViewer.updateMapElements();
            };
            sysApi.dispatchHook(MapHintsFilter, filterId, pTarget.selected, true);
        }

        override protected function addCustomFlagWithRightClick(pX:Number, pY:Number):void
        {
            if (!(this.btnFilterFlags.selected))
            {
                this.btnFilterFlags.selected = true;
                this.updateMapFilter(this.btnFilterFlags);
            };
            super.addCustomFlagWithRightClick(pX, pY);
        }

        override protected function addConquestItem(pList:Object, pItem:Object):void
        {
            var item:Object;
            var list:Object;
            var itemToRemove:int;
            super.addConquestItem(pList, pItem);
            if (((pList) && (this._conquestMode)))
            {
                if (pList.layer != "AllAreas")
                {
                    for each (list in this._gdConquestProvider)
                    {
                        if (((!((list.layer == "AllAreas"))) && (!((list.layer == pList.layer)))))
                        {
                            itemToRemove = -1;
                            for each (item in list.children)
                            {
                                if (item.data.id == pItem.data.id)
                                {
                                    itemToRemove = list.children.indexOf(item);
                                    break;
                                };
                            };
                            if (itemToRemove != -1)
                            {
                                list.children.splice(itemToRemove, 1);
                                break;
                            };
                        };
                    };
                };
            };
        }

        override protected function onPrismsListInformation(pPrismsInfo:Object):void
        {
            super.onPrismsListInformation(pPrismsInfo);
            this._gdConquestProvider = new Array();
            this._gdConquestProvider.push(__capturableAreas);
            this._gdConquestProvider.push(__normalAreas);
            this._gdConquestProvider.push(__weakenedAreas);
            this._gdConquestProvider.push(__vulnerableAreas);
            this._updateConquestAreas = true;
            if (this._conquestMode)
            {
                this.switchConquestMode();
            };
        }

        override protected function onPrismsInfoUpdate(pPrismSubAreaIds:Object):void
        {
            var list:Object;
            var itemType:int;
            var itemValue:Object;
            var itemParentLayer:String;
            super.onPrismsInfoUpdate(pPrismSubAreaIds);
            if (this._conquestMode)
            {
                this._itemsToExpand = new Array();
                for each (list in this._gdConquestProvider)
                {
                    list.children.sort(this.compareSubAreaItem);
                };
                itemType = 0;
                if (this.gdZone.selectedItem)
                {
                    if (this.gdZone.selectedItem.value.hasOwnProperty("layer"))
                    {
                        itemType = 1;
                        itemValue = this.gdZone.selectedItem.value.layer;
                    }
                    else
                    {
                        if (this.gdZone.selectedItem.value.hasOwnProperty("data"))
                        {
                            itemType = 2;
                            itemValue = this.gdZone.selectedItem.value.data.id;
                            itemParentLayer = this.gdZone.selectedItem.parent.value.layer;
                        };
                    };
                };
                this.getConquestItemsToExpand(this.gdZone.treeRoot, this._itemsToExpand);
                if (!(this._searchCriteria))
                {
                    this.gdZone.dataProvider = this._gdConquestProvider;
                }
                else
                {
                    this.gdZone.dataProvider = this.filterSubArea(this._searchCriteria, this._gdConquestProvider);
                };
                this.checkConquestItems(this.gdZone.treeRoot, itemType, itemValue, itemParentLayer);
                this.gdZone.expandItems(this._itemsToExpand);
                if (this._selectedItem)
                {
                    this.gdZone.selectedItem = this._selectedItem;
                };
                this._itemsToExpand.length = 0;
                this._selectedItem = null;
                this._dataProvider = this._gdConquestProvider;
                if (this._lastLayer)
                {
                    this.updateLayerAreaShapes(this._lastLayer);
                };
            };
        }

        override public function onRelease(target:Object):void
        {
            var data:Array;
            var worldmap:Object;
            var worldmapCopy:Object;
            var objDesc:XML;
            var key:String;
            var pt:*;
            super.onRelease(target);
            switch (target)
            {
                case btn_close:
                    uiApi.unloadUi(uiApi.me().name);
                    break;
                case this.tiSearch:
                    if (uiApi.getText("ui.common.search.input") == this.tiSearch.text)
                    {
                        this.tiSearch.text = "";
                    };
                    break;
                case btn_flag:
                    if (INTEGRATION_MODE)
                    {
                        data = this.tiSearch.text.split(",");
                        worldmap = dataApi.getWorldMap(parseInt(data[0]));
                        worldmapCopy = {};
                        objDesc = describeType(worldmap);
                        for each (key in objDesc..accessor.@name)
                        {
                            worldmapCopy[key] = worldmap[key];
                        };
                        worldmapCopy.origineX = parseInt(data[1]);
                        worldmapCopy.origineY = parseInt(data[2]);
                        worldmapCopy.mapWidth = parseFloat(data[3]);
                        worldmapCopy.mapHeight = parseFloat(data[4]);
                        openNewMap(worldmapCopy, MAP_TYPE_SUPERAREA, _currentSuperarea, true);
                    };
                    break;
                case btn_player:
                    if (INTEGRATION_MODE)
                    {
                        pt = mapViewer.getOrigineFromPos(__playerPos.outdoorX, __playerPos.outdoorY);
                        this.tiSearch.text = ((((((((__worldMapInfo.id + ",") + pt.x) + ",") + pt.y) + ",") + __worldMapInfo.mapWidth) + ",") + __worldMapInfo.mapHeight);
                    }
                    else
                    {
                        if (!(this.btnFilterFlags.selected))
                        {
                            this.btnFilterFlags.selected = true;
                            this.updateMapFilter(this.btnFilterFlags);
                        };
                    };
                    break;
                case this.btnFilterTemple:
                case this.btnFilterBidHouse:
                case this.btnFilterCraftHouse:
                case this.btnFilterMisc:
                case this.btnFilterConquest:
                case this.btnFilterDungeon:
                case this.btnFilterPrivate:
                case this.btnFilterFlags:
                case this.btnFilterTransport:
                    this.updateMapFilter(target);
                    break;
                case this.btnSwitch:
                    this._conquestMode = !(this._conquestMode);
                    this.switchToConquest();
                    uiApi.hideTooltip();
                    break;
                case this.btn_pocketMap:
                    sysApi.sendAction(new OpenMap(true, true));
                    uiApi.unloadUi(uiApi.me().name);
                    break;
            };
            if (((((!((target == this.tiSearch))) && (this.tiSearch))) && ((this.tiSearch.text.length == 0))))
            {
                this.tiSearch.text = uiApi.getText("ui.common.search.input");
            };
        }

        override public function onEnterFrame():void
        {
            super.onEnterFrame();
            if (ctrSubAreaInfo.visible)
            {
                if ((uiApi.getMouseX() + ctrSubAreaInfoBg.width) > (((this.ctr_right.x + this.ctr_right.width) - mapViewer.x) - mapViewer.roundCornerRadius))
                {
                    ctrSubAreaInfo.x = (ctrSubAreaInfo.x - ((ctrSubAreaInfoBg.width + mapViewer.x) + mapViewer.roundCornerRadius));
                };
                if ((uiApi.getMouseY() + ctrSubAreaInfoBg.height) > (this.ctr_right.y + this.ctr_right.height))
                {
                    ctrSubAreaInfo.y = (ctrSubAreaInfo.y - ctrSubAreaInfoBg.height);
                };
            };
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (this.tiSearch.haveFocus)
            {
                this._searchCriteria = this.tiSearch.text.toLowerCase();
                if (!(this._searchCriteria.length))
                {
                    this._searchCriteria = null;
                };
                this.searchFilter();
            };
        }

        public function onSelectItem(target:Object, method:uint, isNew:Boolean):void
        {
            var sa:SuperArea;
            var subAreaCenter:Object;
            var item:Object = target.selectedItem.value;
            if (method == 1)
            {
                switch (item.type)
                {
                    case "superarea":
                        saveCurrentMapPreset();
                        openNewMap(item.data.worldmap, MAP_TYPE_SUPERAREA, item.data);
                        break;
                    case "subarea":
                        saveCurrentMapPreset();
                        if (!(item.data.hasCustomWorldMap))
                        {
                            sa = dataApi.getArea(item.data.areaId).superArea;
                            if (_currentWorldId != sa.worldmapId)
                            {
                                openNewMap(sa.worldmap, MAP_TYPE_SUPERAREA, sa);
                                __areaShapeDisplayed = new Array();
                                this.showConquestAreaShapes(item.parent.layer);
                                __lastAreaShap = ("shape" + item.data.id);
                                if (__areaShapeDisplayed.indexOf(item.parent.layer) == -1)
                                {
                                    mapViewer.areaShapeColorTransform(mapViewer.getMapElement(__lastAreaShap), 100, 1, 1, 1, 1);
                                }
                                else
                                {
                                    mapViewer.areaShapeColorTransform(mapViewer.getMapElement(__lastAreaShap), 100, 1.2, 1.2, 1.2, 2);
                                };
                            };
                        };
                        if (!(openNewMap(item.data.worldmap, MAP_TYPE_SUBAREA, item.data)))
                        {
                            subAreaCenter = mapApi.getSubAreaCenter(item.data.id);
                            if (subAreaCenter)
                            {
                                mapViewer.moveTo(subAreaCenter.x, subAreaCenter.y);
                            };
                        };
                        break;
                    case "area":
                        break;
                };
            }
            else
            {
                if (item.type == "areaShape")
                {
                    if (_currentWorldId != __startWorldMapInfo.id)
                    {
                        openPlayerCurrentMap();
                        this._lastLayer = null;
                        __areaShapeDisplayed = new Array();
                    };
                    if (this._lastLayer != item.layer)
                    {
                        this.updateLayerAreaShapes(item.layer);
                    };
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var currentAreaShape:String;
            var mapAreaShape:Object;
            var subAreaId:int;
            var prismInfo:PrismSubAreaWrapper;
            var alliance:AllianceWrapper;
            var tooltipText:String;
            uiApi.hideTooltip();
            if (((((item.data) && (item.data.value))) && ((item.data.value.type == "subarea"))))
            {
                subAreaId = item.data.value.data.id;
                currentAreaShape = ("shape" + subAreaId);
                if (currentAreaShape != __lastAreaShap)
                {
                    mapAreaShape = mapViewer.getMapElement(__lastAreaShap);
                    if (mapAreaShape)
                    {
                        if (__areaShapeDisplayed.indexOf(mapAreaShape.layer) == -1)
                        {
                            mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 0);
                        }
                        else
                        {
                            mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 1);
                        };
                    };
                    __lastAreaShap = currentAreaShape;
                    mapAreaShape = mapViewer.getMapElement(__lastAreaShap);
                    if (mapAreaShape)
                    {
                        if (__areaShapeDisplayed.indexOf(mapAreaShape.layer) == -1)
                        {
                            mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 1);
                        }
                        else
                        {
                            mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1.2, 1.2, 1.2, 1.5);
                        };
                    };
                };
                prismInfo = socialApi.getPrismSubAreaById(subAreaId);
                if (((prismInfo) && (((!((prismInfo.mapId == -1))) || (prismInfo.alliance)))))
                {
                    alliance = ((!(prismInfo.alliance)) ? socialApi.getAlliance() : prismInfo.alliance);
                    tooltipText = (("[" + alliance.allianceTag) + "]");
                    if ((((prismInfo.state == PrismStateEnum.PRISM_STATE_WEAKENED)) || ((prismInfo.state == PrismStateEnum.PRISM_STATE_SABOTAGED))))
                    {
                        tooltipText = (tooltipText + (((((" " + uiApi.getText("ui.prism.startVulnerability")) + uiApi.getText("ui.common.colon")) + timeApi.getDate((prismInfo.nextVulnerabilityDate * 1000))) + " ") + prismInfo.vulnerabilityHourString));
                    };
                    uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), item.container, false, "standard", LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "ConquestPrismInfo");
                };
            };
        }

        override public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            super.onRollOver(target);
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btnValidSearch:
                    tooltipText = uiApi.getText("ui.common.search");
                    break;
                case btn_player:
                    if (INTEGRATION_MODE)
                    {
                        tooltipText = "[INTEGRATION MODE] Calcul worldId,origineX,origineY,mapWidth,mapHeight";
                    };
                    break;
                case btn_flag:
                    if (INTEGRATION_MODE)
                    {
                        tooltipText = "[INTEGRATION MODE] Parse les données du champs de recherche : worldmapId,origineX,origineY,mapWidth,mapHeight et recharge la map avec ces info";
                    };
                    break;
                case this.btn_pocketMap:
                    tooltipText = uiApi.getText("ui.cartography.openpocketmap");
                    break;
                case this.btnFilterTemple:
                    tooltipText = uiApi.getText("ui.map.temple");
                    break;
                case this.btnFilterBidHouse:
                    tooltipText = uiApi.getText("ui.map.bidHouse");
                    break;
                case this.btnFilterCraftHouse:
                    tooltipText = uiApi.getText("ui.map.craftHouse");
                    break;
                case this.btnFilterMisc:
                    tooltipText = uiApi.getText("ui.common.misc");
                    break;
                case this.btnFilterConquest:
                    tooltipText = uiApi.getText("ui.map.conquest");
                    break;
                case this.btnFilterDungeon:
                    tooltipText = uiApi.getText("ui.map.dungeon");
                    break;
                case this.btnFilterPrivate:
                    tooltipText = uiApi.getText("ui.common.possessions");
                    break;
                case this.btnFilterFlags:
                    tooltipText = uiApi.getText("ui.cartography.flags");
                    break;
                case this.btnFilterTransport:
                    tooltipText = uiApi.getText("ui.cartography.transport");
                    break;
            };
            if (tooltipText)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        override protected function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean):void
        {
            var btn:Object;
            super.onMapHintsFilter(layerId, displayed, fromCartography);
            if (!(fromCartography))
            {
                for (btn in this._filterCat)
                {
                    if (this._filterCat[btn] == ("layer_" + layerId))
                    {
                        btn.selected = displayed;
                    };
                };
            };
        }

        override protected function toggleHints():void
        {
            var btn:Object;
            super.toggleHints();
            var allLayersVisible:Boolean = mapViewer.allLayersVisible;
            for (btn in this._filterCat)
            {
                btn.selected = allLayersVisible;
            };
        }

        private function switchToConquest():void
        {
            var mapX:int;
            var mapRect:Object = mapViewer.visibleMaps;
            if (!(this._conquestMode))
            {
                this.btn_lbl_btnSwitch.text = uiApi.getText("ui.map.showConquest");
                this.ctr_locTree.visible = false;
                this.ctr_right.width = uiApi.me().getConstant("map_ctr_full_width");
                this.ctr_right.x = uiApi.me().getConstant("map_ctr_full_x");
            }
            else
            {
                this.btn_lbl_btnSwitch.text = uiApi.getText("ui.map.hideConquest");
                this.ctr_locTree.visible = true;
                this.ctr_right.width = uiApi.me().getConstant("map_ctr_width");
                this.ctr_right.x = uiApi.me().getConstant("map_ctr_x");
            };
            mapViewer.width = (this.ctr_right.width - (this._mapViewerBorder * 2));
            mapViewer.x = this._mapViewerBorder;
            var mapRect2:Object = mapViewer.visibleMaps;
            mapViewer.moveTo(((mapRect.x + mapRect.width) - mapRect2.width), mapRect.y, 1, 1, false, false);
            var mapRect3:Object = mapViewer.visibleMaps;
            this.tx_bgViewer.width = (mapViewer.width + 6);
            this.tx_bgViewer.x = (mapViewer.x - 3);
            this.switchConquestMode();
        }

        private function switchConquestMode():void
        {
            var layerId:Object;
            if (this._conquestMode)
            {
                if (this._updateConquestAreas)
                {
                    this.updateConquestSubarea();
                };
                __lastAreaShap = "";
                this.gdZone.dataProvider = this._gdConquestProvider;
                this._dataProvider = this._gdConquestProvider;
                this._lastLayer = "AllAreas";
                this.showAreaShape(NORMAL_AREAS, true);
                this.showAreaShape(WEAKENED_AREAS, true);
                this.showAreaShape(VULNERABLE_AREAS, true);
                this.showAreaShape(VILLAGES_AREAS, true);
                this.showAreaShape(CAPTURABLE_AREAS, true);
                mapViewer.showLayer("layer_1", false);
                mapViewer.showLayer("layer_2", false);
                mapViewer.showLayer("layer_3", false);
                mapViewer.showLayer("layer_4", false);
                mapViewer.showLayer("layer_5", true);
                mapViewer.showLayer("layer_6", false);
                mapViewer.showLayer("layer_7", false);
                mapViewer.showLayer("layer_9", false);
                this.btnFilterTemple.selected = false;
                this.btnFilterBidHouse.selected = false;
                this.btnFilterCraftHouse.selected = false;
                this.btnFilterMisc.selected = false;
                this.btnFilterTransport.selected = false;
                this.btnFilterConquest.selected = true;
                this.btnFilterDungeon.selected = false;
                this.btnFilterPrivate.selected = false;
            }
            else
            {
                if (((__worldMapInfo) && (!((__worldMapInfo.id == __startWorldMapInfo.id)))))
                {
                    openPlayerCurrentMap();
                };
                __lastAreaShap = "";
                this._lastLayer = "";
                this.showAreaShape(NORMAL_AREAS, false);
                this.showAreaShape(WEAKENED_AREAS, false);
                this.showAreaShape(VULNERABLE_AREAS, false);
                this.showAreaShape(VILLAGES_AREAS, false);
                this.showAreaShape(CAPTURABLE_AREAS, false);
                __areaShapeDisplayed = new Array();
                for (layerId in __hintCategoryFiltersList)
                {
                    mapViewer.showLayer(("layer_" + layerId), __hintCategoryFiltersList[layerId]);
                };
                this.btnFilterTemple.selected = __hintCategoryFiltersList[1];
                this.btnFilterBidHouse.selected = __hintCategoryFiltersList[2];
                this.btnFilterCraftHouse.selected = __hintCategoryFiltersList[3];
                this.btnFilterMisc.selected = __hintCategoryFiltersList[4];
                this.btnFilterConquest.selected = __hintCategoryFiltersList[5];
                this.btnFilterDungeon.selected = __hintCategoryFiltersList[6];
                this.btnFilterPrivate.selected = __hintCategoryFiltersList[7];
                this.btnFilterTransport.selected = __hintCategoryFiltersList[9];
            };
            mapViewer.updateMapElements();
        }

        private function getConquestItemsToExpand(pNode:Object, pItemsToExpand:Array):void
        {
            var node:Object;
            if (((((pNode.parent) && (pNode.hasOwnProperty("expend")))) && ((pNode.expend == true))))
            {
                pItemsToExpand.push(pNode);
            };
            if (pNode.hasOwnProperty("children"))
            {
                for each (node in pNode.children)
                {
                    this.getConquestItemsToExpand(node, pItemsToExpand);
                };
            };
        }

        private function checkConquestItems(pNode:Object, pItemType:int, pItemValue:Object, pItemParentLayer:String):void
        {
            var td:Object;
            var node:Object;
            if (((((((((!(this._selectedItem)) && (!((pItemType == 0))))) && (pItemValue))) && (pNode.parent))) && (pNode.value)))
            {
                if ((((((pItemType == 1)) && (pNode.value.hasOwnProperty("layer")))) && ((pNode.value.layer == pItemValue))))
                {
                    this._selectedItem = pNode;
                }
                else
                {
                    if (((((((pNode.parent.value) && ((((((pItemParentLayer == "AllAreas")) && ((pNode.parent.value.layer == "AllAreas")))) || (((!((pItemParentLayer == "AllAreas"))) && (!((pNode.parent.value.layer == "AllAreas"))))))))) && (pNode.value.hasOwnProperty("data")))) && ((pNode.value.data.id == pItemValue))))
                    {
                        this._selectedItem = pNode;
                    };
                };
            };
            if (pNode.hasOwnProperty("children"))
            {
                if (this._itemsToExpand.length)
                {
                    for each (td in this._itemsToExpand)
                    {
                        if (td.label == pNode.label)
                        {
                            this._itemsToExpand.splice(this._itemsToExpand.indexOf(td), 1, pNode);
                            break;
                        };
                    };
                };
                for each (node in pNode.children)
                {
                    this.checkConquestItems(node, pItemType, pItemValue, pItemParentLayer);
                };
            };
        }

        private function showAreaShape(layer:String, display:Boolean):void
        {
            var elements:Object;
            var nb:int;
            var i:int;
            var element:Object;
            if (display)
            {
                elements = mapViewer.getMapElementsByLayer(layer);
                if ((((((__areaShapeDisplayed.indexOf(layer) == -1)) && (elements))) && (!((elements.length == 0)))))
                {
                    __areaShapeDisplayed.push(layer);
                    nb = elements.length;
                    i = 0;
                    while (i < nb)
                    {
                        mapViewer.areaShapeColorTransform(elements[i], 100, 1, 1, 1, 1);
                        i++;
                    };
                };
            }
            else
            {
                elements = mapViewer.getMapElementsByLayer(layer);
                nb = elements.length;
                i = 0;
                while (i < nb)
                {
                    mapViewer.areaShapeColorTransform(elements[i], 100, 1, 1, 1, 0);
                    i++;
                };
            };
        }

        private function showConquestAreaShapes(pLayer:String):void
        {
            if (pLayer == "AllAreas")
            {
                this.showAreaShape(NORMAL_AREAS, true);
                this.showAreaShape(WEAKENED_AREAS, true);
                this.showAreaShape(VULNERABLE_AREAS, true);
                this.showAreaShape(VILLAGES_AREAS, true);
                this.showAreaShape(CAPTURABLE_AREAS, true);
            }
            else
            {
                this.showAreaShape(pLayer, true);
            };
        }

        private function updateLayerAreaShapes(pLayer:String):void
        {
            this._lastLayer = pLayer;
            this._lastAreaShapeDisplayed = new Array();
            var nb:int = __areaShapeDisplayed.length;
            var i:int;
            while (i < nb)
            {
                this._lastAreaShapeDisplayed.push(__areaShapeDisplayed[i]);
                i++;
            };
            __areaShapeDisplayed = new Array();
            this.showConquestAreaShapes(pLayer);
            var k:int;
            while (k < nb)
            {
                if (__areaShapeDisplayed.indexOf(this._lastAreaShapeDisplayed[k]) == -1)
                {
                    this.showAreaShape(this._lastAreaShapeDisplayed[k], false);
                };
                k++;
            };
        }

        private function addAreaShapesFromData(pData:Object, pLineColor:uint=0, pLineAlpha:Number=1, pFillColor:uint=0, pFillAlpha:Number=0.4, pThickness:int=4):void
        {
            var alliance:AllianceWrapper;
            var c:Object;
            var sa:SubArea;
            var prismSubAreaInfo:PrismSubAreaWrapper;
            for each (c in pData.children)
            {
                sa = c.data;
                prismSubAreaInfo = socialApi.getPrismSubAreaById(sa.id);
                if (((prismSubAreaInfo) && (!((prismSubAreaInfo.mapId == -1)))))
                {
                    alliance = ((!(prismSubAreaInfo.alliance)) ? socialApi.getAlliance() : prismSubAreaInfo.alliance);
                    mapViewer.addAreaShape(pData.layer, ("shape" + sa.id), mapApi.getSubAreaShape(sa.id), alliance.backEmblem.color, 0.6, alliance.backEmblem.color, 0.4, pThickness);
                };
            };
        }

        private function updateConquestSubarea(pUpdateConquestModeData:Boolean=true):void
        {
            var prismSubAreaInfo:PrismSubAreaWrapper;
            var list:Object;
            if (!(__conquestSubAreasInfos))
            {
                return;
            };
            if (!(__allAreas))
            {
                this._gdConquestProvider = new Array();
                __allAreas = {
                    "label":uiApi.getText("ui.pvp.conquestAllAreas"),
                    "children":[],
                    "expend":false,
                    "type":"areaShape",
                    "layer":"AllAreas"
                };
                __normalAreas = {
                    "label":uiApi.getText("ui.prism.cartography.normal"),
                    "children":[],
                    "expend":false,
                    "type":"areaShape",
                    "layer":NORMAL_AREAS
                };
                __weakenedAreas = {
                    "label":uiApi.getText("ui.prism.cartography.weakened"),
                    "children":[],
                    "expend":false,
                    "type":"areaShape",
                    "layer":WEAKENED_AREAS
                };
                __vulnerableAreas = {
                    "label":uiApi.getText("ui.prism.cartography.vulnerable"),
                    "children":[],
                    "expend":false,
                    "type":"areaShape",
                    "layer":VULNERABLE_AREAS
                };
                __villagesAreas = {
                    "children":[],
                    "expend":false,
                    "type":"areaShape",
                    "layer":VILLAGES_AREAS
                };
                __capturableAreas = {
                    "label":uiApi.getText("ui.pvp.conquestCapturableAreas"),
                    "children":[],
                    "expend":false,
                    "type":"areaShape",
                    "layer":CAPTURABLE_AREAS
                };
                this._gdConquestProvider.unshift(__allAreas);
                this._gdConquestProvider.push(__capturableAreas);
                this._gdConquestProvider.push(__normalAreas);
                this._gdConquestProvider.push(__weakenedAreas);
                this._gdConquestProvider.push(__vulnerableAreas);
            };
            for each (prismSubAreaInfo in __conquestSubAreasInfos)
            {
                updatePrismAndSubareaStatus(prismSubAreaInfo, pUpdateConquestModeData);
            };
            for each (list in this._gdConquestProvider)
            {
                list.children.sort(this.compareSubAreaItem);
            };
            if (__weakenedAreas.children.length > 0)
            {
                __weakenedAreas.children.sortOn("vulnerabilityDate");
            };
            this._updateConquestAreas = false;
        }

        private function compareSubAreaItem(pItemA:Object, pItemB:Object):int
        {
            var result:int;
            var labelA:String = utilApi.noAccent(pItemA.label);
            var labelB:String = utilApi.noAccent(pItemB.label);
            if (labelA > labelB)
            {
                result = 1;
            }
            else
            {
                if (labelA < labelB)
                {
                    result = -1;
                };
            };
            return (result);
        }

        private function makeProvider(aa:Object=null, expend:Boolean=false)
        {
            var superArea:Object;
            var subarea:Object;
            var area:Object;
            var res:Array = new Array();
            var superAreas:Object = mapApi.getAllSuperArea();
            for each (superArea in superAreas)
            {
                res[superArea.id] = {
                    "label":superArea.name,
                    "children":[],
                    "expend":expend,
                    "type":"superarea",
                    "data":superArea
                };
            };
            if (!(aa))
            {
                if (!(__subAreaList))
                {
                    __subAreaList = mapApi.getAllSubArea();
                };
                aa = __subAreaList;
            };
            for each (subarea in aa)
            {
                if (!!(subarea))
                {
                    area = subarea.area;
                    if (((((((((area) && (area.name))) && (subarea))) && (subarea.name))) && (subarea.customWorldMap)))
                    {
                        if (!(res[area.superAreaId].children[area.id]))
                        {
                            res[area.superAreaId].children[area.id] = {
                                "label":area.name,
                                "children":[],
                                "parent":res[area.superAreaId],
                                "expend":expend,
                                "type":"area",
                                "data":null
                            };
                        };
                        res[area.superAreaId].children[area.id].children.push({
                            "label":subarea.name,
                            "children":null,
                            "parent":res[area.superAreaId].children[area.id],
                            "type":"subarea",
                            "data":subarea
                        });
                    };
                };
            };
            return (res);
        }

        private function searchFilter():void
        {
            if (this._searchCriteria)
            {
                this.gdZone.dataProvider = this.filterSubArea(this._searchCriteria, this._dataProvider);
            }
            else
            {
                this.gdZone.dataProvider = this._dataProvider;
            };
        }

        private function filterSubArea(searchedText:String, a:Array):Array
        {
            var item:Object;
            var copy:Object;
            var key:String;
            var subRes:Array;
            var copy2:Object;
            var key2:String;
            var res:Array = new Array();
            for each (item in a)
            {
                if (utilApi.noAccent(item.label).toLowerCase().indexOf(utilApi.noAccent(searchedText).toLowerCase()) != -1)
                {
                    copy = new Object();
                    for (key in item)
                    {
                        if (key != "children")
                        {
                            copy[key] = item[key];
                        }
                        else
                        {
                            copy[key] = this.filterSubArea(searchedText, item[key]);
                        };
                    };
                    if (((copy.children) && (copy.children.length)))
                    {
                        copy.expend = true;
                    };
                    res.push(copy);
                }
                else
                {
                    subRes = this.filterSubArea(searchedText, item.children);
                    if (subRes.length)
                    {
                        copy2 = new Object();
                        for (key2 in item)
                        {
                            if (key2 != "children")
                            {
                                copy2[key2] = item[key2];
                            }
                            else
                            {
                                copy2[key2] = subRes;
                            };
                        };
                        copy2.expend = true;
                        res.push(copy2);
                    };
                };
            };
            return (res);
        }


    }
}//package ui

