package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseKickIndoorMerchantAction extends Object implements Action
   {
      
      public function HouseKickIndoorMerchantAction() {
         super();
      }
      
      public static function create(cellId:uint) : HouseKickIndoorMerchantAction {
         var action:HouseKickIndoorMerchantAction = new HouseKickIndoorMerchantAction();
         action.cellId = cellId;
         return action;
      }
      
      public var cellId:uint;
   }
}
