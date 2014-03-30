package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PortalUseRequestAction extends Object implements Action
   {
      
      public function PortalUseRequestAction() {
         super();
      }
      
      public static function create(portalId:int) : PortalUseRequestAction {
         var action:PortalUseRequestAction = new PortalUseRequestAction();
         action.portalId = portalId;
         return action;
      }
      
      public var portalId:int;
   }
}
