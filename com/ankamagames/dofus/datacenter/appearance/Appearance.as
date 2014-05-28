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
      
      public static function getAppearanceById(id:uint) : Appearance {
         return GameData.getObject(MODULE,id) as Appearance;
      }
      
      public var id:uint;
      
      public var type:uint;
      
      public var data:String;
   }
}
