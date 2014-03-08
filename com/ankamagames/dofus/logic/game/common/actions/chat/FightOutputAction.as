package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FightOutputAction extends Object implements Action
   {
      
      public function FightOutputAction() {
         super();
      }
      
      public static function create(param1:String, param2:uint=0) : FightOutputAction {
         var _loc3_:FightOutputAction = new FightOutputAction();
         _loc3_.content = param1;
         _loc3_.channel = param2;
         return _loc3_;
      }
      
      public var content:String;
      
      public var channel:uint;
   }
}
