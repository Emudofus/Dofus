package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.managers.*;

    dynamic public class TiphonOptions extends OptionManager
    {

        public function TiphonOptions() : void
        {
            super("tiphon");
            add("pointsOverhead", 2);
            add("aura", true);
            add("alwaysShowAuraOnFront", false);
            add("creaturesMode", 25);
            return;
        }// end function

    }
}
