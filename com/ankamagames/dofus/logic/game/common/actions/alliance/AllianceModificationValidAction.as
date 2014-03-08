package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceModificationValidAction extends Object implements Action
   {
      
      public function AllianceModificationValidAction() {
         super();
      }
      
      public static function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:uint) : AllianceModificationValidAction {
         var _loc7_:AllianceModificationValidAction = new AllianceModificationValidAction();
         _loc7_.name = param1;
         _loc7_.tag = param2;
         _loc7_.upEmblemId = param3;
         _loc7_.upColorEmblem = param4;
         _loc7_.backEmblemId = param5;
         _loc7_.backColorEmblem = param6;
         return _loc7_;
      }
      
      public var name:String;
      
      public var tag:String;
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
   }
}
