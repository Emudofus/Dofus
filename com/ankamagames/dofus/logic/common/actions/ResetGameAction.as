package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ResetGameAction extends Object implements Action
   {
      
      public function ResetGameAction() {
         super();
      }
      
      public static function create(pMsg:String="") : ResetGameAction {
         var a:ResetGameAction = new ResetGameAction();
         a.messageToShow = pMsg;
         return a;
      }
      
      public var messageToShow:String;
   }
}
