package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectMessageRequestAction extends Object implements Action
   {
      
      public function LivingObjectMessageRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : LivingObjectMessageRequestAction {
         var _loc3_:LivingObjectMessageRequestAction = new LivingObjectMessageRequestAction();
         _loc3_.msgId = param1;
         _loc3_.livingObjectUID = param2;
         return _loc3_;
      }
      
      public var msgId:uint;
      
      public var livingObjectUID:uint;
   }
}
