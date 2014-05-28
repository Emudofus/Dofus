package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MimicryObjectFeedAndAssociateRequestAction extends Object implements Action
   {
      
      public function MimicryObjectFeedAndAssociateRequestAction() {
         super();
      }
      
      public static function create(mimicryUID:uint, mimicryPos:uint, foodUID:uint, foodPos:uint, hostUID:uint, hostPos:uint, preview:Boolean) : MimicryObjectFeedAndAssociateRequestAction {
         var action:MimicryObjectFeedAndAssociateRequestAction = new MimicryObjectFeedAndAssociateRequestAction();
         action.mimicryUID = mimicryUID;
         action.mimicryPos = mimicryPos;
         action.foodUID = foodUID;
         action.foodPos = foodPos;
         action.hostUID = hostUID;
         action.hostPos = hostPos;
         action.preview = preview;
         return action;
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
