package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MoodSmileyRequestAction extends Object implements Action
   {
      
      public function MoodSmileyRequestAction() {
         super();
      }
      
      public static function create(id:int) : MoodSmileyRequestAction {
         var a:MoodSmileyRequestAction = new MoodSmileyRequestAction();
         a.smileyId = id;
         return a;
      }
      
      public var smileyId:int;
   }
}
