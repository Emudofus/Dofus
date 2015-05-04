package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismsListRegisterAction extends Object implements Action
   {
      
      public function PrismsListRegisterAction()
      {
         super();
      }
      
      public static function create(param1:String, param2:uint) : PrismsListRegisterAction
      {
         var _loc3_:PrismsListRegisterAction = new PrismsListRegisterAction();
         _loc3_.uiName = param1;
         _loc3_.listen = param2;
         return _loc3_;
      }
      
      public var uiName:String;
      
      public var listen:uint;
   }
}
