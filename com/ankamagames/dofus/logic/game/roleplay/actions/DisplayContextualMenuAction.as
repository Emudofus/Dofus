package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DisplayContextualMenuAction extends Object implements Action
   {
      
      public function DisplayContextualMenuAction() {
         super();
      }
      
      public static function create(playerId:uint) : DisplayContextualMenuAction {
         var o:DisplayContextualMenuAction = new DisplayContextualMenuAction();
         o.playerId = playerId;
         return o;
      }
      
      public var playerId:uint;
   }
}
