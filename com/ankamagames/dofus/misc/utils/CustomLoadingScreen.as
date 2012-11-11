package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class CustomLoadingScreen extends Object
    {
        public var name:String;
        public var backgroundImg:ByteArray;
        public var foregroundImg:ByteArray;
        public var backgroundUrl:String;
        public var foregroundUrl:String;
        public var linkUrl:String;
        public var begin:Date;
        public var end:Date;
        public var countMax:int = 0;
        public var count:int;
        public var screen:int = 1;
        public var lang:String;
        private var _backgroundUrlLoader:URLLoader;
        private var _foregroundUrlLoader:URLLoader;
        public var dataStore:DataStoreType;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomLoadingScreen));

        public function CustomLoadingScreen()
        {
            return;
        }// end function

        public function loadData() : void
        {
            if (this.backgroundUrl)
            {
                this._backgroundUrlLoader = new URLLoader();
                this._backgroundUrlLoader.addEventListener(Event.COMPLETE, this.onComplete);
                this._backgroundUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                this._backgroundUrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
                _log.info("load custom background : " + this.backgroundUrl);
                this._backgroundUrlLoader.load(new URLRequest(this.backgroundUrl));
            }
            if (this.foregroundUrl)
            {
                this._foregroundUrlLoader = new URLLoader();
                this._foregroundUrlLoader.addEventListener(Event.COMPLETE, this.onComplete);
                this._foregroundUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                this._foregroundUrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
                _log.info("load custom foreground : " + this.foregroundUrl);
                this._foregroundUrlLoader.load(new URLRequest(this.foregroundUrl));
            }
            return;
        }// end function

        public function store(param1:Boolean = false) : void
        {
            if (this.dataStore)
            {
                StoreDataManager.getInstance().setData(this.dataStore, "loading_" + this.name, this);
                if (param1)
                {
                    StoreDataManager.getInstance().setData(this.dataStore, "currentLoadingScreen", this.name);
                }
            }
            else
            {
                _log.error("Can\'t store loading screen without dataStore");
            }
            return;
        }// end function

        public function isViewing() : void
        {
            if (this.count < this.countMax)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.count + 1;
                _loc_1.count = _loc_2;
                this.store();
            }
            return;
        }// end function

        public function canBeRead() : Boolean
        {
            var _loc_1:* = new Date();
            if ((!this.begin || this.begin.time < _loc_1.time) && (!this.end || this.end.time > _loc_1.time) && (this.countMax == -1 || this.countMax == 0 || this.count < this.countMax))
            {
                return true;
            }
            return false;
        }// end function

        public function canBeReadOnScreen(param1:Boolean) : Boolean
        {
            return this.canBeRead() && (this.screen == 3 || param1 && this.screen == 1 || !param1 && this.screen == 2);
        }// end function

        private function onComplete(event:Event) : void
        {
            var _loc_2:* = event.target as URLLoader;
            _loc_2.removeEventListener(Event.COMPLETE, this.onComplete);
            switch(event.target)
            {
                case this._backgroundUrlLoader:
                {
                    this.backgroundImg = _loc_2.data;
                    this.store();
                    break;
                }
                case this._foregroundUrlLoader:
                {
                    this.foregroundImg = _loc_2.data;
                    this.store();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onIOError(event:IOErrorEvent) : void
        {
            _log.error("invalid bitmap : " + event);
            return;
        }// end function

        public static function recover(param1:DataStoreType, param2:String) : CustomLoadingScreen
        {
            return StoreDataManager.getInstance().getData(param1, "loading_" + param2);
        }// end function

        public static function loadFromXml(param1:XML) : CustomLoadingScreen
        {
            var _loc_2:* = new CustomLoadingScreen;
            _loc_2.name = param1.@name;
            if (!_loc_2.name && param1.child("name").length() > 0)
            {
                _loc_2.name = param1.name;
            }
            if (param1.child("img").length() > 0)
            {
                _loc_2.backgroundUrl = param1.img;
            }
            if (param1.child("background").length() > 0)
            {
                _loc_2.backgroundUrl = param1.background;
            }
            if (param1.child("foreground").length() > 0)
            {
                _loc_2.foregroundUrl = param1.foreground;
            }
            if (param1.child("url").length() > 0)
            {
                _loc_2.linkUrl = param1.url;
            }
            if (param1.child("begin").length() > 0)
            {
                _loc_2.begin = new Date(param1.begin.@year, (param1.begin.@month - 1), param1.begin.@day, param1.begin.@hour, param1.begin.@minute);
            }
            if (param1.child("end").length() > 0)
            {
                _loc_2.end = new Date(param1.end.@year, (param1.end.@month - 1), param1.end.@day, param1.end.@hour, param1.end.@minute);
            }
            if (param1.child("count").length() > 0)
            {
                _loc_2.countMax = param1.count;
            }
            if (param1.child("screen").length() > 0)
            {
                _loc_2.screen = param1.screen;
            }
            _loc_2.count = 0;
            var _loc_3:* = XmlConfig.getInstance().getEntry("config.lang.current");
            _loc_2.lang = _loc_3;
            return _loc_2;
        }// end function

    }
}
