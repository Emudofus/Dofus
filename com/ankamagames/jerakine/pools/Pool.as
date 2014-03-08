package com.ankamagames.jerakine.pools
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class Pool extends Object
   {
      
      public function Pool(pooledClass:Class, initialSize:int, growSize:int, warnLimit:int=0) {
         super();
         this._pooledClass = pooledClass;
         this._pool = new Array();
         this._growSize = growSize;
         this._warnLimit = warnLimit;
         var i:uint = 0;
         while(i < initialSize)
         {
            this._pool.push(new this._pooledClass());
            i++;
         }
         this._totalSize = initialSize;
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
         var i:uint = 0;
         if(this._pool.length == 0)
         {
            i = 0;
            while(i < this._growSize)
            {
               this._pool.push(new this._pooledClass());
               i++;
            }
            this._totalSize = this._totalSize + this._growSize;
            if((this._warnLimit > 0) && (this._totalSize > this._warnLimit))
            {
               _log.warn("Pool of " + this._pooledClass + " size beyond the warning limit. Size: " + this._pool.length + ", limit: " + this._warnLimit + ".");
            }
         }
         var o:Poolable = this._pool.shift();
         return o;
      }
      
      public function checkIn(freedObject:Poolable) : void {
         freedObject.free();
         this._pool.push(freedObject);
      }
   }
}
