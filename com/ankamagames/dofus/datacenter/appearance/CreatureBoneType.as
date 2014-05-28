package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class CreatureBoneType extends Object implements IDataCenter
   {
      
      public function CreatureBoneType() {
         super();
      }
      
      public static const MODULE:String = "CreatureBonesTypes";
      
      public static function getUnknownCreatureBone() : int {
         return (GameData.getObject(MODULE,0) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getMonsterCreatureBone() : int {
         return (GameData.getObject(MODULE,1) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getMonsterInvocationCreatureBone() : int {
         return (GameData.getObject(MODULE,2) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getBossMonsterCreatureBone() : int {
         return (GameData.getObject(MODULE,3) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getPlayerInvocationCreatureBone() : int {
         return (GameData.getObject(MODULE,4) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getPlayerIncarnationCreatureBone() : int {
         return (GameData.getObject(MODULE,5) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getPlayerMutantCreatureBone() : int {
         return (GameData.getObject(MODULE,6) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getPrismCreatureBone() : int {
         return (GameData.getObject(MODULE,7) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getTaxCollectorCreatureBone() : int {
         return (GameData.getObject(MODULE,9) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getPlayerMerchantCreatureBone() : int {
         return (GameData.getObject(MODULE,10) as CreatureBoneType).creatureBoneId;
      }
      
      public static function getAllCreatureBonesTypes() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var creatureBoneId:int;
   }
}
