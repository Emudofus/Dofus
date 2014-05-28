package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveEntityAction extends Object implements Action
   {
      
      public function RemoveEntityAction() {
         super();
      }
      
      public static function create(actorId:int) : RemoveEntityAction {
         var o:RemoveEntityAction = new RemoveEntityAction();
         o.actorId = actorId;
         return o;
      }
      
      public var actorId:int;
   }
}
