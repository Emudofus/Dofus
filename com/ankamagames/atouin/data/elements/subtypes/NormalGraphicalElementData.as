package com.ankamagames.atouin.data.elements.subtypes
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;
    import flash.utils.*;

    public class NormalGraphicalElementData extends GraphicalElementData
    {
        public var gfxId:int;
        public var height:uint;
        public var horizontalSymmetry:Boolean;
        public var origin:Point;
        public var size:Point;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(NormalGraphicalElementData));

        public function NormalGraphicalElementData(param1:int, param2:int)
        {
            super(param1, param2);
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        override public function fromRaw(param1:IDataInput, param2:int) : void
        {
            this.gfxId = param1.readInt();
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (ElementData) Element gfx id : " + this.gfxId);
            }
            this.height = param1.readByte();
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (ElementData) Element height : " + this.height);
            }
            this.horizontalSymmetry = param1.readBoolean();
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (ElementData) Element horizontals symmetry : " + this.horizontalSymmetry);
            }
            this.origin = new Point(param1.readShort(), param1.readShort());
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (ElementData) Origin : (" + this.origin.x + ";" + this.origin.y + ")");
            }
            this.size = new Point(param1.readShort(), param1.readShort());
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (ElementData) Size : (" + this.size.x + ";" + this.size.y + ")");
            }
            return;
        }// end function

    }
}
