package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NpcGenericActionRequestAction extends Object implements Action
   {
      
      public function NpcGenericActionRequestAction() {
         super();
      }
      
      public static function create(npcId:int, actionId:int) : NpcGenericActionRequestAction {
         var a:NpcGenericActionRequestAction = new NpcGenericActionRequestAction();
         a.npcId = npcId;
         a.actionId = actionId;
         return a;
      }
      
      public var npcId:int;
      
      public var actionId:int;
   }
}
