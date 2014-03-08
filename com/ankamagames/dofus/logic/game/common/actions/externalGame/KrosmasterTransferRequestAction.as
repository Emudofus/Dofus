package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class KrosmasterTransferRequestAction extends Object implements Action
   {
      
      public function KrosmasterTransferRequestAction() {
         super();
      }
      
      public static function create(param1:String) : KrosmasterTransferRequestAction {
         var _loc2_:KrosmasterTransferRequestAction = new KrosmasterTransferRequestAction();
         _loc2_.figureId = param1;
         return _loc2_;
      }
      
      public var figureId:String;
   }
}
