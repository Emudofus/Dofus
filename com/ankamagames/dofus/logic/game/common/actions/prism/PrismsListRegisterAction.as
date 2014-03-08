package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismsListRegisterAction extends Object implements Action
   {
      
      public function PrismsListRegisterAction() {
         super();
      }
      
      public static function create(listen:uint) : PrismsListRegisterAction {
         var action:PrismsListRegisterAction = new PrismsListRegisterAction();
         action.listen = listen;
         return action;
      }
      
      public var listen:uint;
   }
}
