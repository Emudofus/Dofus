package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AgreementAgreedAction extends Object implements Action
   {
      
      public function AgreementAgreedAction() {
         super();
      }
      
      public static function create(fileName:String) : AgreementAgreedAction {
         var a:AgreementAgreedAction = new AgreementAgreedAction();
         a.fileName = fileName;
         return a;
      }
      
      public var fileName:String;
   }
}
