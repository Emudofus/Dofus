package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.tiphon.types.TransformData;
   
   public class SkinPosition extends Object implements IDataCenter
   {
      
      public function SkinPosition() {
         super();
      }
      
      private static const MODULE:String = "SkinPositions";
      
      public static function getSkinPositionById(id:int) : SkinPosition {
         return GameData.getObject(MODULE,id) as SkinPosition;
      }
      
      public static function getAllSkinPositions() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var transformation:Vector.<TransformData>;
      
      public var clip:Vector.<String>;
      
      public var skin:Vector.<uint>;
   }
}
