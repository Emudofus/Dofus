package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class KrosmasterTokenRequestAction extends Object implements Action
   {
         

      public function KrosmasterTokenRequestAction() {
         super();
      }

      public static function create() : KrosmasterTokenRequestAction {
         var action:KrosmasterTokenRequestAction = new KrosmasterTokenRequestAction();
         return action;
      }


   }

}