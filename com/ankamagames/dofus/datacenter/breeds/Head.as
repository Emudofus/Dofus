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

      public static function getHeadById(id:int) : Head {
         return GameData.getObject(MODULE,id) as Head;
      }

      public static function getHeads() : Array {
         return GameData.getObjects(MODULE);
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