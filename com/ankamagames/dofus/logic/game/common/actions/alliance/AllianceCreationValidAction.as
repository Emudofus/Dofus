package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceCreationValidAction extends Object implements Action
   {
      
      public function AllianceCreationValidAction() {
         super();
      }
      
      public static function create(pAllianceName:String, pAllianceTag:String, pUpEmblemId:uint, pUpColorEmblem:uint, pBackEmblemId:uint, pBackColorEmblem:uint) : AllianceCreationValidAction {
         var action:AllianceCreationValidAction = new AllianceCreationValidAction();
         action.allianceName = pAllianceName;
         action.allianceTag = pAllianceTag;
         action.upEmblemId = pUpEmblemId;
         action.upColorEmblem = pUpColorEmblem;
         action.backEmblemId = pBackEmblemId;
         action.backColorEmblem = pBackColorEmblem;
         return action;
      }
      
      public var allianceName:String;
      
      public var allianceTag:String;
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
   }
}
