package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DisplayContextualMenuAction extends Object implements Action
   {
      
      public function DisplayContextualMenuAction() {
         super();
      }
      
      public static function create(param1:uint) : DisplayContextualMenuAction {
         var _loc2_:DisplayContextualMenuAction = new DisplayContextualMenuAction();
         _loc2_.playerId = param1;
         return _loc2_;
      }
      
      public var playerId:uint;
   }
}
