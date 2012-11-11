package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class HyperlinkShowCellManager extends Object
    {

        public function HyperlinkShowCellManager()
        {
            return;
        }// end function

        public static function showCell(... args) : void
        {
            args = new activation;
            var sq:SerialSequencer;
            var args:* = args;
            try
            {
                sq = new SerialSequencer();
                addStep(new AddGfxEntityStep(645, [int(Math.random() * length)]));
                start();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
