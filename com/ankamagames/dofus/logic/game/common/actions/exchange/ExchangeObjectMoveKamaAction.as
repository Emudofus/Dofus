package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectMoveKamaAction extends Object implements Action
   {
      
      public function ExchangeObjectMoveKamaAction() {
         super();
      }
      
      public static function create(pKamas:uint) : ExchangeObjectMoveKamaAction {
         var a:ExchangeObjectMoveKamaAction = new ExchangeObjectMoveKamaAction();
         a.kamas = pKamas;
         return a;
      }
      
      public var kamas:uint;
   }
}
