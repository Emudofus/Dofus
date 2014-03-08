package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildRightsChangeAction extends Object implements Action
   {
      
      public function HouseGuildRightsChangeAction() {
         super();
      }
      
      public static function create(param1:int) : HouseGuildRightsChangeAction {
         var _loc2_:HouseGuildRightsChangeAction = new HouseGuildRightsChangeAction();
         _loc2_.rights = param1;
         return _loc2_;
      }
      
      public var rights:int;
   }
}
