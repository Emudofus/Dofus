package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReplayStopAction extends Object implements Action
   {
      
      public function ExchangeReplayStopAction() {
         super();
      }
      
      public static function create() : ExchangeReplayStopAction {
         var action:ExchangeReplayStopAction = new ExchangeReplayStopAction();
         return action;
      }
   }
}
