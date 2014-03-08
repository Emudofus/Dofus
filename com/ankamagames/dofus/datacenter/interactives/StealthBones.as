package com.ankamagames.dofus.datacenter.interactives
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class StealthBones extends Object implements IDataCenter
   {
      
      public function StealthBones() {
         super();
      }
      
      public static const MODULE:String = "StealthBones";
      
      public static function getStealthBonesById(param1:int) : StealthBones {
         return GameData.getObject(MODULE,param1) as StealthBones;
      }
      
      public var id:uint;
   }
}
