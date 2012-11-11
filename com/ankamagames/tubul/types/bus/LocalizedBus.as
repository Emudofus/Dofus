package com.ankamagames.tubul.types.bus
{
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.sounds.*;
    import flash.geom.*;

    public class LocalizedBus extends AudioBus
    {

        public function LocalizedBus(param1:int, param2:String)
        {
            super(param1, param2);
            return;
        }// end function

        public function updateObserverPosition(param1:Point) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in _soundVector)
            {
                
                if (_loc_2 is LocalizedSound)
                {
                    (_loc_2 as LocalizedSound).updateObserverPosition(param1);
                }
            }
            return;
        }// end function

    }
}
