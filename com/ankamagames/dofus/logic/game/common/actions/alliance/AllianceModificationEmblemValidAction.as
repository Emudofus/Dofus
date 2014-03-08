package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceModificationEmblemValidAction extends Object implements Action
   {
      
      public function AllianceModificationEmblemValidAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:uint) : AllianceModificationEmblemValidAction {
         var _loc5_:AllianceModificationEmblemValidAction = new AllianceModificationEmblemValidAction();
         _loc5_.upEmblemId = param1;
         _loc5_.upColorEmblem = param2;
         _loc5_.backEmblemId = param3;
         _loc5_.backColorEmblem = param4;
         return _loc5_;
      }
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
   }
}
