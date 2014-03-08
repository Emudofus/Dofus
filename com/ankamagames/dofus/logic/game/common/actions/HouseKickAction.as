package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseKickAction extends Object implements Action
   {
      
      public function HouseKickAction() {
         super();
      }
      
      public static function create(param1:uint) : HouseKickAction {
         var _loc2_:HouseKickAction = new HouseKickAction();
         _loc2_.id = param1;
         return _loc2_;
      }
      
      public var id:uint;
   }
}
