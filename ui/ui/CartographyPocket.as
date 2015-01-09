package ui
{
    import d2api.CaptureApi;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Texture;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2enums.ComponentHookList;
    import d2hooks.MapsLoadingComplete;
    import d2actions.PrismsListRegister;
    import d2enums.PrismListenEnum;
    import d2actions.PlaySound;
    import d2actions.OpenMap;
    import d2hooks.MapHintsFilter;
    import d2data.WorldPoint;
    import d2actions.*;

    public class CartographyPocket extends CartographyBase 
    {

        private static const HINT_RES_NAMES:Array = ["map_btn_flags", "map_btn_possessions", "map_btn_temples", "map_btn_HDV", "map_btn_Ateliers", "map_btn_Autres", "map_btn_transport", "map_btn_Conquetes", "map_btn_Donjons"];
        private static const HINT_LAYOUT_INDEX:Array = ["layer_8", "layer_7", "layer_1", "layer_2", "layer_3", "layer_4", "layer_9", "layer_5", "layer_6"];
        private static const BANNER_HEIGHT:uint = 141;
        private static const TX_TITLE_MIN_HEIGHT:uint = 34;
        private static var HINT_TOOLTIP_TEXT:Array;
        private static var TX_TITLE_URI:Object;
        private static var TX_TITLE_MIN_URI:Object;
        private static var TX_TITLE_HEIGHT:uint;

        public var captureApi:CaptureApi;
        public var popCtr:GraphicContainer;
        public var subCtr:GraphicContainer;
        public var zoomCtr:GraphicContainer;
        public var btn_mainMap:ButtonContainer;
        public var tx_title:Texture;
        public var tx_bg:Texture;
        public var tx_bitmap:Texture;
        public var btn_hints:ButtonContainer;
        public var btn_options:ButtonContainer;
        public var tx_resizeHandle:Texture;
        public var tx_resizeShape:Texture;
        private var _inactiveAlpha:Number;
        private var _contextMenuIsActive:Boolean;
        private var _mouseIsOut:Boolean;
        private var _uiJustOpened:Boolean;
        private var _firstMouseOut:Boolean;
        private var _draggingUi:Boolean;
        private var _resizingUi:Boolean;
        private var _popCtrCurrentPosition:Point;
        private var _popCtrLastPosition:Point;
        private var _shadowColor:int;
        private var _waitBeforeRasterize:Boolean;
        private var _bounds:Rectangle;


        override public function main(params:Object=null):void
        {
            configApi.setConfigProperty("dofus", "lastMapUiWasPocket", true);
            mapViewer.gridLineThickness = 1;
            super.main(params);
            soundApi.playSound(SoundTypeEnum.POPUP_INFO);
            this.popCtr.width = (mapViewer.width + 50);
            this.popCtr.height = (mapViewer.height + 110);
            var position:Point = configApi.getConfigProperty("dofus", "cartographyPocketPosition");
            if (position)
            {
                this.popCtr.x = position.x;
                this.popCtr.y = position.y;
            };
            uiApi.addComponentHook(this.btn_hints, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_hints, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btn_options, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_options, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.btn_mainMap, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_mainMap, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.zoomCtr, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.zoomCtr, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_MOUSE_UP);
            uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_PRESS);
            uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_RELEASE_OUTSIDE);
            uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_DOUBLE_CLICK);
            uiApi.addComponentHook(this.tx_bitmap, ComponentHookList.ON_RELEASE_OUTSIDE);
            uiApi.addComponentHook(this.tx_bitmap, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.tx_resizeHandle, ComponentHookList.ON_PRESS);
            uiApi.addComponentHook(this.tx_resizeHandle, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.tx_resizeHandle, ComponentHookList.ON_RELEASE_OUTSIDE);
            uiApi.addComponentHook(this.tx_resizeHandle, ComponentHookList.ON_MOUSE_UP);
            uiApi.addComponentHook(this.tx_resizeHandle, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.tx_resizeHandle, ComponentHookList.ON_ROLL_OUT);
            sysApi.addHook(MapsLoadingComplete, this.onMapChanged);
            if (!(HINT_TOOLTIP_TEXT))
            {
                HINT_TOOLTIP_TEXT = [uiApi.getText("ui.cartography.flags"), uiApi.getText("ui.common.possessions"), uiApi.getText("ui.map.temple"), uiApi.getText("ui.map.bidHouse"), uiApi.getText("ui.map.craftHouse"), uiApi.getText("ui.common.misc"), uiApi.getText("ui.cartography.transport"), uiApi.getText("ui.map.conquest"), uiApi.getText("ui.map.dungeon")];
            };
            if (!(TX_TITLE_URI))
            {
                TX_TITLE_URI = this.tx_title.uri;
                TX_TITLE_MIN_URI = uiApi.createUri((uiApi.me().getConstant("assets") + "tx_title_small"));
                TX_TITLE_HEIGHT = this.tx_title.height;
            };
            this._inactiveAlpha = configApi.getConfigProperty("dofus", "cartographyPocketAlpha");
            this._contextMenuIsActive = false;
            this._uiJustOpened = true;
            this._firstMouseOut = false;
            this._draggingUi = false;
            this._popCtrCurrentPosition = new Point(this.popCtr.x, this.popCtr.y);
            this._popCtrLastPosition = this._popCtrCurrentPosition.clone();
            this._shadowColor = this.subCtr.shadowColor;
            this._waitBeforeRasterize = false;
            uiApi.setComponentMinMaxSize(this.tx_resizeShape, new Point(240, 240), new Point((uiApi.getStageWidth() + 2), (uiApi.getStageHeight() - BANNER_HEIGHT)));
            var savedSize:Point = configApi.getConfigProperty("dofus", "cartographyPocketSize");
            if (savedSize)
            {
                this.tx_resizeShape.width = savedSize.x;
                this.tx_resizeShape.height = savedSize.y;
                this.updateComponentPosition();
            };
            mapViewer.setupZoomLevels(1190, 690);
            setupZoomButtons();
            selectZoomButton();
        }

        override protected function initMap():void
        {
            super.initMap();
            if (!(__conquestSubAreasInfos))
            {
                if (modCartography.showConquestInformation())
                {
                    sysApi.sendAction(new PrismsListRegister("Cartography", PrismListenEnum.PRISM_LISTEN_ALL));
                };
            };
        }

        override protected function addCustomFlagWithRightClick(pX:Number, pY:Number):void
        {
            if (!(__hintCategoryFiltersList[8]))
            {
                this.onFilterHintClick("layer_8", 8, true);
            };
            super.addCustomFlagWithRightClick(pX, pY);
        }

        override protected function createContextMenu(contextMenu:Array=null):void
        {
            modContextMenu.closeAllMenu();
            this._contextMenuIsActive = true;
            contextMenu = new Array();
            contextMenu.push(modContextMenu.createContextMenuSeparatorObject());
            var opacityMenu:Array = [modContextMenu.createContextMenuItemObject("0%", this.onOpacityChanged, [0], false, null, (this._inactiveAlpha == 0)), modContextMenu.createContextMenuItemObject("25%", this.onOpacityChanged, [0.25], false, null, (this._inactiveAlpha == 0.25)), modContextMenu.createContextMenuItemObject("50%", this.onOpacityChanged, [0.5], false, null, (this._inactiveAlpha == 0.5)), modContextMenu.createContextMenuItemObject("75%", this.onOpacityChanged, [0.75], false, null, (this._inactiveAlpha == 0.75)), modContextMenu.createContextMenuItemObject("100%", this.onOpacityChanged, [1], false, null, (this._inactiveAlpha == 1))];
            contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.cartography.opacitymenu"), null, null, false, opacityMenu));
            super.createContextMenu(contextMenu);
        }

        override public function addFlag(flagId:String, flagLegend:String, x:int, y:int, color:int=-1, playSound:Boolean=true, needMapUpdate:Boolean=true, canBeManuallyRemoved:Boolean=true):void
        {
            var uri:String;
            if (playSound)
            {
                sysApi.sendAction(new PlaySound("16039"));
            };
            switch (flagId)
            {
                case "Phoenix":
                    uri = (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|point1");
                    break;
                default:
                    uri = (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|point0");
            };
            var flag:Object = mapViewer.addIcon("layer_8", flagId, uri, x, y, __iconScale, flagLegend, true, color, true, canBeManuallyRemoved);
            if (flag)
            {
                if (needMapUpdate)
                {
                    this.updateMap();
                };
            };
        }

        override protected function updateMap():void
        {
            super.updateMap();
            if (((this.tx_bitmap.visible) && (!(this._draggingUi))))
            {
                this.rasterize();
            };
        }

        override public function onEnterFrame():void
        {
            super.onEnterFrame();
            if (this._draggingUi)
            {
                return;
            };
            if (this._resizingUi)
            {
                this.tx_resizeHandle.x = (this.tx_resizeShape.width - 3);
                this.tx_resizeHandle.y = (this.tx_resizeShape.height - 32);
                return;
            };
            if (ctrSubAreaInfo.visible)
            {
                ctrSubAreaInfo.x = (ctrSubAreaInfo.x - this.popCtr.x);
                ctrSubAreaInfo.y = (ctrSubAreaInfo.y - this.popCtr.y);
                if ((uiApi.getMouseX() + ctrSubAreaInfoBg.width) > ((this.popCtr.x + mapViewer.width) - mapViewer.roundCornerRadius))
                {
                    ctrSubAreaInfo.x = (ctrSubAreaInfo.x - ((ctrSubAreaInfoBg.width + mapViewer.roundCornerRadius) + 20));
                };
                if ((uiApi.getMouseY() + ctrSubAreaInfoBg.height) > ((this.popCtr.y + mapViewer.y) + mapViewer.height))
                {
                    ctrSubAreaInfo.y = (ctrSubAreaInfo.y - ctrSubAreaInfoBg.height);
                };
            };
            this._mouseIsOut = !(this.getBounds().contains(uiApi.getMouseX(), uiApi.getMouseY()));
            if (this._uiJustOpened)
            {
                if (!(this._mouseIsOut))
                {
                    this._firstMouseOut = true;
                }
                else
                {
                    if (this._firstMouseOut)
                    {
                        this._uiJustOpened = false;
                    };
                };
                return;
            };
            if (((this._waitBeforeRasterize) && (mapViewer.allChunksLoaded)))
            {
                if (this._mouseIsOut)
                {
                    this.rasterize();
                };
                this._waitBeforeRasterize = false;
            };
            this._popCtrCurrentPosition.x = int(this.popCtr.x);
            this._popCtrCurrentPosition.y = int(this.popCtr.y);
            if (((!(this._popCtrCurrentPosition.equals(this._popCtrLastPosition))) && (!(this.tx_bitmap.visible))))
            {
                this._draggingUi = true;
                modContextMenu.closeAllMenu();
                this.rasterize(1);
                return;
            };
            if (((!(this._contextMenuIsActive)) && (!(mapViewer.isDragging))))
            {
                if (((!(this.tx_bitmap.visible)) && (this._mouseIsOut)))
                {
                    this.rasterize();
                }
                else
                {
                    if (((this.tx_bitmap.visible) && (!(this._mouseIsOut))))
                    {
                        this.hideBitmap();
                    };
                };
            };
        }

        override public function onPress(target:Object):void
        {
            super.onPress(target);
            switch (target)
            {
                case this.tx_title:
                    this._popCtrLastPosition.x = int(this.popCtr.x);
                    this._popCtrLastPosition.y = int(this.popCtr.y);
                    this.popCtr.startDrag();
                    break;
                case this.tx_resizeHandle:
                    this.tx_resizeShape.visible = true;
                    this.subCtr.visible = false;
                    this._resizingUi = true;
                    this.tx_resizeShape.startResize();
                    break;
            };
        }

        public function onMouseUp(target:Object):void
        {
            switch (target)
            {
                case this.tx_title:
                    this.stopDragUi();
                    break;
                case this.tx_resizeHandle:
                    this.stopResizeUi();
                    break;
            };
        }

        public function onReleaseOutside(target:Object):void
        {
            super.onPress(target);
            switch (target)
            {
                case this.tx_title:
                case this.tx_bitmap:
                    this.stopDragUi();
                    break;
                case this.tx_resizeHandle:
                    this.stopResizeUi();
                    break;
            };
        }

        override public function onRelease(target:Object):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:Array;
            var i:int;
            var layerName:String;
            var layerId:int;
            var hintIsSelected:Boolean;
            super.onRelease(target);
            switch (target)
            {
                case this.tx_resizeHandle:
                    this.stopResizeUi();
                    break;
                case btn_close:
                    uiApi.unloadUi(uiApi.me().name);
                    break;
                case this.tx_title:
                case this.tx_bitmap:
                    this.stopDragUi();
                    break;
                case this.btn_mainMap:
                    sysApi.sendAction(new OpenMap(true, false));
                    uiApi.unloadUi(uiApi.me().name);
                    break;
                case btn_player:
                    if (!(__hintCategoryFiltersList[8]))
                    {
                        this.onFilterHintClick("layer_8", 8, true);
                    };
                    break;
                case this.btn_hints:
                    _local_2 = new Array();
                    _local_3 = uiApi.me().getConstant("assets");
                    i = 0;
                    while (i < 9)
                    {
                        layerName = HINT_LAYOUT_INDEX[i];
                        layerId = int(layerName.split("_")[1]);
                        hintIsSelected = (__hintCategoryFiltersList[layerId] > 0);
                        _local_2.push(modContextMenu.createContextMenuPictureItemObject(((_local_3 + HINT_RES_NAMES[i]) + "?5"), this.onFilterHintClick, [layerName, layerId], false, null, hintIsSelected, false, HINT_TOOLTIP_TEXT[i], false, 200));
                        i++;
                    };
                    modContextMenu.createContextMenu(_local_2, new Point((((this.popCtr.x + this.btn_hints.x) + this.btn_hints.width) + 4), (this.popCtr.y + this.btn_hints.y)));
                    break;
                case this.btn_options:
                    _local_2 = new Array();
                    _local_4 = [modContextMenu.createContextMenuItemObject("0%", this.onOpacityChanged, [0], false, null, (this._inactiveAlpha == 0)), modContextMenu.createContextMenuItemObject("25%", this.onOpacityChanged, [0.25], false, null, (this._inactiveAlpha == 0.25)), modContextMenu.createContextMenuItemObject("50%", this.onOpacityChanged, [0.5], false, null, (this._inactiveAlpha == 0.5)), modContextMenu.createContextMenuItemObject("75%", this.onOpacityChanged, [0.75], false, null, (this._inactiveAlpha == 0.75)), modContextMenu.createContextMenuItemObject("100%", this.onOpacityChanged, [1], false, null, (this._inactiveAlpha == 1))];
                    _local_2.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.cartography.opacitymenu"), null, null, false, _local_4));
                    modContextMenu.createContextMenu(_local_2, new Point((((this.popCtr.x + this.btn_options.x) + this.btn_options.width) + 4), (this.popCtr.y + this.btn_options.y)));
                    break;
            };
        }

        override public function onDoubleClick(target:Object):void
        {
            var mapIsVisible:Boolean;
            super.onDoubleClick(target);
            switch (target)
            {
                case this.tx_title:
                    if (this.subCtr.visible)
                    {
                        mapViewer.visible = !(mapViewer.visible);
                        mapIsVisible = mapViewer.visible;
                        this.tx_resizeHandle.visible = mapIsVisible;
                        this.zoomCtr.visible = mapIsVisible;
                        this.tx_bg.visible = mapIsVisible;
                        ctrSubAreaInfo.visible = mapIsVisible;
                        btn_flag.disabled = !(mapIsVisible);
                        btn_grid.disabled = !(mapIsVisible);
                        btn_player.disabled = !(mapIsVisible);
                        this.btn_hints.disabled = !(mapIsVisible);
                        this.btn_options.disabled = !(mapIsVisible);
                        this.tx_title.height = ((mapIsVisible) ? TX_TITLE_HEIGHT : TX_TITLE_MIN_HEIGHT);
                        this.tx_title.uri = ((mapIsVisible) ? TX_TITLE_URI : TX_TITLE_MIN_URI);
                        this.tx_bitmap.height = ((mapIsVisible) ? this.tx_resizeShape.height : TX_TITLE_MIN_HEIGHT);
                    };
                    this.stopDragUi();
                    break;
            };
        }

        override public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            super.onRollOver(target);
            var point:uint = 7;
            var relPoint:uint = 1;
            var offset:int = 3;
            switch (target)
            {
                case this.btn_hints:
                    tooltipText = uiApi.getText("ui.cartography.filtermaphints");
                    break;
                case this.btn_options:
                    tooltipText = uiApi.getText("ui.common.options");
                    break;
                case this.btn_mainMap:
                    tooltipText = uiApi.getText("ui.cartography.openworldmap");
                    break;
                case this.zoomCtr:
                    tooltipText = uiApi.getText("ui.common.zoom");
                    break;
                case this.tx_resizeHandle:
                    tooltipText = uiApi.getText("ui.common.resizeui");
                    offset = 28;
                    break;
            };
            if (tooltipText)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, offset, null, null, null, "TextInfo");
            };
        }

        override public function onMapMove(map:Object):void
        {
            super.onMapMove(map);
            this._waitBeforeRasterize = true;
        }

        override public function onCloseUi(pShortCut:String):Boolean
        {
            return (false);
        }

        override public function onTextureReady(target:Object):void
        {
            super.onTextureReady(target);
            if (((((__showAllianceEmblem) && (!(tx_emblemBack.loading)))) && (!(tx_emblemUp.loading))))
            {
                tx_emblemUp.x = ((tx_emblemBack.width - tx_emblemUp.width) / 2);
                tx_emblemUp.y = ((tx_emblemBack.height - tx_emblemUp.height) / 2);
            };
        }

        override protected function onContextMenuClose():void
        {
            this._contextMenuIsActive = false;
            if (((!(this.tx_bitmap.visible)) && (this._mouseIsOut)))
            {
                this.rasterize();
            };
        }

        override protected function onFlagRemoved(pFlagId:String, pWorldMapId:int):void
        {
            super.onFlagRemoved(pFlagId, pWorldMapId);
            this._waitBeforeRasterize = true;
        }

        private function onFilterHintClick(layerName:String, layerId:int, forceSelection:Boolean=false):void
        {
            var contextMenuItems:Array;
            var item:*;
            var itemIsSelected:Boolean = forceSelection;
            if (!(forceSelection))
            {
                contextMenuItems = uiApi.getUi("Ankama_ContextMenu").uiClass.items;
                for each (item in contextMenuItems)
                {
                    if (((item.callbackArgs) && ((item.callbackArgs[0] == layerName))))
                    {
                        itemIsSelected = !(item.selected);
                        break;
                    };
                };
            };
            __hintCategoryFiltersList[layerId] = itemIsSelected;
            if (__layersToShow[layerName])
            {
                mapViewer.showLayer(layerName, itemIsSelected);
                this.updateMap();
            };
            sysApi.dispatchHook(MapHintsFilter, layerId, itemIsSelected, true);
        }

        private function onMapChanged(map:WorldPoint):void
        {
            var mapVisible:Boolean;
            var subArea:Object = playerApi.currentSubArea();
            var worldId:uint = ((((!((subArea == null))) && ((subArea.customWorldMap.length > 0)))) ? subArea.customWorldMap[0] : map.worldId);
            if (worldId != _currentWorldId)
            {
                this.hideBitmap();
                mapVisible = mapViewer.visible;
                if (!(subArea.hasCustomWorldMap))
                {
                    openNewMap(subArea.area.superArea.worldmap, MAP_TYPE_SUPERAREA, subArea.area.superArea);
                }
                else
                {
                    openNewMap(subArea.worldmap, MAP_TYPE_SUBAREA, subArea);
                };
                mapViewer.visible = mapVisible;
                this._waitBeforeRasterize = true;
            };
            __playerPos = playerApi.currentMap();
            removeFlag("flag_playerPosition");
            this.addFlag("flag_playerPosition", uiApi.getText("ui.cartography.yourposition"), __playerPos.outdoorX, __playerPos.outdoorY, 39423);
            mapViewer.moveTo(__playerPos.outdoorX, __playerPos.outdoorY);
            if (((this.tx_bitmap.visible) && (this._mouseIsOut)))
            {
                this.rasterize();
            };
        }

        private function onOpacityChanged(alpha:Number):void
        {
            this._inactiveAlpha = alpha;
            configApi.setConfigProperty("dofus", "cartographyPocketAlpha", this._inactiveAlpha);
        }

        private function rasterize(alpha:Number=0):void
        {
            this.subCtr.visible = true;
            this.subCtr.shadowColor = -1;
            mapViewer.showLayer(NO_PRISM_AREAS, false);
            mapViewer.showLayer(NORMAL_AREAS, false);
            mapViewer.showLayer(WEAKENED_AREAS, false);
            mapViewer.showLayer(VULNERABLE_AREAS, false);
            mapViewer.showLayer(VILLAGES_AREAS, false);
            mapViewer.showLayer(CAPTURABLE_AREAS, false);
            mapViewer.mapAlpha = ((alpha) ? alpha : this._inactiveAlpha);
            ctrSubAreaInfo.visible = false;
            if (this._contextMenuIsActive)
            {
                modContextMenu.closeAllMenu();
            };
            this.tx_bitmap.loadBitmapData(this.captureApi.getFromTarget(this.subCtr, new Rectangle(0, 0, this.tx_bitmap.width, this.tx_bitmap.height), 1, true));
            this.tx_bitmap.visible = true;
            this.subCtr.visible = false;
            this.subCtr.shadowColor = this._shadowColor;
            mapViewer.showLayer(NO_PRISM_AREAS, true);
            mapViewer.showLayer(NORMAL_AREAS, true);
            mapViewer.showLayer(WEAKENED_AREAS, true);
            mapViewer.showLayer(VULNERABLE_AREAS, true);
            mapViewer.showLayer(VILLAGES_AREAS, true);
            mapViewer.showLayer(CAPTURABLE_AREAS, true);
            mapViewer.mapAlpha = 1;
        }

        private function hideBitmap():void
        {
            this.tx_bitmap.visible = false;
            this.subCtr.visible = true;
        }

        private function stopDragUi():void
        {
            this._draggingUi = false;
            this.popCtr.stopDrag();
            this.forceUiWithinScreenBounds();
        }

        private function stopResizeUi():void
        {
            if (this._resizingUi)
            {
                this._resizingUi = false;
                this.tx_resizeShape.endResize();
                this.tx_resizeShape.visible = false;
                this.subCtr.visible = true;
                this._waitBeforeRasterize = true;
                this.updateComponentPosition();
                configApi.setConfigProperty("dofus", "cartographyPocketSize", new Point(this.tx_resizeShape.width, this.tx_resizeShape.height));
                this.forceUiWithinScreenBounds();
            };
        }

        private function updateComponentPosition():void
        {
            var mapRect:Object = mapViewer.visibleMaps;
            mapViewer.setSize((this.tx_resizeShape.width - 2), (this.tx_resizeShape.height - 35));
            this.tx_title.width = (this.tx_resizeShape.width + 1);
            this.tx_bitmap.width = this.tx_resizeShape.width;
            this.tx_bitmap.height = (this.tx_resizeShape.height + 1);
            this.tx_bg.width = (this.tx_resizeShape.width - 3);
            this.tx_bg.height = (this.tx_resizeShape.height - TX_TITLE_MIN_HEIGHT);
            this.tx_bg.bgColor = this.tx_bg.bgColor;
            this.tx_resizeHandle.x = (this.tx_resizeShape.width - 31);
            this.tx_resizeHandle.y = (this.tx_resizeShape.height - 1);
            btn_close.x = ((this.tx_title.width - btn_close.width) - 12);
            this.btn_mainMap.x = ((btn_close.x - this.btn_mainMap.width) - 7);
            this.zoomCtr.x = (this.tx_resizeShape.width - 90);
            var mapRect2:Object = mapViewer.visibleMaps;
            var newX:Number = mapRect.x;
            var newY:Number = mapRect.y;
            var needMapMove:Boolean;
            if ((mapViewer.mapContainerBounds.width + mapViewer.mapContainerBounds.x) < this.tx_resizeShape.width)
            {
                newX = ((mapRect.x + mapRect.width) - mapRect2.width);
                needMapMove = true;
            };
            if ((mapViewer.mapContainerBounds.height + mapViewer.mapContainerBounds.y) < this.tx_resizeShape.height)
            {
                newY = ((mapRect.y + mapRect.height) - mapRect2.height);
                needMapMove = true;
            };
            if (needMapMove)
            {
                mapViewer.moveTo((newX - 1), (newY - 1), 1, 1, false, false);
            };
        }

        private function forceUiWithinScreenBounds():void
        {
            var stageWidth:int = uiApi.getStageWidth();
            var stageHeight:int = (uiApi.getStageHeight() - BANNER_HEIGHT);
            if ((this.popCtr.x + (this.tx_bitmap.width * 0.6)) < 0)
            {
                this.popCtr.x = 0;
            }
            else
            {
                if ((this.popCtr.x + (this.tx_bitmap.width * 0.4)) > stageWidth)
                {
                    this.popCtr.x = (stageWidth - this.tx_bitmap.width);
                };
            };
            if (this.popCtr.y < 0)
            {
                this.popCtr.y = 0;
            }
            else
            {
                if (this.popCtr.y > (stageHeight - this.tx_bitmap.height))
                {
                    this.popCtr.y = (stageHeight - this.tx_bitmap.height);
                };
            };
            this._popCtrLastPosition.x = int(this.popCtr.x);
            this._popCtrLastPosition.y = int(this.popCtr.y);
            configApi.setConfigProperty("dofus", "cartographyPocketPosition", this._popCtrLastPosition);
        }

        private function getBounds():Rectangle
        {
            if (!(this._bounds))
            {
                this._bounds = new Rectangle(this.popCtr.x, this.popCtr.y, this.tx_title.width, this.tx_bitmap.height);
            }
            else
            {
                this._bounds.x = this.popCtr.x;
                this._bounds.y = this.popCtr.y;
                this._bounds.width = this.tx_title.width;
                this._bounds.height = ((mapViewer.visible) ? this.tx_bitmap.height : this.tx_title.height);
            };
            return (this._bounds);
        }


    }
}//package ui

