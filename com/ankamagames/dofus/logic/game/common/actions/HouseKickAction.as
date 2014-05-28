package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseKickAction extends Object implements Action
   {
      
      public function HouseKickAction() {
         super();
      }
      
      public static function create(id:uint) : HouseKickAction {
         var action:HouseKickAction = new HouseKickAction();
         action.id = id;
         return action;
      }
      
      public var id:uint;
   }
}
