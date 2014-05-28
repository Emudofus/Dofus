package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectChangeSkinRequestAction extends Object implements Action
   {
      
      public function LivingObjectChangeSkinRequestAction() {
         super();
      }
      
      public static function create(livingUID:uint, livingPosition:uint, skinId:uint) : LivingObjectChangeSkinRequestAction {
         var action:LivingObjectChangeSkinRequestAction = new LivingObjectChangeSkinRequestAction();
         action.livingUID = livingUID;
         action.livingPosition = livingPosition;
         action.skinId = skinId;
         return action;
      }
      
      public var livingUID:uint;
      
      public var livingPosition:uint;
      
      public var skinId:uint;
   }
}
