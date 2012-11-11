package com.ankamagames.atouin.data.elements.subtypes
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class BlendedGraphicalElementData extends NormalGraphicalElementData
    {
        public var blendMode:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(NormalGraphicalElementData));

        public function BlendedGraphicalElementData(param1:int, param2:int)
        {
            super(param1, param2);
            return;
        }// end function

        override public function fromRaw(param1:IDataInput, param2:int) : void
        {
            super.fromRaw(param1, param2);
            var _loc_3:* = param1.readInt();
            this.blendMode = param1.readUTFBytes(_loc_3);
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (BlendedGraphicalElementData) BlendMode : " + this.blendMode);
            }
            return;
        }// end function

    }
}
