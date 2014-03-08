package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceModificationNameAndTagValidAction extends Object implements Action
   {
      
      public function AllianceModificationNameAndTagValidAction() {
         super();
      }
      
      public static function create(pName:String, pTag:String) : AllianceModificationNameAndTagValidAction {
         var action:AllianceModificationNameAndTagValidAction = new AllianceModificationNameAndTagValidAction();
         action.name = pName;
         action.tag = pTag;
         return action;
      }
      
      public var name:String;
      
      public var tag:String;
   }
}
