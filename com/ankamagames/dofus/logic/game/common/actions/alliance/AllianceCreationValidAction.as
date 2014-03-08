package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceCreationValidAction extends Object implements Action
   {
      
      public function AllianceCreationValidAction() {
         super();
      }
      
      public static function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:uint) : AllianceCreationValidAction {
         var _loc7_:AllianceCreationValidAction = new AllianceCreationValidAction();
         _loc7_.allianceName = param1;
         _loc7_.allianceTag = param2;
         _loc7_.upEmblemId = param3;
         _loc7_.upColorEmblem = param4;
         _loc7_.backEmblemId = param5;
         _loc7_.backColorEmblem = param6;
         return _loc7_;
      }
      
      public var allianceName:String;
      
      public var allianceTag:String;
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
   }
}
