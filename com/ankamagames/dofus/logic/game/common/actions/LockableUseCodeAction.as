package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LockableUseCodeAction extends Object implements Action
   {
      
      public function LockableUseCodeAction() {
         super();
      }
      
      public static function create(param1:String) : LockableUseCodeAction {
         var _loc2_:LockableUseCodeAction = new LockableUseCodeAction();
         _loc2_.code = param1;
         return _loc2_;
      }
      
      public var code:String;
   }
}
