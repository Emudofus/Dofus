package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SkinMapping extends Object implements IDataCenter
   {
      
      public function SkinMapping() {
         super();
      }
      
      public static const MODULE:String = "SkinMappings";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(SkinMapping));
      
      public static function getSkinMappingById(id:int) : SkinMapping {
         return GameData.getObject(MODULE,id) as SkinMapping;
      }
      
      public static function getSkinMappings() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var lowDefId:int;
   }
}
