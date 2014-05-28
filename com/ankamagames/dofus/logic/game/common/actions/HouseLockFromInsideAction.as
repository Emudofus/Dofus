package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseLockFromInsideAction extends Object implements Action
   {
      
      public function HouseLockFromInsideAction() {
         super();
      }
      
      public static function create(code:String) : HouseLockFromInsideAction {
         var action:HouseLockFromInsideAction = new HouseLockFromInsideAction();
         action.code = code;
         return action;
      }
      
      public var code:String;
   }
}
