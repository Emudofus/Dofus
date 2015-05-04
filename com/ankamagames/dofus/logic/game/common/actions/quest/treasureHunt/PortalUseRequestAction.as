package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PortalUseRequestAction extends Object implements Action
   {
      
      public function PortalUseRequestAction()
      {
         super();
      }
      
      public static function create(param1:int) : PortalUseRequestAction
      {
         var _loc2_:PortalUseRequestAction = new PortalUseRequestAction();
         _loc2_.portalId = param1;
         return _loc2_;
      }
      
      public var portalId:int;
   }
}
