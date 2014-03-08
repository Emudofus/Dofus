package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MoodSmileyRequestAction extends Object implements Action
   {
      
      public function MoodSmileyRequestAction() {
         super();
      }
      
      public static function create(param1:int) : MoodSmileyRequestAction {
         var _loc2_:MoodSmileyRequestAction = new MoodSmileyRequestAction();
         _loc2_.smileyId = param1;
         return _loc2_;
      }
      
      public var smileyId:int;
   }
}
