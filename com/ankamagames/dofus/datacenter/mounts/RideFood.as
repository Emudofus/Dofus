package com.ankamagames.dofus.datacenter.mounts
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class RideFood extends Object implements IDataCenter
   {
      
      public function RideFood() {
         super();
      }
      
      public static var MODULE:String = "RideFood";
      
      public static function getRideFoods() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var gid:uint;
      
      public var typeId:uint;
   }
}
