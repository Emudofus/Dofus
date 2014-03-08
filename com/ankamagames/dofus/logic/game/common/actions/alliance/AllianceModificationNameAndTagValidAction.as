package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceModificationNameAndTagValidAction extends Object implements Action
   {
      
      public function AllianceModificationNameAndTagValidAction() {
         super();
      }
      
      public static function create(param1:String, param2:String) : AllianceModificationNameAndTagValidAction {
         var _loc3_:AllianceModificationNameAndTagValidAction = new AllianceModificationNameAndTagValidAction();
         _loc3_.name = param1;
         _loc3_.tag = param2;
         return _loc3_;
      }
      
      public var name:String;
      
      public var tag:String;
   }
}
