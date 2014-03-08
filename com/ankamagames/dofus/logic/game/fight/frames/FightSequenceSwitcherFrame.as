package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   
   public class FightSequenceSwitcherFrame extends Object implements Frame
   {
      
      public function FightSequenceSwitcherFrame() {
         super();
      }
      
      private var _currentFrame:Frame;
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function get priority() : int {
         return Priority.HIGHEST;
      }
      
      public function set currentFrame(f:Frame) : void {
         this._currentFrame = f;
      }
      
      public function process(msg:Message) : Boolean {
         if(this._currentFrame)
         {
            return this._currentFrame.process(msg);
         }
         return false;
      }
   }
}
