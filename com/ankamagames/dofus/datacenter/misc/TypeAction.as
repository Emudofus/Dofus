package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class TypeAction extends Object implements IDataCenter
   {
      
      public function TypeAction() {
         super();
      }
      
      public static const MODULE:String = "TypeActions";
      
      public static function getTypeActionById(param1:int) : TypeAction {
         return GameData.getObject(MODULE,param1) as TypeAction;
      }
      
      public static function getAllTypeAction() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var elementName:String;
      
      public var elementId:int;
   }
}
