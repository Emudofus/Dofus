package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismSettingsRequestAction extends Object implements Action
   {
      
      public function PrismSettingsRequestAction() {
         super();
      }
      
      public static function create(subAreaId:uint, startDefenseTime:uint) : PrismSettingsRequestAction {
         var action:PrismSettingsRequestAction = new PrismSettingsRequestAction();
         action.subAreaId = subAreaId;
         action.startDefenseTime = startDefenseTime;
         return action;
      }
      
      public var subAreaId:uint;
      
      public var startDefenseTime:uint;
   }
}
