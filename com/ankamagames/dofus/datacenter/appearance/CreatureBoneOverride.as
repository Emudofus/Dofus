package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class CreatureBoneOverride extends Object implements IDataCenter
   {
      
      public function CreatureBoneOverride() {
         super();
      }
      
      public static const MODULE:String = "CreatureBonesOverrides";
      
      public static function getCreatureBones(param1:int) : int {
         var _loc2_:CreatureBoneOverride = GameData.getObject(MODULE,param1) as CreatureBoneOverride;
         return _loc2_?_loc2_.creatureBoneId:0;
      }
      
      public static function getAllCreatureBonesOverrides() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var boneId:int;
      
      public var creatureBoneId:int;
   }
}
