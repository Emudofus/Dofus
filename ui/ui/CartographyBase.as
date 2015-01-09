package ui
{
    import d2api.SoundApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.ConfigApi;
    import d2api.SocialApi;
    import d2api.UtilApi;
    import d2api.TimeApi;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.Texture;
    import flash.utils.Dictionary;
    import d2data.HintCategory;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2enums.ComponentHookList;
    import d2hooks.GuildInformationsFarms;
    import d2hooks.GuildHousesUpdate;
    import d2hooks.TaxCollectorListUpdate;
    import d2hooks.MapHintsFilter;
    import d2hooks.GuildPaddockAdd;
    import d2hooks.GuildPaddockRemoved;
    import d2hooks.GuildTaxCollectorAdd;
    import d2hooks.GuildTaxCollectorRemoved;
    import d2hooks.GuildHouseAdd;
    import d2hooks.GuildHouseRemoved;
    import d2hooks.RemoveMapFlag;
    import d2hooks.PrismsList;
    import d2hooks.PrismsListUpdate;
    import d2actions.PlaySound;
    import d2actions.PrismsListRegister;
    import d2enums.PrismListenEnum;
    import d2network.AccountHouseInformations;
    import ui.type.Flag;
    import d2actions.GuildGetInformations;
    import d2enums.GuildInformationsTypeEnum;
    import d2data.SubArea;
    import d2enums.PrismStateEnum;
    import d2data.PrismSubAreaWrapper;
    import d2data.AllianceWrapper;
    import d2data.MapPosition;
    import d2network.PaddockContentInformations;
    import d2data.GuildHouseWrapper;
    import d2data.TaxCollectorWrapper;
    import d2data.EmblemSymbol;
    import d2actions.*;
    import d2hooks.*;

    public class CartographyBase extends AbstractCartographyUi 
    {

        public static const MODE_MOVE:String = "move";
        public static const MODE_FLAG:String = "flag";
        protected static const NO_PRISM_AREAS:String = "noPrismAreas";
        protected static const NORMAL_AREAS:String = "normalAreas";
        protected static const WEAKENED_AREAS:String = "weakenedAreas";
        protected static const VULNERABLE_AREAS:String = "vulnerableAreas";
        protected static const VILLAGES_AREAS:String = "villagesAreas";
        protected static const CAPTURABLE_AREAS:String = "capturableAreas";
        protected static const WORLD_OF_AMAKNA:int = 1;
        protected static const WORLD_OF_INCARNAM:int = 2;
        protected static const FRIGOST_III:int = 12;
        protected static const MAP_TYPE_SUPERAREA:uint = 0;
        protected static const MAP_TYPE_SUBAREA:uint = 1;
        protected static var gridDisplayed:Boolean = false;
        protected static var templeDisplayed:Boolean = true;
        protected static var bidHouseDisplayed:Boolean = true;
        protected static var craftHouseDisplayed:Boolean = true;
        protected static var miscDisplayed:Boolean = true;
        protected static var conquestDisplayed:Boolean = true;
        protected static var dungeonDisplayed:Boolean = true;
        protected static var privateDisplayed:Boolean = true;
        private static var MAP_PRESET:Array;

        public var soundApi:SoundApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var configApi:ConfigApi;
        public var socialApi:SocialApi;
        public var utilApi:UtilApi;
        public var timeApi:TimeApi;
        public var btn_close:ButtonContainer;
        public var btn_flag:ButtonContainer;
        public var btn_player:ButtonContainer;
        public var btn_grid:ButtonContainer;
        public var btn_zoom1:ButtonContainer;
        public var btn_zoom2:ButtonContainer;
        public var btn_zoom3:ButtonContainer;
        public var btn_zoom4:ButtonContainer;
        public var btn_zoom5:ButtonContainer;
        public var ctrSubAreaInfo:GraphicContainer;
        public var ctrSubAreaInfoBg:GraphicContainer;
        public var lblSubAreaInfo:Label;
        public var lbl_AllianceName:Label;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        protected var __mapMode:String = "move";
        protected var __iconScale:Number;
        protected var __minZoom:Number;
        protected var __playerPos:Object;
        protected var __startWorldMapInfo:Object;
        protected var __worldMapInfo:Object;
        protected var __hintCategoryFiltersList:Array;
        protected var __layersToShow:Array;
        protected var __hintCaptions:Dictionary;
        protected var __allAreas:Object;
        protected var __capturableAreas:Object;
        protected var __noPrismAreas:Object;
        protected var __normalAreas:Object;
        protected var __weakenedAreas:Object;
        protected var __vulnerableAreas:Object;
        protected var __villagesAreas:Object;
        protected var __subAreaList:Object;
        protected var __lastAreaShap:String = "";
        protected var __areaShapeDisplayed:Array;
        protected var __conquestSubAreasInfos:Object;
        protected var __showAllianceEmblem:Boolean;
        private var _flags:Object;
        private var _currentSubarea:Object;
        private var _hintCategoryFilters:int;
        private var _textCss:String;
        private var _currentAllianceEmblemBgShape:int;
        private var _currentAllianceEmblemBgColor:int;
        private var _currentAllianceEmblemSymbolShape:int;
        private var _currentAllianceEmblemSymbolColor:int;
        private var _allianceEmblemsLoaded:Boolean;
        private var _currentPrismSubAreaId:int;
        private var _lastSubAreaId:int;
        private var _waitingForSocialUpdate:int;

        public function CartographyBase()
        {
            this.__hintCategoryFiltersList = new Array();
            this.__hintCaptions = new Dictionary();
            this.__areaShapeDisplayed = new Array();
            super();
        }

        override public function main(params:Object=null):void
        {
            var hintCat:HintCategory;
            super.main(params);
            this._currentPrismSubAreaId = -1;
            this._lastSubAreaId = -1;
            this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
            this.btn_flag.soundId = SoundEnum.CHECKBOX_CHECKED;
            this.btn_player.soundId = SoundEnum.GEN_BUTTON;
            this.btn_grid.soundId = SoundEnum.CHECKBOX_CHECKED;
            var i:uint = 1;
            while (i <= 5)
            {
                this[("btn_zoom" + i)].soundId = SoundEnum.GEN_BUTTON;
                i++;
            };
            uiApi.addComponentHook(this.btn_flag, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_flag, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btn_grid, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_grid, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btn_player, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_player, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(mapViewer, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(mapViewer, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(mapViewer, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(mapViewer, ComponentHookList.ON_PRESS);
            uiApi.addComponentHook(mapViewer, "onMapMove");
            uiApi.addComponentHook(mapViewer, "onMapElementRollOver");
            uiApi.addComponentHook(mapViewer, "onMapRollOver");
            uiApi.addComponentHook(mapViewer, "onComponentReadyMessage");
            uiApi.addComponentHook(this.tx_emblemBack, "onTextureReady");
            uiApi.addComponentHook(this.tx_emblemUp, "onTextureReady");
            sysApi.addHook(GuildInformationsFarms, this.onGuildInformationsFarms);
            sysApi.addHook(GuildHousesUpdate, this.onGuildHousesUpdate);
            sysApi.addHook(TaxCollectorListUpdate, this.onTaxCollectorListUpdate);
            sysApi.addHook(MapHintsFilter, this.onMapHintsFilter);
            sysApi.addHook(GuildPaddockAdd, this.onGuildPaddockAdd);
            sysApi.addHook(GuildPaddockRemoved, this.onGuildPaddockRemoved);
            sysApi.addHook(GuildTaxCollectorAdd, this.onGuildTaxCollectorAdd);
            sysApi.addHook(GuildTaxCollectorRemoved, this.onGuildTaxCollectorRemoved);
            sysApi.addHook(GuildHouseAdd, this.onGuildHouseAdd);
            sysApi.addHook(GuildHouseRemoved, this.onGuildHouseRemoved);
            sysApi.addHook(RemoveMapFlag, this.onRemoveMapFlag);
            sysApi.addHook(PrismsList, this.onPrismsListInformation);
            sysApi.addHook(PrismsListUpdate, this.onPrismsInfoUpdate);
            sysApi.addEventListener(this.onEnterFrame, "cartography");
            gridDisplayed = sysApi.getData("ShowMapGrid", true);
            this._hintCategoryFilters = this.configApi.getConfigProperty("dofus", "mapFilters");
            this._textCss = (uiApi.me().getConstant("css") + "normal.css");
            var hintCategories:Object = this.dataApi.getHintCategories();
            for each (hintCat in hintCategories)
            {
                this.__hintCategoryFiltersList[hintCat.id] = (this._hintCategoryFilters & Math.pow(2, hintCat.id));
            };
            this.__playerPos = params.currentMap;
            this._flags = params.flags;
            this.openPlayerCurrentMap();
            this.__startWorldMapInfo = this.__worldMapInfo;
        }

        public function addFlag(flagId:String, flagLegend:String, x:int, y:int, color:int=-1, playSound:Boolean=true, needMapUpdate:Boolean=true, canBeManuallyRemoved:Boolean=true):void
        {
            var uri:String;
            if (playSound)
            {
                sysApi.sendAction(new PlaySound("16039"));
            };
            switch (flagId)
            {
                case "flag_playerPosition":
                    uri = (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|myPosition");
                    break;
                case "Phoenix":
                    uri = (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|flag1");
                    break;
                default:
                    uri = (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|flag0");
            };
            var flag:Object = mapViewer.addIcon("layer_8", flagId, uri, x, y, this.__iconScale, flagLegend, true, color, true, canBeManuallyRemoved);
            if (flag)
            {
                if (flagId == "flag_playerPosition")
                {
                    mapViewer.getMapElement(flagId).canBeAutoSize = false;
                };
                if (needMapUpdate)
                {
                    this.updateMap();
                };
            };
        }

        public function updateFlag(flagId:String, x:int, y:int, legend:String):Boolean
        {
            var flag:Object = mapViewer.getMapElement(flagId);
            if (flag)
            {
                flag.x = x;
                flag.y = y;
                flag.legend = legend;
                this.updateMap();
                return (true);
            };
            return (false);
        }

        override public function unload():void
        {
            var hintCatId:Object;
            super.unload();
            sysApi.removeEventListener(this.onEnterFrame);
            if (!(sysApi.getOption("cacheMapEnabled", "dofus")))
            {
                _currentWorldId = -1;
            };
            this._hintCategoryFilters = 0;
            for (hintCatId in this.__hintCategoryFiltersList)
            {
                if (this.__hintCategoryFiltersList[hintCatId])
                {
                    this._hintCategoryFilters = (this._hintCategoryFilters + Math.pow(2, int(hintCatId)));
                };
            };
            this.configApi.setConfigProperty("dofus", "mapFilters", this._hintCategoryFilters);
            sysApi.setData("HintCategoryFilter", this._hintCategoryFilters, true);
            this.saveCurrentMapPreset();
            MAP_PRESET = null;
            sysApi.sendAction(new PrismsListRegister("Cartography", PrismListenEnum.PRISM_LISTEN_NONE));
        }

        protected function openPlayerCurrentMap():void
        {
            var subArea:Object = this.playerApi.currentSubArea();
            if (!(subArea.hasCustomWorldMap))
            {
                this.openNewMap(subArea.area.superArea.worldmap, MAP_TYPE_SUPERAREA, subArea.area.superArea);
            }
            else
            {
                this.openNewMap(subArea.worldmap, MAP_TYPE_SUBAREA, subArea);
            };
        }

        protected function openNewMap(worldmapInfo:Object, mode:uint, areaInfo:Object, forceReload:Boolean=false):Boolean
        {
            var index:String;
            var zoom:String;
            var i:int;
            var nbZooms:int;
            var mapPreset:MapPreset;
            var z:Number;
            if (((!(forceReload)) && ((worldmapInfo.id == _currentWorldId))))
            {
                return (false);
            };
            mapViewer.visible = false;
            switch (mode)
            {
                case MAP_TYPE_SUPERAREA:
                    this._currentSubarea = null;
                    _currentSuperarea = areaInfo;
                    break;
                case MAP_TYPE_SUBAREA:
                    this._currentSubarea = areaInfo;
                    _currentSuperarea = areaInfo.area.superArea;
                    break;
            };
            var id:uint = ((((!((this._currentSubarea == null))) && ((this._currentSubarea.customWorldMap.length > 0)))) ? this._currentSubarea.customWorldMap[0] : worldmapInfo.id);
            if (((!((_currentWorldId == 0))) && (!((id == _currentWorldId)))))
            {
                this._flags = modCartography.getFlags(id);
            };
            _currentWorldId = id;
            this.__worldMapInfo = worldmapInfo;
            if (this._currentSubarea)
            {
                index = ("subarea_" + this._currentSubarea.id);
            }
            else
            {
                index = ("superarea_" + _currentSuperarea.id);
            };
            mapViewer.origineX = worldmapInfo.origineX;
            mapViewer.origineY = worldmapInfo.origineY;
            mapViewer.mapWidth = worldmapInfo.mapWidth;
            mapViewer.mapHeight = worldmapInfo.mapHeight;
            mapViewer.minScale = worldmapInfo.minScale;
            mapViewer.maxScale = worldmapInfo.maxScale;
            MAP_PRESET = [];
            if (MAP_PRESET[index])
            {
                mapPreset = MAP_PRESET[index];
                mapViewer.startScale = mapPreset.zoomFactor;
            }
            else
            {
                mapViewer.startScale = worldmapInfo.startScale;
            };
            mapViewer.showGrid = gridDisplayed;
            var folder:String = ((sysApi.getConfigEntry("config.gfx.path.maps") + id) + "/");
            mapViewer.removeAllMap();
            this.__minZoom = NaN;
            for each (zoom in worldmapInfo.zoom)
            {
                z = parseFloat(zoom);
                if (isNaN(this.__minZoom))
                {
                    this.__minZoom = z;
                }
                else
                {
                    if (z < this.__minZoom)
                    {
                        this.__minZoom = z;
                    };
                };
                mapViewer.addMap(z, ((folder + zoom) + "/"), worldmapInfo.totalWidth, worldmapInfo.totalHeight, 250, 250);
            };
            mapViewer.minScale = this.__minZoom;
            mapViewer.startScale = Number(mapViewer.startScale.toFixed(2));
            nbZooms = mapViewer.zoomLevels.length;
            if (mapViewer.zoomLevels.indexOf(mapViewer.startScale) == -1)
            {
                i = 0;
                while (i < nbZooms)
                {
                    if (mapViewer.startScale < mapViewer.zoomLevels[i])
                    {
                        if (i == 0)
                        {
                            mapViewer.startScale = mapViewer.zoomLevels[i];
                        }
                        else
                        {
                            mapViewer.startScale = mapViewer.zoomLevels[(i - 1)];
                        };
                        break;
                    };
                    i++;
                };
            };
            mapViewer.finalize();
            this.__iconScale = Math.min((worldmapInfo.mapWidth / 31.5), 3);
            this.initMap();
            this.setupZoomButtons();
            this.selectZoomButton();
            return (true);
        }

        protected function initMap():void
        {
            var l:String;
            var hint:Object;
            var layerId:Object;
            var mapMoved:Boolean;
            var flagsList:Object;
            var nFlag:int;
            var p:int;
            var daHouse:AccountHouseInformations;
            var layerName:String;
            var layerVisible:Boolean;
            var flag:Flag;
            var posHouse:Object;
            var playerSubarea:Object;
            var mapBounds:Object;
            this.btn_grid.selected = gridDisplayed;
            mapViewer.showGrid = gridDisplayed;
            mapViewer.autoSizeIcon = true;
            mapViewer.addLayer(NO_PRISM_AREAS);
            mapViewer.addLayer(NORMAL_AREAS);
            mapViewer.addLayer(WEAKENED_AREAS);
            mapViewer.addLayer(VULNERABLE_AREAS);
            mapViewer.addLayer(VILLAGES_AREAS);
            mapViewer.addLayer(CAPTURABLE_AREAS);
            this.__subAreaList = mapApi.getAllSubArea();
            var iconsPath:String = (sysApi.getConfigEntry("config.content.path") + "gfx/icons/assets.swf|icon_");
            var hints:Object = mapApi.getHintIds();
            this.__layersToShow = new Array();
            for each (hint in hints)
            {
                if (hint.worldMapId == _currentWorldId)
                {
                    l = ("layer_" + hint.category);
                    if (!(this.__layersToShow[l]))
                    {
                        this.__layersToShow[l] = true;
                        mapViewer.addLayer(l);
                    };
                    mapViewer.addIcon(l, ("hint_" + hint.id), (iconsPath + hint.gfx), hint.x, hint.y, this.__iconScale, hint.name);
                };
            };
            mapViewer.addLayer("layer_5");
            this.__layersToShow["layer_5"] = true;
            mapViewer.addLayer("layer_7");
            this.__layersToShow["layer_7"] = !(this.isDungeonMap());
            mapViewer.addLayer("layer_8");
            this.__layersToShow["layer_8"] = true;
            for (layerId in this.__hintCategoryFiltersList)
            {
                layerName = ("layer_" + layerId);
                layerVisible = ((this.__layersToShow[layerName]) ? this.__hintCategoryFiltersList[layerId] : false);
                mapViewer.showLayer(layerName, layerVisible);
            };
            mapMoved = this.restoreCurrentMapPreset();
            flagsList = mapViewer.getMapElementsByLayer("layer_8");
            nFlag = flagsList.length;
            p = 0;
            while (p < nFlag)
            {
                mapViewer.removeMapElement(flagsList[p]);
                p++;
            };
            if (this._flags)
            {
                _nbCustomFlags[_currentWorldId] = 0;
                for each (flag in this._flags)
                {
                    this.addFlag(flag.id, flag.legend, flag.position.x, flag.position.y, flag.color, false, false, flag.canBeManuallyRemoved);
                    var _local_21 = _nbCustomFlags;
                    var _local_22 = _currentWorldId;
                    var _local_23 = (_local_21[_local_22] + 1);
                    _local_21[_local_22] = _local_23;
                };
            };
            var houses:Object = this.playerApi.getPlayerHouses();
            var indexHouse:int;
            for each (daHouse in houses)
            {
                if (this.dataApi.getSubArea(daHouse.subAreaId).area.superAreaId == superAreaId)
                {
                    posHouse = {
                        "x":daHouse.worldX,
                        "y":daHouse.worldY
                    };
                    this.__hintCaptions[("myHouse_" + indexHouse)] = uiApi.getText("ui.common.myHouse");
                    mapViewer.addIcon("layer_7", ("myHouse_" + indexHouse), (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1000"), daHouse.worldX, daHouse.worldY, this.__iconScale);
                    indexHouse++;
                };
            };
            if (_currentWorldId == WORLD_OF_INCARNAM)
            {
                this.addSubAreasShapes();
            };
            if (this.__playerPos)
            {
                playerSubarea = this.playerApi.currentSubArea();
                if (playerSubarea.area.superArea.id == _currentSuperarea.id)
                {
                    if (((!(mapViewer.getMapElement("flag_playerPosition"))) && (((!(this._currentSubarea)) || ((playerSubarea.id == this._currentSubarea.id))))))
                    {
                        this.addFlag("flag_playerPosition", uiApi.getText("ui.cartography.yourposition"), this.__playerPos.outdoorX, this.__playerPos.outdoorY, 39423, false, false);
                    };
                    mapBounds = mapViewer.mapBounds;
                    if (((!((((((((mapBounds.left > this.__playerPos.outdoorX)) || ((mapBounds.right < this.__playerPos.outdoorX)))) || ((mapBounds.bottom < this.__playerPos.outdoorY)))) || ((mapBounds.top > this.__playerPos.outdoorY))))) && ((mapViewer.zoomFactor >= this.__minZoom))))
                    {
                        if (!(mapMoved))
                        {
                            mapViewer.moveTo(this.__playerPos.outdoorX, this.__playerPos.outdoorY);
                        };
                    }
                    else
                    {
                        if (!(mapMoved))
                        {
                            mapViewer.moveTo(this.__worldMapInfo.centerX, this.__worldMapInfo.centerY);
                        };
                    };
                }
                else
                {
                    if (!(mapMoved))
                    {
                        mapViewer.moveTo(this.__worldMapInfo.centerX, this.__worldMapInfo.centerY);
                    };
                };
            }
            else
            {
                if (!(mapMoved))
                {
                    mapViewer.moveTo(this.__worldMapInfo.centerX, this.__worldMapInfo.centerY);
                };
            };
            if (this.socialApi.hasGuild())
            {
                this._waitingForSocialUpdate++;
                sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY));
                if (((this.socialApi.guildHousesUpdateNeeded()) && (((!(this.socialApi.getGuildHouses())) || ((this.socialApi.getGuildHouses().length == 0))))))
                {
                    this._waitingForSocialUpdate++;
                    sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_HOUSES));
                }
                else
                {
                    this.onGuildHousesUpdate();
                };
                if (((!(this.socialApi.getGuildPaddocks())) || ((this.socialApi.getGuildPaddocks().length == 0))))
                {
                    this._waitingForSocialUpdate++;
                    sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_PADDOCKS));
                }
                else
                {
                    this.onGuildInformationsFarms();
                };
            }
            else
            {
                if (mapMoved)
                {
                    this.updateMap();
                };
            };
            mapViewer.visible = true;
        }

        protected function addSubAreasShapes():void
        {
            var subArea:Object;
            this.__noPrismAreas = {"children":[]};
            for each (subArea in this.__subAreaList)
            {
                if (((((!(mapViewer.getMapElement(("shape" + subArea.id)))) && (subArea.displayOnWorldMap))) && (subArea.worldmap)))
                {
                    if (subArea.worldmap.id == _currentWorldId)
                    {
                        mapViewer.addAreaShape(NO_PRISM_AREAS, ("shape" + subArea.id), mapApi.getSubAreaShape(subArea.id), 0x333333, 0.2, 1096297, 0.2);
                    };
                    this.__noPrismAreas.children.push({"data":subArea});
                };
            };
        }

        protected function saveCurrentMapPreset():void
        {
            var index:String;
            if (this.__worldMapInfo)
            {
                if (this._currentSubarea)
                {
                    index = ("subarea_" + this._currentSubarea.id);
                }
                else
                {
                    index = ("superarea_" + _currentSuperarea.id);
                };
                MAP_PRESET[index] = new MapPreset(mapViewer.mapPixelPosition, mapViewer.zoomFactor);
            };
        }

        override protected function addCustomFlag(pX:int, pY:int):void
        {
            super.addCustomFlag(pX, pY);
            this.__mapMode = MODE_MOVE;
            this.btn_flag.selected = false;
        }

        private function updateMapAreaShape():void
        {
            var mapAreaShape:Object;
            if (this.__lastAreaShap != "")
            {
                mapAreaShape = mapViewer.getMapElement(this.__lastAreaShap);
                if (mapAreaShape)
                {
                    if (this.__areaShapeDisplayed.indexOf(mapAreaShape.layer) == -1)
                    {
                        mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 0);
                    }
                    else
                    {
                        mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 1);
                    };
                };
                this.__lastAreaShap = "";
            };
        }

        override protected function addCustomFlagWithRightClick(pX:Number, pY:Number):void
        {
            this.__mapMode = MODE_FLAG;
            super.addCustomFlagWithRightClick(pX, pY);
        }

        protected function updatePrismIcon(pPrismSubAreaInformation:PrismSubAreaWrapper):void
        {
            var prismStateInfo:Object;
            var prismDateText:String;
            var subArea:SubArea = this.dataApi.getSubArea(pPrismSubAreaInformation.subAreaId);
            var prismId:String = ("prism_" + pPrismSubAreaInformation.subAreaId);
            if (((((((!((pPrismSubAreaInformation.mapId == -1))) && (subArea.worldmap))) && ((subArea.worldmap.id == _currentWorldId)))) && (((pPrismSubAreaInformation.alliance) || (this.socialApi.getAlliance())))))
            {
                prismStateInfo = modCartography.getPrismStateInfo(pPrismSubAreaInformation.state);
                prismDateText = "";
                switch (pPrismSubAreaInformation.state)
                {
                    case PrismStateEnum.PRISM_STATE_NORMAL:
                        prismDateText = (uiApi.getText("ui.prism.vulnerabilityHour") + " :");
                        break;
                    case PrismStateEnum.PRISM_STATE_WEAKENED:
                    case PrismStateEnum.PRISM_STATE_SABOTAGED:
                        prismDateText = ((uiApi.getText("ui.prism.startVulnerability") + uiApi.getText("ui.common.colon")) + this.timeApi.getDate((pPrismSubAreaInformation.nextVulnerabilityDate * 1000)));
                        break;
                };
                if ((((((pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_NORMAL)) || ((pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_WEAKENED)))) || ((pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_SABOTAGED))))
                {
                    prismDateText = (prismDateText + (" " + pPrismSubAreaInformation.vulnerabilityHourString));
                };
                this.__hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] = prismStateInfo.text;
                if (prismDateText.length > 0)
                {
                    this.__hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] = (this.__hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] + ("\n" + prismDateText));
                };
                if (mapViewer.getMapElement(prismId))
                {
                    mapViewer.removeMapElement(mapViewer.getMapElement(prismId));
                };
                mapViewer.addIcon("layer_5", prismId, ((sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_") + prismStateInfo.icon), pPrismSubAreaInformation.worldX, pPrismSubAreaInformation.worldY, this.__iconScale);
            }
            else
            {
                if (pPrismSubAreaInformation.mapId == -1)
                {
                    mapViewer.removeMapElement(mapViewer.getMapElement(prismId));
                };
            };
        }

        protected function updatePrismAndSubareaStatus(prismSubAreaInformation:PrismSubAreaWrapper, pUpdateConquestModeData:Boolean=true):void
        {
            var lineColor:uint;
            var fillColor:uint;
            var layer:String;
            var currentAreaItem:Object;
            var alliance:AllianceWrapper;
            var prismState:uint;
            var lineAlpha:Number = 0.6;
            var fillAlpha:Number = 0.4;
            var subArea:SubArea = mapApi.getSubArea(prismSubAreaInformation.subAreaId);
            if (((((((!(subArea)) || (!(subArea.name)))) || (!(subArea.worldmap)))) || (!((subArea.worldmap.id == _currentWorldId)))))
            {
                return;
            };
            if (pUpdateConquestModeData)
            {
                currentAreaItem = {
                    "label":subArea.name,
                    "parent":this.__allAreas,
                    "type":"subarea",
                    "data":subArea
                };
                this.addConquestItem(this.__allAreas, currentAreaItem);
            };
            if (((!((prismSubAreaInformation.mapId == -1))) || (prismSubAreaInformation.alliance)))
            {
                alliance = ((!(prismSubAreaInformation.alliance)) ? this.socialApi.getAlliance() : prismSubAreaInformation.alliance);
                if (((((currentAreaItem) && (this.socialApi.hasAlliance()))) && ((this.socialApi.getAlliance().allianceId == alliance.allianceId))))
                {
                    currentAreaItem.css = this._textCss;
                    currentAreaItem.cssClass = "bonus";
                };
                lineColor = alliance.backEmblem.color;
                fillColor = lineColor;
                prismState = ((!((prismSubAreaInformation.mapId == -1))) ? prismSubAreaInformation.state : PrismStateEnum.PRISM_STATE_NORMAL);
                switch (prismState)
                {
                    case PrismStateEnum.PRISM_STATE_INVULNERABLE:
                    case PrismStateEnum.PRISM_STATE_NORMAL:
                        layer = NORMAL_AREAS;
                        if (currentAreaItem)
                        {
                            this.addConquestItem(this.__normalAreas, currentAreaItem);
                        };
                        break;
                    case PrismStateEnum.PRISM_STATE_WEAKENED:
                    case PrismStateEnum.PRISM_STATE_SABOTAGED:
                        layer = WEAKENED_AREAS;
                        if (currentAreaItem)
                        {
                            currentAreaItem.vulnerabilityDate = prismSubAreaInformation.nextVulnerabilityDate;
                            currentAreaItem.label = (currentAreaItem.label + (" - " + prismSubAreaInformation.vulnerabilityHourString));
                            this.addConquestItem(this.__weakenedAreas, currentAreaItem);
                        };
                        break;
                    case PrismStateEnum.PRISM_STATE_VULNERABLE:
                        layer = VULNERABLE_AREAS;
                        if (currentAreaItem)
                        {
                            this.addConquestItem(this.__vulnerableAreas, currentAreaItem);
                        };
                        break;
                };
            }
            else
            {
                layer = CAPTURABLE_AREAS;
                lineColor = 1096297;
                fillColor = lineColor;
                if (currentAreaItem)
                {
                    this.addConquestItem(this.__capturableAreas, currentAreaItem);
                };
            };
            mapViewer.addAreaShape(layer, ("shape" + prismSubAreaInformation.subAreaId), mapApi.getSubAreaShape(prismSubAreaInformation.subAreaId), lineColor, lineAlpha, fillColor, fillAlpha);
        }

        protected function addConquestItem(pList:Object, pItem:Object):void
        {
            var item:Object;
            var addItem:Boolean;
            if (pList)
            {
                addItem = true;
                for each (item in pList.children)
                {
                    if (item.data.id == pItem.data.id)
                    {
                        pList.children[pList.children.indexOf(item)] = pItem;
                        addItem = false;
                        break;
                    };
                };
                if (addItem)
                {
                    pList.children.push(pItem);
                };
            };
        }

        public function onEnterFrame():void
        {
            var mouseX:Number;
            var mouseY:Number;
            if (this.ctrSubAreaInfo.visible)
            {
                mouseX = uiApi.getMouseX();
                mouseY = uiApi.getMouseY();
                if (mapViewer.useFlagCursor)
                {
                    mouseX = (mouseX + 20);
                };
                this.ctrSubAreaInfo.x = mouseX;
                this.ctrSubAreaInfo.y = mouseY;
            };
        }

        public function onPress(target:Object):void
        {
            switch (target)
            {
                case mapViewer:
                    this.ctrSubAreaInfo.visible = false;
                    return;
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_flag:
                    if (this.__mapMode == MODE_MOVE)
                    {
                        mapViewer.enabledDrag = false;
                        this.__mapMode = MODE_FLAG;
                    }
                    else
                    {
                        mapViewer.enabledDrag = true;
                        this.__mapMode = MODE_MOVE;
                    };
                    break;
                case this.btn_player:
                    if (mapViewer.zoomFactor >= this.__minZoom)
                    {
                        mapViewer.moveTo(this.__playerPos.outdoorX, this.__playerPos.outdoorY);
                        if (!(mapViewer.getMapElement("flag_playerPosition")))
                        {
                            this.addFlag("flag_playerPosition", uiApi.getText("ui.cartography.yourposition"), this.__playerPos.outdoorX, this.__playerPos.outdoorY, 39423);
                        };
                    };
                    break;
                case this.btn_grid:
                    gridDisplayed = !(sysApi.getData("ShowMapGrid", true));
                    sysApi.setData("ShowMapGrid", gridDisplayed, true);
                    this.btn_grid.selected = gridDisplayed;
                    mapViewer.showGrid = gridDisplayed;
                    break;
                case this.btn_zoom1:
                    mapViewer.zoom(mapViewer.zoomLevels[0]);
                    break;
                case this.btn_zoom2:
                    mapViewer.zoom(mapViewer.zoomLevels[1]);
                    break;
                case this.btn_zoom3:
                    mapViewer.zoom(mapViewer.zoomLevels[2]);
                    break;
                case this.btn_zoom4:
                    mapViewer.zoom(mapViewer.zoomLevels[3]);
                    break;
                case this.btn_zoom5:
                    mapViewer.zoom(mapViewer.zoomLevels[4]);
                    break;
                case mapViewer:
                    if (this.__mapMode == MODE_FLAG)
                    {
                        this.addCustomFlag(mapViewer.currentMouseMapX, mapViewer.currentMouseMapY);
                    };
                    this.ctrSubAreaInfo.x = uiApi.getMouseX();
                    this.ctrSubAreaInfo.y = uiApi.getMouseY();
                    this.ctrSubAreaInfo.visible = true;
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_flag:
                    tooltipText = uiApi.getText("ui.map.flag");
                    break;
                case this.btn_player:
                    tooltipText = uiApi.getText("ui.map.player");
                    break;
                case this.btn_grid:
                    tooltipText = uiApi.getText("ui.option.displayGrid");
                    break;
                case mapViewer:
                    this.ctrSubAreaInfo.visible = true;
                    if (this.__mapMode == MODE_FLAG)
                    {
                        if (!(mapViewer.useFlagCursor))
                        {
                            mapViewer.useFlagCursor = true;
                        };
                    }
                    else
                    {
                        if (mapViewer.useFlagCursor)
                        {
                            mapViewer.useFlagCursor = false;
                        };
                    };
                    return;
            };
            if (tooltipText)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            switch (target)
            {
                case mapViewer:
                    this.ctrSubAreaInfo.visible = false;
                    if (this.__mapMode == MODE_FLAG)
                    {
                        mapViewer.useFlagCursor = false;
                    };
                    return;
                default:
                    uiApi.hideTooltip();
            };
        }

        public function onMapElementRollOver(map:Object, target:Object):void
        {
            var txt:String = this.__hintCaptions[target.id];
            if (!(txt))
            {
                txt = target.legend;
            };
            uiApi.showTooltip(uiApi.textTooltipInfo(txt), target.bounds, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            if (target.id.indexOf("prism") != -1)
            {
                this._currentPrismSubAreaId = int(target.id.split("_")[1]);
            };
            this.onMapRollOver(map, target.x, target.y);
        }

        override public function onMapElementRollOut(map:Object, target:Object):void
        {
            super.onMapElementRollOut(map, target);
            this._currentPrismSubAreaId = -1;
        }

        public function onMapRollOver(target:Object, x:int, y:int):void
        {
            var currentAreaShape:String;
            var mapAreaShape:Object;
            var subAreaName:String;
            var subarea:Object;
            var mapSubArea:Object;
            var mapId:uint;
            var mapPosition:MapPosition;
            var prismSubAreaInfo:PrismSubAreaWrapper;
            var alliance:AllianceWrapper;
            this.__showAllianceEmblem = (this.tx_emblemBack.visible = (this.tx_emblemUp.visible = (this.lbl_AllianceName.visible = false)));
            var forcePrismSubArea:Boolean = !((this._currentPrismSubAreaId == -1));
            var subAreaText:String = ((x + ",") + y);
            var mapIds:Object = ((!(forcePrismSubArea)) ? mapApi.getMapIdByCoord(x, y) : null);
            var subAreaChanged:Boolean;
            if (((mapIds) || (forcePrismSubArea)))
            {
                if (!(forcePrismSubArea))
                {
                    for each (mapId in mapIds)
                    {
                        mapPosition = mapApi.getMapPositionById(mapId);
                        if (((!((mapPosition.worldMap == -1))) && (((!(subarea)) || (mapPosition.hasPriorityOnWorldmap)))))
                        {
                            mapSubArea = mapPosition.subArea;
                            if (((((mapSubArea) && (mapSubArea.worldmap))) && ((mapSubArea.worldmap.id == _currentWorldId))))
                            {
                                subarea = mapSubArea;
                                if (mapPosition.nameId != 0)
                                {
                                    subAreaName = mapPosition.name;
                                }
                                else
                                {
                                    subAreaName = subarea.name;
                                };
                            };
                        };
                    };
                }
                else
                {
                    subarea = mapApi.getSubArea(this._currentPrismSubAreaId);
                    subAreaName = subarea.name;
                };
                if (((((subarea) && (subarea.worldmap))) && ((subarea.worldmap.id == _currentWorldId))))
                {
                    if (subarea.id != this._lastSubAreaId)
                    {
                        subAreaChanged = true;
                        this._lastSubAreaId = subarea.id;
                    };
                    currentAreaShape = ("shape" + subarea.id);
                    if (currentAreaShape != this.__lastAreaShap)
                    {
                        mapAreaShape = mapViewer.getMapElement(this.__lastAreaShap);
                        if (mapAreaShape)
                        {
                            if (this.__areaShapeDisplayed.indexOf(mapAreaShape.layer) == -1)
                            {
                                mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 0);
                            }
                            else
                            {
                                mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 1);
                            };
                        };
                        this.__lastAreaShap = currentAreaShape;
                        mapAreaShape = mapViewer.getMapElement(this.__lastAreaShap);
                        if (mapAreaShape)
                        {
                            if (this.__areaShapeDisplayed.indexOf(mapAreaShape.layer) == -1)
                            {
                                mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1, 1, 1, 1);
                            }
                            else
                            {
                                mapViewer.areaShapeColorTransform(mapAreaShape, 100, 1.2, 1.2, 1.2, 1.5);
                            };
                        };
                    };
                    subAreaText = (subAreaText + ((((("\n" + subAreaName) + "\n") + uiApi.getText("ui.common.averageLevel")) + " ") + subarea.level));
                    prismSubAreaInfo = ((this.__conquestSubAreasInfos) ? this.__conquestSubAreasInfos[subarea.id] : null);
                    if (((prismSubAreaInfo) && (((!((prismSubAreaInfo.mapId == -1))) || (prismSubAreaInfo.alliance)))))
                    {
                        alliance = ((!(prismSubAreaInfo.alliance)) ? this.socialApi.getAlliance() : prismSubAreaInfo.alliance);
                        this.__showAllianceEmblem = true;
                        if (((((((!((this._currentAllianceEmblemBgShape == alliance.backEmblem.idEmblem))) || (!((this._currentAllianceEmblemBgColor == alliance.backEmblem.color))))) || (!((this._currentAllianceEmblemSymbolShape == alliance.upEmblem.idEmblem))))) || (!((this._currentAllianceEmblemSymbolColor == alliance.upEmblem.color)))))
                        {
                            this._currentAllianceEmblemBgShape = alliance.backEmblem.idEmblem;
                            this._currentAllianceEmblemBgColor = alliance.backEmblem.color;
                            this._currentAllianceEmblemSymbolShape = alliance.upEmblem.idEmblem;
                            this._currentAllianceEmblemSymbolColor = alliance.upEmblem.color;
                            this.lbl_AllianceName.text = (((alliance.allianceName + " [") + alliance.allianceTag) + "]");
                            this.tx_emblemBack.dispatchMessages = (this.tx_emblemUp.dispatchMessages = true);
                            this._allianceEmblemsLoaded = false;
                            this.tx_emblemBack.uri = uiApi.createUri((((sysApi.getConfigEntry("config.gfx.path.emblem_icons.large") + "backalliance/") + this._currentAllianceEmblemBgShape) + ".swf"));
                            this.tx_emblemUp.uri = uiApi.createUri((((sysApi.getConfigEntry("config.gfx.path.emblem_icons.large") + "up/") + this._currentAllianceEmblemSymbolShape) + ".swf"));
                        }
                        else
                        {
                            if (this._allianceEmblemsLoaded)
                            {
                                this.lbl_AllianceName.y = ((this.lblSubAreaInfo.textHeight + 10) + 6);
                                this.lbl_AllianceName.visible = true;
                                this.tx_emblemBack.visible = (this.tx_emblemUp.visible = true);
                            };
                        };
                    }
                    else
                    {
                        this.resetAllianceEmblem();
                    };
                }
                else
                {
                    this.resetAllianceEmblem();
                    this.updateMapAreaShape();
                };
            }
            else
            {
                this.resetAllianceEmblem();
                this.updateMapAreaShape();
            };
            if (((!(subarea)) && (!((this._lastSubAreaId == -1)))))
            {
                subAreaChanged = true;
                this._lastSubAreaId = -1;
            };
            this.lblSubAreaInfo.text = subAreaText;
            this.updateCtrSubAreaInfoBgSize();
            if (subAreaChanged)
            {
                this.onEnterFrame();
            };
        }

        public function onMapMove(map:Object):void
        {
            this.selectZoomButton();
        }

        private function onGuildInformationsFarms():void
        {
            var paddock:PaddockContentInformations;
            var mapElemList:Object = mapViewer.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf("guildPaddock_") == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            var farmsList:Object = this.socialApi.getGuildPaddocks();
            for each (paddock in farmsList)
            {
                if (this.dataApi.getSubArea(paddock.subAreaId).area.superAreaId == superAreaId)
                {
                    this.__hintCaptions[("guildPaddock_" + paddock.paddockId)] = uiApi.processText(uiApi.getText("ui.guild.paddock", paddock.maxOutdoorMount), "", (paddock.maxOutdoorMount == 1));
                    mapViewer.addIcon("layer_7", ("guildPaddock_" + paddock.paddockId), (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1002"), paddock.worldX, paddock.worldY, this.__iconScale);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.updateMap();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildPaddockAdd(paddockInfo:PaddockContentInformations):void
        {
            if (this.dataApi.getSubArea(paddockInfo.subAreaId).area.superAreaId == superAreaId)
            {
                this.__hintCaptions[("guildPaddock_" + paddockInfo.paddockId)] = uiApi.processText(uiApi.getText("ui.guild.paddock", paddockInfo.maxOutdoorMount), "", (paddockInfo.maxOutdoorMount == 1));
                mapViewer.addIcon("layer_7", ("guildPaddock_" + paddockInfo.paddockId), (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1002"), paddockInfo.worldX, paddockInfo.worldY, this.__iconScale);
                this.updateMap();
            };
        }

        private function onGuildPaddockRemoved(paddockId:uint):void
        {
            var mapElemList:Object = mapViewer.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildPaddock_" + paddockId)) == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.updateMap();
        }

        private function onGuildHousesUpdate():void
        {
            var house:GuildHouseWrapper;
            var housesList:Object = this.socialApi.getGuildHouses();
            var mapElemList:Object = mapViewer.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf("guildHouse_") == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            for each (house in housesList)
            {
                if (this.dataApi.getSubArea(house.subareaId).area.superAreaId == superAreaId)
                {
                    this.__hintCaptions[("guildHouse_" + house.houseId)] = ((uiApi.getText("ui.common.guildHouse") + uiApi.getText("ui.common.colon")) + house.houseName);
                    mapViewer.addIcon("layer_7", ("guildHouse_" + house.houseId), (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1001"), house.worldX, house.worldY, this.__iconScale);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.updateMap();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildHouseAdd(house:GuildHouseWrapper):void
        {
            if (this.dataApi.getSubArea(house.subareaId).area.superAreaId == superAreaId)
            {
                this.__hintCaptions[("guildHouse_" + house.houseId)] = ((uiApi.getText("ui.common.guildHouse") + uiApi.getText("ui.common.colon")) + house.houseName);
                mapViewer.addIcon("layer_7", ("guildHouse_" + house.houseId), (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1001"), house.worldX, house.worldY, this.__iconScale);
                this.updateMap();
            };
        }

        private function onGuildHouseRemoved(houseId:uint):void
        {
            var housesList:Object = this.socialApi.getGuildHouses();
            var mapElemList:Object = mapViewer.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildHouse_" + houseId)) == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.updateMap();
        }

        private function onTaxCollectorListUpdate():void
        {
            var taxCollector:TaxCollectorWrapper;
            var sh:Boolean = (sysApi.getCurrentServer().gameTypeId == 1);
            var mapElemList:Object = mapViewer.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf("guildPony_") == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            var taxCollectorsList:Object = this.socialApi.getTaxCollectors();
            for each (taxCollector in taxCollectorsList)
            {
                if (this.dataApi.getSubArea(taxCollector.subareaId).area.superAreaId == superAreaId)
                {
                    if (!(sh))
                    {
                        this.__hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorFullInformations", taxCollector.firstName, taxCollector.lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.kamas, taxCollector.pods, taxCollector.itemsValue, taxCollector.experience);
                    }
                    else
                    {
                        if (taxCollector.pods > 0)
                        {
                            this.__hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorHardcoreInformations.full", taxCollector.firstName, taxCollector.lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.pods, taxCollector.itemsValue);
                        }
                        else
                        {
                            this.__hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorHardcoreInformations.empty", taxCollector.firstName, taxCollector.lastName, taxCollector.additionalInformation.collectorCallerName);
                        };
                    };
                    mapViewer.addIcon("layer_7", ("guildPony_" + taxCollector.uniqueId), (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1003"), taxCollector.mapWorldX, taxCollector.mapWorldY, this.__iconScale);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.updateMap();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildTaxCollectorAdd(taxCollector:TaxCollectorWrapper):void
        {
            var firstName:String;
            var lastName:String;
            if (this.dataApi.getSubArea(taxCollector.subareaId).area.superAreaId == superAreaId)
            {
                firstName = taxCollector.firstName;
                lastName = taxCollector.lastName;
                this.__hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorFullInformations", firstName, lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.kamas, taxCollector.pods, taxCollector.itemsValue, taxCollector.experience);
                mapViewer.addIcon("layer_7", ("guildPony_" + taxCollector.uniqueId), (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1003"), taxCollector.mapWorldX, taxCollector.mapWorldY, this.__iconScale);
                this.updateMap();
            };
        }

        private function onGuildTaxCollectorRemoved(taxCollectorId:uint):void
        {
            var mapElemList:Object = mapViewer.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildPony_" + taxCollectorId)) == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.updateMap();
        }

        private function onRemoveMapFlag(flagId:String, worldMapId:int):void
        {
            if (flagId == "flag_playerPosition")
            {
                removeFlag(flagId);
            };
        }

        protected function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean):void
        {
            if (!(fromCartography))
            {
                this.__hintCategoryFiltersList[layerId] = displayed;
                mapViewer.showLayer(("layer_" + layerId), displayed);
                this.updateMap();
            };
        }

        protected function onPrismsListInformation(pPrismsInfo:Object):void
        {
            var i:int;
            var subArea:Object;
            var prismSubAreaInformation:PrismSubAreaWrapper;
            var prismList:Object = mapViewer.getMapElementsByLayer("layer_5");
            var nPrism:int = prismList.length;
            var p:int;
            while (p < nPrism)
            {
                mapViewer.removeMapElement(prismList[p]);
                p++;
            };
            this.__conquestSubAreasInfos = pPrismsInfo;
            for each (prismSubAreaInformation in pPrismsInfo)
            {
                this.updatePrismIcon(prismSubAreaInformation);
                if (!(this.__allAreas))
                {
                    this.updatePrismAndSubareaStatus(prismSubAreaInformation, false);
                };
            };
            this.__normalAreas = {
                "label":uiApi.getText("ui.prism.cartography.normal"),
                "children":[],
                "expend":false,
                "type":"areaShape",
                "layer":NORMAL_AREAS
            };
            this.__weakenedAreas = {
                "label":uiApi.getText("ui.prism.cartography.weakened"),
                "children":[],
                "expend":false,
                "type":"areaShape",
                "layer":WEAKENED_AREAS
            };
            this.__vulnerableAreas = {
                "label":uiApi.getText("ui.prism.cartography.vulnerable"),
                "children":[],
                "expend":false,
                "type":"areaShape",
                "layer":VULNERABLE_AREAS
            };
            this.__capturableAreas = {
                "label":uiApi.getText("ui.pvp.conquestCapturableAreas"),
                "children":[],
                "expend":false,
                "type":"areaShape",
                "layer":CAPTURABLE_AREAS
            };
            this.addSubAreasShapes();
            this.updateMap();
            if (this.__allAreas)
            {
                this.__allAreas = null;
            };
        }

        protected function onPrismsInfoUpdate(pPrismSubAreaIds:Object):void
        {
            var prismSubAreaInfo:PrismSubAreaWrapper;
            var subAreaId:int;
            for each (subAreaId in pPrismSubAreaIds)
            {
                prismSubAreaInfo = this.socialApi.getPrismSubAreaById(subAreaId);
                this.updatePrismIcon(prismSubAreaInfo);
                this.updatePrismAndSubareaStatus(prismSubAreaInfo);
            };
            this.updateMap();
        }

        public function onTextureReady(target:Object):void
        {
            var icon:EmblemSymbol;
            if (this.__showAllianceEmblem)
            {
                if (target == this.tx_emblemBack)
                {
                    this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"), this._currentAllianceEmblemBgColor, 1);
                }
                else
                {
                    if (target == this.tx_emblemUp)
                    {
                        icon = this.dataApi.getEmblemSymbol(this._currentAllianceEmblemSymbolShape);
                        if (icon.colorizable)
                        {
                            this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._currentAllianceEmblemSymbolColor, 0);
                        }
                        else
                        {
                            this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._currentAllianceEmblemSymbolColor, 0, true);
                        };
                    };
                };
                if (((!(this.tx_emblemBack.loading)) && (!(this.tx_emblemUp.loading))))
                {
                    this._allianceEmblemsLoaded = true;
                    this.lbl_AllianceName.fullWidth();
                    this.tx_emblemBack.x = ((this.lbl_AllianceName.x + this.lbl_AllianceName.width) + 8);
                    this.tx_emblemBack.y = (this.lblSubAreaInfo.textHeight + 10);
                    this.lbl_AllianceName.y = (this.tx_emblemBack.y + 6);
                    this.tx_emblemBack.addChild(this.tx_emblemUp);
                    this.updateCtrSubAreaInfoBgSize();
                    this.tx_emblemBack.visible = (this.tx_emblemUp.visible = (this.lbl_AllianceName.visible = true));
                };
            };
        }

        public function onComponentReadyMessage(target:Object):void
        {
            this.initMap();
        }

        private function restoreCurrentMapPreset():Boolean
        {
            var index:String;
            if (this._currentSubarea)
            {
                index = ("subarea_" + this._currentSubarea.id);
            }
            else
            {
                index = ("superarea_" + _currentSuperarea.id);
            };
            if (!(MAP_PRESET[index]))
            {
                return (false);
            };
            var mapPreset:MapPreset = MAP_PRESET[index];
            mapViewer.moveToPixel(mapPreset.mapPixelPosition.x, mapPreset.mapPixelPosition.y, mapPreset.zoomFactor);
            this.selectZoomButton();
            return (true);
        }

        private function resetAllianceEmblem():void
        {
            this._currentAllianceEmblemBgShape = -1;
            this._currentAllianceEmblemBgColor = -1;
            this._currentAllianceEmblemSymbolShape = -1;
            this._currentAllianceEmblemSymbolColor = -1;
        }

        protected function setupZoomButtons():void
        {
            var nbZooms:int = mapViewer.zoomLevels.length;
            var i:int = 1;
            while (i <= 5)
            {
                this[("btn_zoom" + i)].disabled = true;
                i++;
            };
            nbZooms = mapViewer.zoomLevels.length;
            i = 1;
            while (i <= nbZooms)
            {
                this[("btn_zoom" + i)].disabled = false;
                i++;
            };
        }

        protected function selectZoomButton():void
        {
            var btnIndex:int = (mapViewer.zoomLevels.indexOf(mapViewer.zoomFactor) + 1);
            if (btnIndex == 0)
            {
                sysApi.log(8, ((("Can't select zoom button, none match the current zoomFactor (" + mapViewer.zoomFactor) + ") of mapId ") + _currentWorldId));
                return;
            };
            uiApi.setRadioGroupSelectedItem("zoomGroup", this[("btn_zoom" + btnIndex)], uiApi.me());
        }

        private function isDungeonMap():Boolean
        {
            return (((((!((_currentWorldId == WORLD_OF_INCARNAM))) && (!((_currentWorldId == WORLD_OF_AMAKNA))))) && (!((_currentWorldId == FRIGOST_III)))));
        }

        private function updateCtrSubAreaInfoBgSize():void
        {
            var maxWidth:Number = this.lblSubAreaInfo.textWidth;
            if (((this.__showAllianceEmblem) && ((((2 + this.tx_emblemBack.width) + this.lbl_AllianceName.textWidth) > maxWidth))))
            {
                maxWidth = (((2 + this.tx_emblemBack.width) + this.lbl_AllianceName.textWidth) + 6);
            };
            this.ctrSubAreaInfoBg.width = (maxWidth + 10);
            this.ctrSubAreaInfoBg.height = (this.lblSubAreaInfo.textHeight + 10);
            if (this.__showAllianceEmblem)
            {
                this.ctrSubAreaInfoBg.height = (this.ctrSubAreaInfoBg.height + this.tx_emblemBack.height);
            };
        }

        protected function updateMap():void
        {
            mapViewer.updateMapElements();
        }

        protected function toggleHints():void
        {
            var layerId:String;
            var allLayersVisible:Boolean = !(mapViewer.allLayersVisible);
            for (layerId in this.__hintCategoryFiltersList)
            {
                this.__hintCategoryFiltersList[layerId] = allLayersVisible;
            };
            mapViewer.showAllLayers(allLayersVisible);
        }

        override protected function createContextMenu(contextMenu:Array=null):void
        {
            if (!(contextMenu))
            {
                contextMenu = new Array();
            };
            contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.map.toggleAllHints"), this.toggleHints));
            super.createContextMenu(contextMenu);
        }


    }
}//package ui

class MapPreset 
{

    public var mapPixelPosition:Object;
    public var zoomFactor:Number;

    public function MapPreset(mapPixelPosition:Object, zoomFactor:Number)
    {
        this.mapPixelPosition = mapPixelPosition;
        this.zoomFactor = zoomFactor;
    }

}

