package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class Appearance extends Object implements IDataCenter
   {
      
      public function Appearance() {
         super();
      }
      
      public static const MODULE:String = "Appearances";
      
      public static function getAppearanceById(param1:uint) : Appearance {
         return GameData.getObject(MODULE,param1) as Appearance;
      }
      
      public var id:uint;
      
      public var type:uint;
      
      public var data:String;
   }
}
