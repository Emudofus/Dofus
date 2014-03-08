package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MapRunningFightDetailsRequestAction extends Object implements Action
   {
      
      public function MapRunningFightDetailsRequestAction() {
         super();
      }
      
      public static function create(fightId:uint) : MapRunningFightDetailsRequestAction {
         var a:MapRunningFightDetailsRequestAction = new MapRunningFightDetailsRequestAction();
         a.fightId = fightId;
         return a;
      }
      
      public var fightId:uint;
   }
}
