package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobAllowMultiCraftRequestSetAction extends Object implements Action
   {
      
      public function JobAllowMultiCraftRequestSetAction() {
         super();
      }
      
      public static function create(pIsPublic:Boolean) : JobAllowMultiCraftRequestSetAction {
         var action:JobAllowMultiCraftRequestSetAction = new JobAllowMultiCraftRequestSetAction();
         action.isPublic = pIsPublic;
         return action;
      }
      
      public var isPublic:Boolean;
   }
}
