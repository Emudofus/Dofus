package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ClearChatAction extends Object implements Action
   {
      
      public function ClearChatAction() {
         super();
      }
      
      public static function create(param1:Array) : ClearChatAction {
         var _loc2_:ClearChatAction = new ClearChatAction();
         _loc2_.channel = param1;
         return _loc2_;
      }
      
      public var channel:Array;
   }
}
