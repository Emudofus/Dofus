package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildShareAction extends Object implements Action
   {
      
      public function HouseGuildShareAction() {
         super();
      }
      
      public static function create(enabled:Boolean, rights:int=0) : HouseGuildShareAction {
         var action:HouseGuildShareAction = new HouseGuildShareAction();
         action.enabled = enabled;
         action.rights = rights;
         return action;
      }
      
      public var enabled:Boolean;
      
      public var rights:int;
   }
}
