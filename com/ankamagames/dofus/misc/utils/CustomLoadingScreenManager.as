package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class CustomLoadingScreenManager extends Object
    {
        private var _dataStore:DataStoreType;
        private var _loader:IResourceLoader;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomLoadingScreenManager));
        private static var _singleton:CustomLoadingScreenManager;

        public function CustomLoadingScreenManager()
        {
            this._dataStore = new DataStoreType("LoadingScreen", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            return;
        }// end function

        public function get currentLoadingScreen() : CustomLoadingScreen
        {
            var _loc_1:* = StoreDataManager.getInstance().getData(this._dataStore, "currentLoadingScreen") as String;
            var _loc_2:* = CustomLoadingScreen.recover(this._dataStore, _loc_1);
            var _loc_3:* = XmlConfig.getInstance().getEntry("config.lang.current");
            if (_loc_2 && !_loc_2.canBeRead())
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
                _loc_2 = null;
            }
            if (_loc_2 && _loc_2.lang != _loc_3)
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
                _loc_2 = null;
            }
            return _loc_2;
        }// end function

        public function get dataStore() : DataStoreType
        {
            return this._dataStore;
        }// end function

        public function set currentLoadingScreen(param1:CustomLoadingScreen) : void
        {
            if (param1)
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", param1.name);
            }
            else
            {
                StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
            }
            return;
        }// end function

        public function loadCustomScreenList() : void
        {
            var _loc_2:Uri = null;
            var _loc_1:* = XmlConfig.getInstance().getEntry("config.lang.current");
            _loc_2 = new Uri(XmlConfig.getInstance().getEntry("config.customLoadingScreen") + "loadingScreen_" + _loc_1 + ".xml");
            this._loader.load(_loc_2);
            return;
        }// end function

        private function onLoad(event:ResourceLoadedEvent) : void
        {
            var selected:CustomLoadingScreen;
            var xml:XML;
            var screens:Array;
            var loadingScreenXml:XML;
            var oldLoadingScreen:CustomLoadingScreen;
            var loadingScreen:CustomLoadingScreen;
            var e:* = event;
            if (e.resourceType == ResourceType.RESOURCE_XML)
            {
                selected;
                try
                {
                    xml = e.resource;
                    if (!xml)
                    {
                        return;
                    }
                    screens = new Array();
                    var _loc_3:int = 0;
                    var _loc_4:* = xml..loadingScreen;
                    while (_loc_4 in _loc_3)
                    {
                        
                        loadingScreenXml = _loc_4[_loc_3];
                        oldLoadingScreen = CustomLoadingScreen.recover(this._dataStore, loadingScreenXml.@name);
                        loadingScreen = CustomLoadingScreen.loadFromXml(loadingScreenXml);
                        loadingScreen.dataStore = this._dataStore;
                        if (oldLoadingScreen)
                        {
                            loadingScreen.count = oldLoadingScreen.count;
                        }
                        if (!oldLoadingScreen || loadingScreen.backgroundUrl != oldLoadingScreen.backgroundUrl || !oldLoadingScreen.backgroundImg || loadingScreen.foregroundUrl != oldLoadingScreen.foregroundUrl || oldLoadingScreen.foregroundUrl && !oldLoadingScreen.foregroundImg)
                        {
                            loadingScreen.loadData();
                        }
                        else
                        {
                            loadingScreen.backgroundImg = oldLoadingScreen.backgroundImg;
                            loadingScreen.foregroundImg = oldLoadingScreen.foregroundImg;
                            loadingScreen.store();
                        }
                        if (!selected && loadingScreen.canBeRead())
                        {
                            selected = loadingScreen;
                        }
                    }
                }
                catch (e:Error)
                {
                    _log.error("Can\'t load loading screen XML : " + e);
                    return;
                }
                if (selected)
                {
                    this.currentLoadingScreen = selected;
                }
            }
            else
            {
                _log.error("Invalid XML");
            }
            return;
        }// end function

        private function onLoadError(event:ResourceErrorEvent) : void
        {
            _log.error("Can\'t load XML file : " + event);
            StoreDataManager.getInstance().setData(this._dataStore, "currentLoadingScreen", null);
            return;
        }// end function

        public static function getInstance() : CustomLoadingScreenManager
        {
            if (!_singleton)
            {
                _singleton = new CustomLoadingScreenManager;
            }
            return _singleton;
        }// end function

    }
}
