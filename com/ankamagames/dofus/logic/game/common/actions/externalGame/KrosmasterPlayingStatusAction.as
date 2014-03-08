package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class KrosmasterPlayingStatusAction extends Object implements Action
   {
      
      public function KrosmasterPlayingStatusAction() {
         super();
      }
      
      public static function create(playing:Boolean) : KrosmasterPlayingStatusAction {
         var action:KrosmasterPlayingStatusAction = new KrosmasterPlayingStatusAction();
         action.playing = playing;
         return action;
      }
      
      public var playing:Boolean;
   }
}
