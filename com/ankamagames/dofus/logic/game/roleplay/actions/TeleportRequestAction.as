package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TeleportRequestAction extends Object implements Action
   {
      
      public function TeleportRequestAction() {
         super();
      }
      
      public static function create(teleportType:uint, mapId:uint, cost:uint) : TeleportRequestAction {
         var action:TeleportRequestAction = new TeleportRequestAction();
         action.teleportType = teleportType;
         action.mapId = mapId;
         action.cost = cost;
         return action;
      }
      
      public var mapId:uint;
      
      public var teleportType:uint;
      
      public var cost:uint;
   }
}
