package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class Incarnation extends Object implements IDataCenter
   {
      
      public function Incarnation() {
         super();
      }
      
      public static const MODULE:String = "Incarnation";
      
      private static var _incarnationsList:Array;
      
      public static function getIncarnationById(param1:uint) : Incarnation {
         return GameData.getObject(MODULE,param1) as Incarnation;
      }
      
      public static function getAllIncarnation() : Array {
         if(!_incarnationsList)
         {
            _incarnationsList = GameData.getObjects(MODULE) as Array;
         }
         return _incarnationsList;
      }
      
      public var id:uint;
      
      public var lookMale:String;
      
      public var lookFemale:String;
   }
}
