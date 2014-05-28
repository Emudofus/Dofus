package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class PrismCurrentBonusRequestAction extends Object implements Action
   {
         

      public function PrismCurrentBonusRequestAction() {
         super();
      }

      public static function create() : PrismCurrentBonusRequestAction {
         var action:PrismCurrentBonusRequestAction = new PrismCurrentBonusRequestAction();
         return action;
      }


   }

}