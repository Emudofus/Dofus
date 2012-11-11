package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;

    public class FightSequenceSwitcherFrame extends Object implements Frame
    {
        private var _currentFrame:Frame;

        public function FightSequenceSwitcherFrame()
        {
            return;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function set currentFrame(param1:Frame) : void
        {
            this._currentFrame = param1;
            return;
        }// end function

        public function process(param1:Message) : Boolean
        {
            if (this._currentFrame)
            {
                return this._currentFrame.process(param1);
            }
            return false;
        }// end function

    }
}
