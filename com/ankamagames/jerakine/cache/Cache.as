package com.ankamagames.jerakine.cache
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.system.System;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   import flash.utils.ByteArray;
   
   public class Cache extends Object
   {
      
      public function Cache(param1:uint, param2:uint, param3:uint) {
         super();
         this._dicCache = new Dictionary(true);
         this._dicIndexObject = new Dictionary(true);
         this._nObjectCount = 0;
         this._nCheckMemorySystem = param1;
         if(this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
         {
            this._nWarnMemory = param3;
            this._nMaxMemory = param2;
         }
         else
         {
            if(this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
            {
               this._nWarnCount = param3;
               this._nMaxCount = param2;
            }
            else
            {
               _log.error("ERROR ! You have to choose a cache size verification system. Objects\'s counter will be used by default.");
               this._nCheckMemorySystem = CHECK_OBJECT_COUNT;
               this._nWarnCount = 750;
               this._nMaxCount = 1000;
            }
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Cache));
      
      public static const CHECK_SYSTEM_MEMORY:uint = 1;
      
      public static const CHECK_OBJECT_COUNT:uint = 2;
      
      private var _dicCache:Dictionary;
      
      private var _dicIndexObject:Dictionary;
      
      private var _nMaxMemory:int;
      
      private var _nWarnMemory:int;
      
      private var _nMaxCount:int;
      
      private var _nWarnCount:int;
      
      private var _nCheckMemorySystem:uint;
      
      private var _nObjectCount:uint;
      
      public function get cacheArray() : Dictionary {
         return this._dicCache;
      }
      
      public function get warnMemory() : int {
         return this._nWarnMemory;
      }
      
      public function set warnMemory(param1:int) : void {
         this._nWarnMemory = param1;
      }
      
      public function get maxMemory() : int {
         return this._nMaxMemory;
      }
      
      public function set maxMemory(param1:int) : void {
         this._nMaxMemory = param1;
      }
      
      public function get warnCount() : int {
         return this._nWarnCount;
      }
      
      public function set warnCount(param1:int) : void {
         this._nWarnCount = param1;
      }
      
      public function get maxCount() : int {
         return this._nMaxCount;
      }
      
      public function set maxCount(param1:int) : void {
         this._nMaxCount = param1;
      }
      
      public function get objectCount() : int {
         return this._nObjectCount;
      }
      
      public function cacheObject(param1:ICachable) : void {
         this.cleanMemoryCache();
         this.registerObject(param1);
      }
      
      public function cleanMemoryCache() : void {
         var _loc1_:* = true;
         var _loc2_:uint = 0;
         if(this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
         {
            while(this._nObjectCount >= this._nMaxCount)
            {
               if(_loc1_)
               {
                  _loc1_ = this.cleanCache();
               }
               else
               {
                  this.onCleanFailed();
               }
               _loc2_++;
               if(_loc2_ >= 20)
               {
                  _log.error("the clean memory task seems to be in an infinite loop, we stop it now.");
                  break;
               }
            }
            if(this._nObjectCount >= this._nWarnCount && this._nObjectCount < this._nMaxCount)
            {
               _log.trace("WARNING ! The limit of cache memory will soon be reached");
            }
         }
         if(this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
         {
            while(System.totalMemory >= this._nMaxMemory)
            {
               if(_loc1_)
               {
                  _loc1_ = this.cleanCache();
               }
               else
               {
                  this.onCleanFailed();
               }
               _loc2_++;
               if(_loc2_ >= 20)
               {
                  _log.error("the clean memory task seems to be in an infinite loop, we stop it now.");
                  break;
               }
            }
            if(System.totalMemory >= this._nWarnMemory && System.totalMemory < this._nMaxMemory)
            {
               _log.trace("WARNING ! The limit of cache memory will soon be reached");
            }
         }
      }
      
      public function clear() : void {
         var _loc1_:ICachable = null;
         var _loc2_:String = null;
         for (_loc2_ in this._dicIndexObject)
         {
            _loc1_ = this._dicIndexObject[_loc2_];
            if(_loc1_)
            {
               delete this._dicCache[[_loc1_]];
               delete this._dicIndexObject[[this.getIndex(_loc1_)]];
               this._nObjectCount--;
               _loc1_.destroy();
            }
         }
      }
      
      public function containsCachable(param1:Class, param2:String) : Boolean {
         var _loc4_:* = NaN;
         var _loc3_:* = false;
         if(param2 != "")
         {
            _loc4_ = this.getIndexFromString(this.getStringFromClassAndName(param1,param2));
            _loc3_ = !(this._dicIndexObject[_loc4_] == null) || !(this._dicIndexObject[_loc4_] == undefined);
            if(_loc3_)
            {
               this._dicCache[this._dicIndexObject[_loc4_]] = getTimer();
            }
         }
         else
         {
            _log.error("[Cache] Error, invalid object name.");
         }
         return _loc3_;
      }
      
      public function getFromCache(param1:Class, param2:String) : * {
         var _loc3_:* = undefined;
         var _loc4_:Number = this.getIndexFromString(this.getStringFromClassAndName(param1,param2));
         _loc3_ = this._dicIndexObject[_loc4_];
         return _loc3_;
      }
      
      private function getStringFromClassAndName(param1:Class, param2:String) : String {
         var _loc3_:String = null;
         var _loc4_:Array = getQualifiedClassName(param1).split("::");
         _loc3_ = _loc4_[1] + "" + param2;
         return _loc3_;
      }
      
      private function getIndex(param1:ICachable) : Number {
         var _loc2_:String = getQualifiedClassName(param1) + "" + param1.name;
         var _loc3_:Array = _loc2_.split("::");
         _loc2_ = _loc3_[1];
         return this.getIndexFromString(_loc2_);
      }
      
      private function getIndexFromString(param1:String) : Number {
         var _loc2_:CRC32 = new CRC32();
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,"utf-8");
         _loc2_.update(_loc3_);
         var _loc4_:uint = _loc2_.getValue();
         _loc2_.reset();
         return _loc4_;
      }
      
      private function registerObject(param1:ICachable) : void {
         this._dicCache[param1] = getTimer();
         this._dicIndexObject[this.getIndex(param1)] = param1;
         this._nObjectCount++;
      }
      
      private function cleanCache() : Boolean {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc1_:int = getTimer();
         for (_loc2_ in this._dicIndexObject)
         {
            if(!ICachable(this._dicIndexObject[_loc2_]).inUse)
            {
               if(this._dicCache[this._dicIndexObject[_loc2_]] < _loc1_)
               {
                  _loc1_ = this._dicCache[this._dicIndexObject[_loc2_]];
                  _loc3_ = this._dicIndexObject[_loc2_];
               }
            }
         }
         if(!(_loc3_ == null) && !(_loc3_["name"] == null))
         {
            _log.error("Objet " + _loc3_["name"] + " supprimé du cache.");
            delete this._dicCache[[_loc3_]];
            delete this._dicIndexObject[[this.getIndex(_loc3_)]];
            _loc3_["destroy"]();
            this._nObjectCount--;
            return true;
         }
         return false;
      }
      
      private function extendMaxSize() : void {
         if(this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
         {
            this._nMaxMemory = this._nMaxMemory + this._nMaxMemory / 5;
            this._nWarnMemory = this._nWarnMemory + this._nMaxMemory / 5;
         }
         if(this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
         {
            this._nMaxCount = this._nMaxCount + this._nMaxCount / 5;
            this._nWarnCount = this._nWarnCount + this._nMaxCount / 5;
         }
      }
      
      private function onCleanFailed() : void {
         _log.error("[Cache] FAILURE !  The whole cache is used, impossible to clean. The cache size will increase.");
         this.extendMaxSize();
      }
   }
}
