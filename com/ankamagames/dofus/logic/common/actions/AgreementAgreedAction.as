package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AgreementAgreedAction extends Object implements Action
   {
      
      public function AgreementAgreedAction() {
         super();
      }
      
      public static function create(param1:String) : AgreementAgreedAction {
         var _loc2_:AgreementAgreedAction = new AgreementAgreedAction();
         _loc2_.fileName = param1;
         return _loc2_;
      }
      
      public var fileName:String;
   }
}
