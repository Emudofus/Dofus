package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CloseBookAction extends Object implements Action
   {
      
      public function CloseBookAction() {
         super();
      }
      
      public static function create() : CloseBookAction {
         return new CloseBookAction();
      }
      
      private var _name:String;
      
      public var value:String;
   }
}
