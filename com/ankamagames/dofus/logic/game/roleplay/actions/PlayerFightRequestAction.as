package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerFightRequestAction extends Object implements Action
   {
      
      public function PlayerFightRequestAction() {
         super();
      }
      
      public static function create(targetedPlayerId:uint, ava:Boolean, friendly:Boolean=true, launch:Boolean=false, cellId:int=-1) : PlayerFightRequestAction {
         var o:PlayerFightRequestAction = new PlayerFightRequestAction();
         o.ava = ava;
         o.friendly = friendly;
         o.cellId = cellId;
         o.targetedPlayerId = targetedPlayerId;
         o.launch = launch;
         return o;
      }
      
      public var targetedPlayerId:uint;
      
      public var cellId:int;
      
      public var friendly:Boolean;
      
      public var launch:Boolean;
      
      public var ava:Boolean;
   }
}
