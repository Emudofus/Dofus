package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TitleSelectRequestAction extends Object implements Action
   {
      
      public function TitleSelectRequestAction() {
         super();
      }
      
      public static function create(titleId:int) : TitleSelectRequestAction {
         var action:TitleSelectRequestAction = new TitleSelectRequestAction();
         action.titleId = titleId;
         return action;
      }
      
      public var titleId:int;
   }
}
