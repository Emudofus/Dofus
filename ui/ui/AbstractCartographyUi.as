package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.MapApi;
    import d2api.ContextMenuApi;
    import d2components.MapViewer;
    import d2hooks.FlagRemoved;
    import d2enums.ShortcutHookListEnum;
    import ui.type.Flag;
    import d2hooks.AddMapFlag;
    import d2hooks.RemoveAllFlags;

    public class AbstractCartographyUi 
    {

        private static const MAX_CUSTOM_FLAGS:int = 6;
        protected static var _nbCustomFlags:Array = new Array();

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var mapApi:MapApi;
        public var menuApi:ContextMenuApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Cartography")]
        public var modCartography:Object;
        public var mapViewer:MapViewer;
        protected var _currentSuperarea:Object;
        protected var _currentWorldId:int;


        public function main(params:Object=null):void
        {
            this.sysApi.addHook(FlagRemoved, this.onFlagRemoved);
            this.uiApi.addComponentHook(this.mapViewer, "onRightClick");
            this.uiApi.addComponentHook(this.mapViewer, "onMapElementRightClick");
            this.uiApi.addComponentHook(this.mapViewer, "onMapElementRollOut");
            this.uiApi.addComponentHook(this.mapViewer, "onDoubleClick");
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onCloseUi);
        }

        public function get superAreaId():int
        {
            return (this._currentSuperarea.id);
        }

        public function get currentWorldId():int
        {
            return (this._currentWorldId);
        }

        public function unload():void
        {
        }

        protected function addCustomFlag(pX:int, pY:int):void
        {
            var flag:Flag;
            var flagExists:Boolean;
            this.mapViewer.enabledDrag = true;
            this.mapViewer.useFlagCursor = false;
            var flagId:String = ((("flag_custom_" + pX) + "_") + pY);
            var flags:Array = this.modCartography.getFlags(this._currentWorldId);
            for each (flag in flags)
            {
                if (flag.id == flagId)
                {
                    flagExists = true;
                    break;
                };
            };
            if (!(flagExists))
            {
                if (!(_nbCustomFlags[this._currentWorldId]))
                {
                    _nbCustomFlags[this._currentWorldId] = 1;
                }
                else
                {
                    if (_nbCustomFlags[this._currentWorldId] < MAX_CUSTOM_FLAGS)
                    {
                        var _local_7 = _nbCustomFlags;
                        var _local_8 = this._currentWorldId;
                        var _local_9 = (_local_7[_local_8] + 1);
                        _local_7[_local_8] = _local_9;
                    }
                    else
                    {
                        return;
                    };
                };
            };
            this.sysApi.dispatchHook(AddMapFlag, flagId, (((((this.uiApi.getText("ui.cartography.customFlag") + " (") + pX) + ",") + pY) + ")"), this._currentWorldId, pX, pY, 0xFFDD00);
        }

        protected function addCustomFlagWithRightClick(pX:Number, pY:Number):void
        {
            this.mapViewer.enabledDrag = false;
            this.addCustomFlag(pX, pY);
        }

        protected function createContextMenu(contextMenu:Array=null):void
        {
            if (!(contextMenu))
            {
                contextMenu = new Array();
            };
            contextMenu.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.map.removeAllFlags"), this.removeAllFlags, []));
            contextMenu.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.map.flag"), this.addCustomFlagWithRightClick, [this.mapViewer.currentMouseMapX, this.mapViewer.currentMouseMapY], ((_nbCustomFlags[this._currentWorldId]) && ((_nbCustomFlags[this._currentWorldId] >= MAX_CUSTOM_FLAGS)))));
            this.modContextMenu.createContextMenu(contextMenu, null, this.onContextMenuClose);
        }

        public function removeFlag(flagId:String):void
        {
            var flag:Object = this.mapViewer.getMapElement(flagId);
            if (flag)
            {
                this.mapViewer.removeMapElement(flag);
            };
        }

        private function removeAllFlags():void
        {
            this.sysApi.dispatchHook(RemoveAllFlags);
        }

        protected function onFlagRemoved(pFlagId:String, pWorldMapId:int):void
        {
            if (((((!((pFlagId.indexOf("flag_custom") == -1))) && (_nbCustomFlags[pWorldMapId]))) && ((_nbCustomFlags[pWorldMapId] > 0))))
            {
                var _local_3 = _nbCustomFlags;
                var _local_4 = pWorldMapId;
                var _local_5 = (_local_3[_local_4] - 1);
                _local_3[_local_4] = _local_5;
            };
        }

        public function onCloseUi(pShortCut:String):Boolean
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return (true);
        }

        public function onDoubleClick(target:Object):void
        {
            switch (target)
            {
                case this.mapViewer:
                    if (this.sysApi.hasRight())
                    {
                        this.mapApi.movePlayer(this.mapViewer.currentMouseMapX, this.mapViewer.currentMouseMapY);
                        if (!(this.uiApi.getUi("cartographyPocket")))
                        {
                            this.uiApi.unloadUi(this.uiApi.me().name);
                        };
                    };
                    break;
            };
        }

        public function onRightClick(pTarget:Object):void
        {
            if (pTarget == this.mapViewer)
            {
                this.createContextMenu();
            };
        }

        public function onMapElementRightClick(pMap:Object, pTarget:Object):void
        {
            var contextMenu:Object;
            if (pTarget.id.indexOf("flag_playerPosition") != -1)
            {
                return;
            };
            contextMenu = this.menuApi.create(pTarget, "mapFlag", [this._currentWorldId]);
            if (contextMenu.content.length > 0)
            {
                this.modContextMenu.createContextMenu(contextMenu);
            };
        }

        public function onMapElementRollOut(pMap:Object, pTarget:Object):void
        {
            this.uiApi.hideTooltip();
        }

        protected function onContextMenuClose():void
        {
        }


    }
}//package ui

