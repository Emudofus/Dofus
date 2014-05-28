package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NumericWhoIsRequestAction extends Object implements Action
   {
      
      public function NumericWhoIsRequestAction() {
         super();
      }
      
      public static function create(playerId:uint) : NumericWhoIsRequestAction {
         var a:NumericWhoIsRequestAction = new NumericWhoIsRequestAction();
         a.playerId = playerId;
         return a;
      }
      
      public var playerId:uint;
   }
}
