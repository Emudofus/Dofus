package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlaySoundAction extends Object implements Action
   {
      
      public function PlaySoundAction() {
         super();
      }
      
      public static function create(pSoundId:String) : PlaySoundAction {
         var action:PlaySoundAction = new PlaySoundAction();
         action.soundId = pSoundId;
         return action;
      }
      
      public var soundId:String;
   }
}
