package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildRightsChangeAction extends Object implements Action
   {
      
      public function HouseGuildRightsChangeAction() {
         super();
      }
      
      public static function create(rights:int) : HouseGuildRightsChangeAction {
         var action:HouseGuildRightsChangeAction = new HouseGuildRightsChangeAction();
         action.rights = rights;
         return action;
      }
      
      public var rights:int;
   }
}
