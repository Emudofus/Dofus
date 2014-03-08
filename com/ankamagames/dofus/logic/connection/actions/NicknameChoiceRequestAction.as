package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NicknameChoiceRequestAction extends Object implements Action
   {
      
      public function NicknameChoiceRequestAction() {
         super();
      }
      
      public static function create(param1:String) : NicknameChoiceRequestAction {
         var _loc2_:NicknameChoiceRequestAction = new NicknameChoiceRequestAction();
         _loc2_.nickname = param1;
         return _loc2_;
      }
      
      public var nickname:String;
   }
}
