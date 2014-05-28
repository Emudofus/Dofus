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
      
      public function Cache(checkSystem:uint, max:uint, warn:uint) {
         super();
         this._dicCache = new Dictionary(true);
         this._dicIndexObject = new Dictionary(true);
         this._nObjectCount = 0;
         this._nCheckMemorySystem = checkSystem;
         if(this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
         {
            this._nWarnMemory = warn;
            this._nMaxMemory = max;
         }
         else if(this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
         {
            this._nWarnCount = warn;
            this._nMaxCount = max;
         }
         else
         {
            _log.error("ERROR ! You have to choose a cache size verification system. Objects\'s counter will be used by default.");
            this._nCheckMemorySystem = CHECK_OBJECT_COUNT;
            this._nWarnCount = 750;
            this._nMaxCount = 1000;
         }
         
      }
      
      protected static const _log:Logger;
      
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
      
      public function set warnMemory(nValue:int) : void {
         this._nWarnMemory = nValue;
      }
      
      public function get maxMemory() : int {
         return this._nMaxMemory;
      }
      
      public function set maxMemory(nValue:int) : void {
         this._nMaxMemory = nValue;
      }
      
      public function get warnCount() : int {
         return this._nWarnCount;
      }
      
      public function set warnCount(nValue:int) : void {
         this._nWarnCount = nValue;
      }
      
      public function get maxCount() : int {
         return this._nMaxCount;
      }
      
      public function set maxCount(nValue:int) : void {
         this._nMaxCount = nValue;
      }
      
      public function get objectCount() : int {
         return this._nObjectCount;
      }
      
      public function cacheObject(obj:ICachable) : void {
         this.cleanMemoryCache();
         this.registerObject(obj);
      }
      
      public function cleanMemoryCache() : void {
         var existsUnusedObject:Boolean = true;
         var limitAntiBoucle:uint = 0;
         if(this._nCheckMemorySystem == CHECK_OBJECT_COUNT)
         {
            while(this._nObjectCount >= this._nMaxCount)
            {
               if(existsUnusedObject)
               {
                  existsUnusedObject = this.cleanCache();
               }
               else
               {
                  this.onCleanFailed();
               }
               limitAntiBoucle++;
               if(limitAntiBoucle >= 20)
               {
                  _log.error("the clean memory task seems to be in an infinite loop, we stop it now.");
                  break;
               }
            }
            if((this._nObjectCount >= this._nWarnCount) && (this._nObjectCount < this._nMaxCount))
            {
               _log.trace("WARNING ! The limit of cache memory will soon be reached");
            }
         }
         if(this._nCheckMemorySystem == CHECK_SYSTEM_MEMORY)
         {
            while(System.totalMemory >= this._nMaxMemory)
            {
               if(existsUnusedObject)
               {
                  existsUnusedObject = this.cleanCache();
               }
               else
               {
                  this.onCleanFailed();
               }
               limitAntiBoucle++;
               if(limitAntiBoucle >= 20)
               {
                  _log.error("the clean memory task seems to be in an infinite loop, we stop it now.");
                  break;
               }
            }
            if((System.totalMemory >= this._nWarnMemory) && (System.totalMemory < this._nMaxMemory))
            {
               _log.trace("WARNING ! The limit of cache memory will soon be reached");
            }
         }
      }
      
      public function clear() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function containsCachable(type:Class, name:String) : Boolean {
         var nIndex:* = NaN;
         var bContains:Boolean = false;
         if(name != "")
         {
            nIndex = this.getIndexFromString(this.getStringFromClassAndName(type,name));
            bContains = (!(this._dicIndexObject[nIndex] == null)) || (!(this._dicIndexObject[nIndex] == undefined));
            if(bContains)
            {
               this._dicCache[this._dicIndexObject[nIndex]] = getTimer();
            }
         }
         else
         {
            _log.error("[Cache] Error, invalid object name.");
         }
         return bContains;
      }
      
      public function getFromCache(type:Class, name:String) : * {
         var o:* = undefined;
         var nIndex:Number = this.getIndexFromString(this.getStringFromClassAndName(type,name));
         o = this._dicIndexObject[nIndex];
         return o;
      }
      
      private function getStringFromClassAndName(type:Class, name:String) : String {
         var str:String = null;
         var arr:Array = getQualifiedClassName(type).split("::");
         str = arr[1] + "" + name;
         return str;
      }
      
      private function getIndex(obj:ICachable) : Number {
         var sIndex:String = getQualifiedClassName(obj) + "" + obj.name;
         var arr:Array = sIndex.split("::");
         sIndex = arr[1];
         return this.getIndexFromString(sIndex);
      }
      
      private function getIndexFromString(str:String) : Number {
         var crc:CRC32 = new CRC32();
         var bt:ByteArray = new ByteArray();
         bt.writeMultiByte(str,"utf-8");
         crc.update(bt);
         var nCryptedIndex:uint = crc.getValue();
         crc.reset();
         return nCryptedIndex;
      }
      
      private function registerObject(obj:ICachable) : void {
         this._dicCache[obj] = getTimer();
         this._dicIndexObject[this.getIndex(obj)] = obj;
         this._nObjectCount++;
      }
      
      private function cleanCache() : Boolean {
         var s:String = null;
         var _oldestObj:* = undefined;
         var minDate:int = getTimer();
         for(s in this._dicIndexObject)
         {
            if(!ICachable(this._dicIndexObject[s]).inUse)
            {
               if(this._dicCache[this._dicIndexObject[s]] < minDate)
               {
                  minDate = this._dicCache[this._dicIndexObject[s]];
                  _oldestObj = this._dicIndexObject[s];
               }
            }
         }
         if((!(_oldestObj == null)) && (!(_oldestObj["name"] == null)))
         {
            _log.error("Objet " + _oldestObj["name"] + " supprimé du cache.");
            delete this._dicCache[_oldestObj];
            delete this._dicIndexObject[this.getIndex(_oldestObj)];
            _oldestObj["destroy"]();
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
