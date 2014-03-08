package com.ankamagames.dofus.logic.game.common.actions.jobs
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobCrafterDirectoryEntryRequestAction extends Object implements Action
   {
      
      public function JobCrafterDirectoryEntryRequestAction() {
         super();
      }
      
      public static function create(playerId:uint) : JobCrafterDirectoryEntryRequestAction {
         var act:JobCrafterDirectoryEntryRequestAction = new JobCrafterDirectoryEntryRequestAction();
         act.playerId = playerId;
         return act;
      }
      
      public var playerId:uint;
   }
}
