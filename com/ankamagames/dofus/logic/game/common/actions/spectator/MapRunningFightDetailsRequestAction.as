package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MapRunningFightDetailsRequestAction extends Object implements Action
   {
      
      public function MapRunningFightDetailsRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : MapRunningFightDetailsRequestAction {
         var _loc2_:MapRunningFightDetailsRequestAction = new MapRunningFightDetailsRequestAction();
         _loc2_.fightId = param1;
         return _loc2_;
      }
      
      public var fightId:uint;
   }
}
