package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MimicryObjectFeedAndAssociateRequestAction extends Object implements Action
   {
      
      public function MimicryObjectFeedAndAssociateRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:Boolean) : MimicryObjectFeedAndAssociateRequestAction {
         var _loc8_:MimicryObjectFeedAndAssociateRequestAction = new MimicryObjectFeedAndAssociateRequestAction();
         _loc8_.mimicryUID = param1;
         _loc8_.mimicryPos = param2;
         _loc8_.foodUID = param3;
         _loc8_.foodPos = param4;
         _loc8_.hostUID = param5;
         _loc8_.hostPos = param6;
         _loc8_.preview = param7;
         return _loc8_;
      }
      
      public var mimicryUID:uint;
      
      public var mimicryPos:uint;
      
      public var foodUID:uint;
      
      public var foodPos:uint;
      
      public var hostUID:uint;
      
      public var hostPos:uint;
      
      public var preview:Boolean;
   }
}
