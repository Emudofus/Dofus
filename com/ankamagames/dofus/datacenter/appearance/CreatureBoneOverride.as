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
      
      public static function getCreatureBones(pBoneId:int) : int {
         var bonesOverride:CreatureBoneOverride = GameData.getObject(MODULE,pBoneId) as CreatureBoneOverride;
         return bonesOverride?bonesOverride.creatureBoneId:0;
      }
      
      public static function getAllCreatureBonesOverrides() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var boneId:int;
      
      public var creatureBoneId:int;
   }
}
