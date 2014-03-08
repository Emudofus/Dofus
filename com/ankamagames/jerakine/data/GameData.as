package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.jerakine.utils.memory.SoftReference;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class GameData extends AbstractDataManager
   {
      
      public function GameData() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GameData));
      
      private static const CACHE_SIZE_RATIO:Number = 0.1;
      
      private static var _directObjectCaches:Dictionary = new Dictionary();
      
      private static var _objectCaches:Dictionary = new Dictionary();
      
      private static var _objectsCaches:Dictionary = new Dictionary();
      
      private static var _overrides:Dictionary = new Dictionary();
      
      public static function addOverride(param1:String, param2:int, param3:uint) : void {
         if(!_overrides[param1])
         {
            _overrides[param1] = [];
         }
         _overrides[param1][param2] = param3;
      }
      
      public static function getObject(param1:String, param2:int) : Object {
         var _loc3_:Object = null;
         var _loc4_:WeakReference = null;
         if((_overrides[param1]) && (_overrides[param1][param2]))
         {
            param2 = _overrides[param1][param2];
         }
         if(!_directObjectCaches[param1])
         {
            _directObjectCaches[param1] = new Dictionary();
         }
         else
         {
            _loc4_ = _directObjectCaches[param1][param2];
            if(_loc4_)
            {
               _loc3_ = _loc4_.object;
               if(_loc3_)
               {
                  return _loc3_;
               }
            }
         }
         if(!_objectCaches[param1])
         {
            _objectCaches[param1] = new Cache(GameDataFileAccessor.getInstance().getCount(param1) * CACHE_SIZE_RATIO,new LruGarbageCollector());
         }
         else
         {
            _loc3_ = (_objectCaches[param1] as Cache).peek(param2);
            if(_loc3_)
            {
               return _loc3_;
            }
         }
         _loc3_ = GameDataFileAccessor.getInstance().getObject(param1,param2);
         _directObjectCaches[param1][param2] = new WeakReference(_loc3_);
         (_objectCaches[param1] as Cache).store(param2,_loc3_);
         return _loc3_;
      }
      
      public static function getObjects(param1:String) : Array {
         var _loc2_:Array = null;
         if(_objectsCaches[param1])
         {
            _loc2_ = _objectsCaches[param1].object as Array;
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         _loc2_ = GameDataFileAccessor.getInstance().getObjects(param1);
         _objectsCaches[param1] = new SoftReference(_loc2_);
         return _loc2_;
      }
   }
}
