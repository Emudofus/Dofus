package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ActionDescription extends Object implements IDataCenter
   {
      
      public function ActionDescription() {
         super();
      }
      
      public static const MODULE:String = "ActionDescriptions";
      
      private static var _actionByName:Array;
      
      public static function getActionDescriptionByName(param1:String) : ActionDescription {
         var _loc2_:Array = null;
         var _loc3_:ActionDescription = null;
         if(!_actionByName)
         {
            _actionByName = new Array();
            _loc2_ = GameData.getObjects(MODULE);
            for each (_actionByName[_loc3_.name] in _loc2_)
            {
            }
         }
         return _actionByName[param1];
      }
      
      public var id:uint;
      
      public var typeId:uint;
      
      public var name:String;
      
      public var descriptionId:uint;
      
      public var trusted:Boolean;
      
      public var needInteraction:Boolean;
      
      public var maxUsePerFrame:uint;
      
      public var minimalUseInterval:uint;
      
      public var needConfirmation:Boolean;
      
      private var _name:String;
      
      private var _description:String;
      
      public function get description() : String {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
   }
}
