package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismsListRegisterAction extends Object implements Action
   {
      
      public function PrismsListRegisterAction() {
         super();
      }
      
      public static function create(param1:uint) : PrismsListRegisterAction {
         var _loc2_:PrismsListRegisterAction = new PrismsListRegisterAction();
         _loc2_.listen = param1;
         return _loc2_;
      }
      
      public var listen:uint;
   }
}
