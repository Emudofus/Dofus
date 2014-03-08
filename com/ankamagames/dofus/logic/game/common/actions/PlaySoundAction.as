package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlaySoundAction extends Object implements Action
   {
      
      public function PlaySoundAction() {
         super();
      }
      
      public static function create(param1:String) : PlaySoundAction {
         var _loc2_:PlaySoundAction = new PlaySoundAction();
         _loc2_.soundId = param1;
         return _loc2_;
      }
      
      public var soundId:String;
   }
}
