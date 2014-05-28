package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerStatusUpdateRequestAction extends Object implements Action
   {
      
      public function PlayerStatusUpdateRequestAction() {
         super();
      }
      
      public static function create(statusNumber:uint, msg:String = "") : PlayerStatusUpdateRequestAction {
         var a:PlayerStatusUpdateRequestAction = new PlayerStatusUpdateRequestAction();
         a.status = statusNumber;
         a.message = msg;
         return a;
      }
      
      public var status:int;
      
      public var message:String;
   }
}
