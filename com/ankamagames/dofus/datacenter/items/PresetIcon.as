package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class PresetIcon extends Object implements IDataCenter
   {
      
      public function PresetIcon() {
         super();
      }
      
      public static const MODULE:String = "PresetIcons";
      
      public static function getPresetIconById(id:int) : PresetIcon {
         return GameData.getObject(MODULE,id) as PresetIcon;
      }
      
      public static function getPresetIcons() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var order:int;
   }
}
