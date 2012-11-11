package com.ankamagames.berilia.types
{
    import com.ankamagames.jerakine.managers.*;

    dynamic public class BeriliaOptions extends OptionManager
    {

        public function BeriliaOptions()
        {
            super("berilia");
            add("uiShadows", true);
            return;
        }// end function

    }
}
