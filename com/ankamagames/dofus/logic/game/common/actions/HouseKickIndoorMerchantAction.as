package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseKickIndoorMerchantAction extends Object implements Action
   {
      
      public function HouseKickIndoorMerchantAction() {
         super();
      }
      
      public static function create(param1:uint) : HouseKickIndoorMerchantAction {
         var _loc2_:HouseKickIndoorMerchantAction = new HouseKickIndoorMerchantAction();
         _loc2_.cellId = param1;
         return _loc2_;
      }
      
      public var cellId:uint;
   }
}
