package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerFightRequestAction extends Object implements Action
   {
      
      public function PlayerFightRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:Boolean, param3:Boolean=true, param4:Boolean=false, param5:int=-1) : PlayerFightRequestAction {
         var _loc6_:PlayerFightRequestAction = new PlayerFightRequestAction();
         _loc6_.ava = param2;
         _loc6_.friendly = param3;
         _loc6_.cellId = param5;
         _loc6_.targetedPlayerId = param1;
         _loc6_.launch = param4;
         return _loc6_;
      }
      
      public var targetedPlayerId:uint;
      
      public var cellId:int;
      
      public var friendly:Boolean;
      
      public var launch:Boolean;
      
      public var ava:Boolean;
   }
}
