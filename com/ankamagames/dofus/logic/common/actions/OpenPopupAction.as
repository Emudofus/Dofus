package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenPopupAction extends Object implements Action
   {
      
      public function OpenPopupAction() {
         super();
      }
      
      public static function create(pMsg:String="") : OpenPopupAction {
         var s:OpenPopupAction = new OpenPopupAction();
         s.messageToShow = pMsg;
         return s;
      }
      
      public var messageToShow:String;
   }
}
