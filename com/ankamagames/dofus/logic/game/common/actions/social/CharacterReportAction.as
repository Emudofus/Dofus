package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterReportAction extends Object implements Action
   {
      
      public function CharacterReportAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : CharacterReportAction {
         var _loc3_:CharacterReportAction = new CharacterReportAction();
         _loc3_.reportedId = param1;
         _loc3_.reason = param2;
         return _loc3_;
      }
      
      public var reportedId:uint;
      
      public var reason:uint;
   }
}
