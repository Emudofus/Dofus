package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectDissociateAction extends Object implements Action
   {
      
      public function LivingObjectDissociateAction() {
         super();
      }
      
      public static function create(livingUID:uint, livingPosition:uint) : LivingObjectDissociateAction {
         var action:LivingObjectDissociateAction = new LivingObjectDissociateAction();
         action.livingUID = livingUID;
         action.livingPosition = livingPosition;
         return action;
      }
      
      public var livingUID:uint;
      
      public var livingPosition:uint;
   }
}
