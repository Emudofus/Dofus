package com.ankamagames.jerakine.managers
{
   import flash.utils.Proxy;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.types.DataStoreType;
   import flash.events.Event;
   import flash.utils.flash_proxy;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   use namespace flash_proxy;
   
   public dynamic class OptionManager extends Proxy implements IEventDispatcher
   {
      
      public function OptionManager(param1:String=null) {
         this._defaultValue = new Dictionary();
         this._properties = new Dictionary();
         this._useCache = new Dictionary();
         super();
         if(param1)
         {
            this._customName = param1;
         }
         else
         {
            this._customName = getQualifiedClassName(this).split("::").join("_");
         }
         if(_optionsManager[this._customName])
         {
            throw new Error(param1 + " is already used by an other option manager.");
         }
         else
         {
            _optionsManager[this._customName] = this;
            this._eventDispatcher = new EventDispatcher(this);
            this._dataStore = new DataStoreType(this._customName,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
            return;
         }
      }
      
      private static var _optionsManager:Array = new Array();
      
      public static function getOptionManager(param1:String) : OptionManager {
         var _loc2_:* = _optionsManager;
         return _optionsManager[param1];
      }
      
      public static function getOptionManagers() : Array {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for (_loc2_ in _optionsManager)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public static function reset() : void {
         _optionsManager = new Array();
      }
      
      private var _defaultValue:Dictionary;
      
      private var _properties:Dictionary;
      
      private var _useCache:Dictionary;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _customName:String;
      
      private var _dataStore:DataStoreType;
      
      public function add(param1:String, param2:*=null, param3:Boolean=true) : void {
         this._useCache[param1] = param3;
         this._defaultValue[param1] = param2;
         if((param3) && !(StoreDataManager.getInstance().getData(this._dataStore,param1) == null))
         {
            this._properties[param1] = StoreDataManager.getInstance().getData(this._dataStore,param1);
         }
         else
         {
            this._properties[param1] = param2;
         }
      }
      
      public function getDefaultValue(param1:String) : * {
         return this._defaultValue[param1];
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean=false) : void {
         this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function restaureDefaultValue(param1:String) : void {
         if(this._useCache[param1] != null)
         {
            this.setProperty(param1,this._defaultValue[param1]);
         }
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         return this._properties[param1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void {
         var _loc3_:* = undefined;
         if(this._useCache[param1] != null)
         {
            _loc3_ = this._properties[param1];
            this._properties[param1] = param2;
            if((this._useCache[param1]) && !(this._properties[param1] is DisplayObject))
            {
               StoreDataManager.getInstance().setData(this._dataStore,param1,param2);
            }
            this._eventDispatcher.dispatchEvent(new PropertyChangeEvent(this,param1,this._properties[param1],_loc3_));
         }
      }
      
      protected var _item:Array;
      
      override flash_proxy function nextNameIndex(param1:int) : int {
         var _loc2_:* = undefined;
         if(param1 == 0)
         {
            this._item = new Array();
            for (_loc2_ in this._properties)
            {
               this._item.push(_loc2_);
            }
         }
         if(param1 < this._item.length)
         {
            return param1 + 1;
         }
         return 0;
      }
      
      override flash_proxy function nextName(param1:int) : String {
         return this._item[param1-1];
      }
   }
}
