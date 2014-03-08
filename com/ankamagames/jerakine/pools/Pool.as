package com.ankamagames.jerakine.pools
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class Pool extends Object
   {
      
      public function Pool(param1:Class, param2:int, param3:int, param4:int=0) {
         super();
         this._pooledClass = param1;
         this._pool = new Array();
         this._growSize = param3;
         this._warnLimit = param4;
         var _loc5_:uint = 0;
         while(_loc5_ < param2)
         {
            this._pool.push(new this._pooledClass());
            _loc5_++;
         }
         this._totalSize = param2;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Pool));
      
      private var _pooledClass:Class;
      
      private var _pool:Array;
      
      private var _growSize:int;
      
      private var _warnLimit:int;
      
      private var _totalSize:int;
      
      public function get pooledClass() : Class {
         return this._pooledClass;
      }
      
      public function get poolArray() : Array {
         return this._pool;
      }
      
      public function get growSize() : int {
         return this._growSize;
      }
      
      public function get warnLimit() : int {
         return this._warnLimit;
      }
      
      public function checkOut() : Poolable {
         var _loc2_:uint = 0;
         if(this._pool.length == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this._growSize)
            {
               this._pool.push(new this._pooledClass());
               _loc2_++;
            }
            this._totalSize = this._totalSize + this._growSize;
            if(this._warnLimit > 0 && this._totalSize > this._warnLimit)
            {
               _log.warn("Pool of " + this._pooledClass + " size beyond the warning limit. Size: " + this._pool.length + ", limit: " + this._warnLimit + ".");
            }
         }
         var _loc1_:Poolable = this._pool.shift();
         return _loc1_;
      }
      
      public function checkIn(param1:Poolable) : void {
         param1.free();
         this._pool.push(param1);
      }
   }
}
