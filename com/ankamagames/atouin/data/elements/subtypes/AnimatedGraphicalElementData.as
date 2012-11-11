package com.ankamagames.atouin.data.elements.subtypes
{
    import com.ankamagames.atouin.*;
    import flash.utils.*;

    public class AnimatedGraphicalElementData extends NormalGraphicalElementData
    {
        public var minDelay:uint;
        public var maxDelay:uint;

        public function AnimatedGraphicalElementData(param1:int, param2:int)
        {
            super(param1, param2);
            return;
        }// end function

        override public function fromRaw(param1:IDataInput, param2:int) : void
        {
            super.fromRaw(param1, param2);
            if (param2 == 4)
            {
                this.minDelay = param1.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("  (AnimatedGraphicalElementData) minDelay : " + this.minDelay);
                }
                this.maxDelay = param1.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("  (AnimatedGraphicalElementData) maxDelay : " + this.maxDelay);
                }
            }
            return;
        }// end function

    }
}
