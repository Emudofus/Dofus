package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenCurrentFightAction extends Object implements Action
   {
      
      public function OpenCurrentFightAction() {
         super();
      }
      
      public static function create() : OpenCurrentFightAction {
         return new OpenCurrentFightAction();
      }
      
      private var _name:String;
      
      public var value:String;
   }
}
