package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismSettingsRequestAction extends Object implements Action
   {
      
      public function PrismSettingsRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : PrismSettingsRequestAction {
         var _loc3_:PrismSettingsRequestAction = new PrismSettingsRequestAction();
         _loc3_.subAreaId = param1;
         _loc3_.startDefenseTime = param2;
         return _loc3_;
      }
      
      public var subAreaId:uint;
      
      public var startDefenseTime:uint;
   }
}
