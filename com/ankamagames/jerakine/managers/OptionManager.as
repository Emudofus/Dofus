package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.tubul.interfaces.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    dynamic public class OptionManager extends Proxy implements IEventDispatcher
    {
        private var _defaultValue:Dictionary;
        private var _properties:Dictionary;
        private var _useCache:Dictionary;
        private var _eventDispatcher:EventDispatcher;
        private var _customName:String;
        private var _dataStore:DataStoreType;
        protected var _item:Array;
        private static var _optionsManager:Array = new Array();

        public function OptionManager(param1:String = null)
        {
            this._defaultValue = new Dictionary();
            this._properties = new Dictionary();
            this._useCache = new Dictionary();
            if (param1)
            {
                this._customName = param1;
            }
            else
            {
                this._customName = getQualifiedClassName(this).split("::").join("_");
            }
            if (_optionsManager[this._customName])
            {
                throw new Error(param1 + " is already used by an other option manager.");
            }
            _optionsManager[this._customName] = this;
            this._eventDispatcher = new EventDispatcher(this);
            this._dataStore = new DataStoreType(this._customName, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
            return;
        }// end function

        public function add(param1:String, param2 = null, param3:Boolean = true) : void
        {
            this._useCache[param1] = param3;
            this._defaultValue[param1] = param2;
            if (param3 && StoreDataManager.getInstance().getData(this._dataStore, param1) != null)
            {
                this._properties[param1] = StoreDataManager.getInstance().getData(this._dataStore, param1);
            }
            else
            {
                this._properties[param1] = param2;
            }
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this._eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return this._eventDispatcher.dispatchEvent(event);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return this._eventDispatcher.hasEventListener(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this._eventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return this._eventDispatcher.willTrigger(param1);
        }// end function

        public function restaureDefaultValue(param1:String) : void
        {
            if (this._useCache[param1] != null)
            {
                this.setProperty(param1, this._defaultValue[param1]);
            }
            return;
        }// end function

        override function getProperty(param1)
        {
            return this._properties[param1];
        }// end function

        override function setProperty(param1, param2) : void
        {
            var _loc_3:* = undefined;
            if (this._useCache[param1] != null)
            {
                _loc_3 = this._properties[param1];
                this._properties[param1] = param2;
                if (this._useCache[param1] && !(this._properties[param1] is DisplayObject))
                {
                    StoreDataManager.getInstance().setData(this._dataStore, param1, param2);
                }
                this._eventDispatcher.dispatchEvent(new PropertyChangeEvent(this, param1, this._properties[param1], _loc_3));
            }
            return;
        }// end function

        override function nextNameIndex(param1:int) : int
        {
            var _loc_2:* = undefined;
            if (param1 == 0)
            {
                this._item = new Array();
                for (_loc_2 in this._properties)
                {
                    
                    this._item.push(_loc_2);
                }
            }
            if (param1 < this._item.length)
            {
                return (param1 + 1);
            }
            return 0;
        }// end function

        override function nextName(param1:int) : String
        {
            return this._item[(param1 - 1)];
        }// end function

        public static function getOptionManager(param1:String) : OptionManager
        {
            var _loc_2:* = _optionsManager;
            return _optionsManager[param1];
        }// end function

        public static function getOptionManagers() : Array
        {
            var _loc_2:String = null;
            var _loc_1:Array = [];
            for (_loc_2 in _optionsManager)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public static function reset() : void
        {
            _optionsManager = new Array();
            return;
        }// end function

    }
}
