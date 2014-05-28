package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class KrosmasterTransferRequestAction extends Object implements Action
   {
      
      public function KrosmasterTransferRequestAction() {
         super();
      }
      
      public static function create(figureId:String) : KrosmasterTransferRequestAction {
         var action:KrosmasterTransferRequestAction = new KrosmasterTransferRequestAction();
         action.figureId = figureId;
         return action;
      }
      
      public var figureId:String;
   }
}
