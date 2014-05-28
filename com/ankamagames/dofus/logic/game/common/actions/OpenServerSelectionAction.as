package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenServerSelectionAction extends Object implements Action
   {
      
      public function OpenServerSelectionAction() {
         super();
      }
      
      public static function create() : OpenServerSelectionAction {
         return new OpenServerSelectionAction();
      }
      
      private var _name:String;
      
      public var value:String;
   }
}
