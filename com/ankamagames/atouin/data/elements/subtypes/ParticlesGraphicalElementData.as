package com.ankamagames.atouin.data.elements.subtypes
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ParticlesGraphicalElementData extends GraphicalElementData
    {
        public var scriptId:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ParticlesGraphicalElementData));

        public function ParticlesGraphicalElementData(param1:int, param2:int)
        {
            super(param1, param2);
            return;
        }// end function

        override public function fromRaw(param1:IDataInput, param2:int) : void
        {
            this.scriptId = param1.readShort();
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (ParticlesGraphicalElementData) Script id : " + this.scriptId);
            }
            return;
        }// end function

    }
}
