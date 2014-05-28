package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectMessageRequestAction extends Object implements Action
   {
      
      public function LivingObjectMessageRequestAction() {
         super();
      }
      
      public static function create(msgId:uint, livingObjectUID:uint) : LivingObjectMessageRequestAction {
         var a:LivingObjectMessageRequestAction = new LivingObjectMessageRequestAction();
         a.msgId = msgId;
         a.livingObjectUID = livingObjectUID;
         return a;
      }
      
      public var msgId:uint;
      
      public var livingObjectUID:uint;
   }
}
