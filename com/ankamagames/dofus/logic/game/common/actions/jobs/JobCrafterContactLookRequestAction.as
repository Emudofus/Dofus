package com.ankamagames.dofus.logic.game.common.actions.jobs
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobCrafterContactLookRequestAction extends Object implements Action
   {
      
      public function JobCrafterContactLookRequestAction() {
         super();
      }
      
      public static function create(crafterId:uint) : JobCrafterContactLookRequestAction {
         var act:JobCrafterContactLookRequestAction = new JobCrafterContactLookRequestAction();
         act.crafterId = crafterId;
         return act;
      }
      
      public var crafterId:uint;
   }
}
