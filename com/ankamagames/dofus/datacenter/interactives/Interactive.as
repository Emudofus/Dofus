package com.ankamagames.dofus.datacenter.interactives
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Interactive extends Object implements IDataCenter
   {
      
      public function Interactive() {
         super();
      }
      
      public static const MODULE:String = "Interactives";
      
      public static function getInteractiveById(id:int) : Interactive {
         return GameData.getObject(MODULE,id) as Interactive;
      }
      
      public static function getInteractives() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var actionId:int;
      
      public var displayTooltip:Boolean;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
