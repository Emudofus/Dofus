package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TitlesAndOrnamentsListRequestAction extends Object implements Action
   {
      
      public function TitlesAndOrnamentsListRequestAction() {
         super();
      }
      
      public static function create() : TitlesAndOrnamentsListRequestAction {
         var _loc1_:TitlesAndOrnamentsListRequestAction = new TitlesAndOrnamentsListRequestAction();
         return _loc1_;
      }
   }
}
