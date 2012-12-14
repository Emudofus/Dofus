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
            args = null;
            try
            {
                args = new SerialSequencer();
                args.addStep(new AddGfxEntityStep(645, args[int(Math.random() * args.length)]));
                args.start();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
