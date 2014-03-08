package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockBuyRequestAction extends Object implements Action
   {
      
      public function PaddockBuyRequestAction() {
         super();
      }
      
      public static function create() : PaddockBuyRequestAction {
         return new PaddockBuyRequestAction();
      }
   }
}
