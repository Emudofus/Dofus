package com.ankamagames.dofus.datacenter.breeds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class Head extends Object implements IDataCenter
   {
      
      public function Head() {
         super();
      }
      
      public static const MODULE:String = "Heads";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Head));
      
      public static function getHeadById(param1:int) : Head {
         return GameData.getObject(MODULE,param1) as Head;
      }
      
      public static function getHeads() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public static function getHead(param1:uint, param2:uint) : Array {
         var _loc5_:Head = null;
         var _loc3_:Array = GameData.getObjects(MODULE);
         var _loc4_:Array = [];
         for each (_loc5_ in _loc3_)
         {
            if(_loc5_.breed == param1 && _loc5_.gender == param2)
            {
               _loc4_.push(_loc5_);
            }
         }
         return _loc4_;
      }
      
      public var id:int;
      
      public var skins:String;
      
      public var assetId:String;
      
      public var breed:uint;
      
      public var gender:uint;
      
      public var label:String;
      
      public var order:uint;
   }
}
