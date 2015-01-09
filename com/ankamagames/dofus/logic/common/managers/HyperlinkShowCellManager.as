package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;

    public class HyperlinkShowCellManager 
    {


        public static function showCell(... args):void
        {
            var sq:SerialSequencer;
            try
            {
                sq = new SerialSequencer();
                sq.addStep(new AddGfxEntityStep(645, args[int((Math.random() * args.length))]));
                sq.start();
            }
            catch(e:Error)
            {
            };
        }


    }
}//package com.ankamagames.dofus.logic.common.managers

