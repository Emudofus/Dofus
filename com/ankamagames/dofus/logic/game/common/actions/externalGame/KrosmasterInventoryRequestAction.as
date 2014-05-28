package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class KrosmasterInventoryRequestAction extends Object implements Action
   {
      
      public function KrosmasterInventoryRequestAction() {
         super();
      }
      
      public static function create() : KrosmasterInventoryRequestAction {
         var action:KrosmasterInventoryRequestAction = new KrosmasterInventoryRequestAction();
         return action;
      }
   }
}
