package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockMoveItemRequestAction extends Object implements Action
   {
      
      public function PaddockMoveItemRequestAction() {
         super();
      }
      
      public static function create(object:Object) : PaddockMoveItemRequestAction {
         var o:PaddockMoveItemRequestAction = new PaddockMoveItemRequestAction();
         o.object = object;
         return o;
      }
      
      public var object:Object;
   }
}
