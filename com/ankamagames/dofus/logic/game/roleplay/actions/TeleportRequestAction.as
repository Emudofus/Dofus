package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TeleportRequestAction extends Object implements Action
   {
      
      public function TeleportRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint) : TeleportRequestAction {
         var _loc4_:TeleportRequestAction = new TeleportRequestAction();
         _loc4_.teleportType = param1;
         _loc4_.mapId = param2;
         _loc4_.cost = param3;
         return _loc4_;
      }
      
      public var mapId:uint;
      
      public var teleportType:uint;
      
      public var cost:uint;
   }
}
