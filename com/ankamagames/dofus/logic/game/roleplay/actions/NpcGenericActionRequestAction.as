package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NpcGenericActionRequestAction extends Object implements Action
   {
      
      public function NpcGenericActionRequestAction() {
         super();
      }
      
      public static function create(param1:int, param2:int) : NpcGenericActionRequestAction {
         var _loc3_:NpcGenericActionRequestAction = new NpcGenericActionRequestAction();
         _loc3_.npcId = param1;
         _loc3_.actionId = param2;
         return _loc3_;
      }
      
      public var npcId:int;
      
      public var actionId:int;
   }
}
