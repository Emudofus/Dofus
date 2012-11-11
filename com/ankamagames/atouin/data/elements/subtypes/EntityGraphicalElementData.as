package com.ankamagames.atouin.data.elements.subtypes
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class EntityGraphicalElementData extends GraphicalElementData
    {
        public var entityLook:String;
        public var horizontalSymmetry:Boolean;
        public var playAnimation:Boolean;
        public var playAnimStatic:Boolean;
        public var minDelay:uint;
        public var maxDelay:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EntityGraphicalElementData));

        public function EntityGraphicalElementData(param1:int, param2:int)
        {
            super(param1, param2);
            return;
        }// end function

        override public function fromRaw(param1:IDataInput, param2:int) : void
        {
            var _loc_3:* = param1.readInt();
            this.entityLook = param1.readUTFBytes(_loc_3);
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (EntityGraphicalElementData) Entity look : " + this.entityLook);
            }
            this.horizontalSymmetry = param1.readBoolean();
            if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
                _log.debug("  (EntityGraphicalElementData) Element horizontals symmetry : " + this.horizontalSymmetry);
            }
            if (param2 >= 7)
            {
                this.playAnimation = param1.readBoolean();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("  (EntityGraphicalElementData) playAnimation : " + this.playAnimation);
                }
            }
            if (param2 >= 6)
            {
                this.playAnimStatic = param1.readBoolean();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("  (EntityGraphicalElementData) playAnimStatic : " + this.playAnimStatic);
                }
            }
            if (param2 >= 5)
            {
                this.minDelay = param1.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("  (EntityGraphicalElementData) minDelay : " + this.minDelay);
                }
                this.maxDelay = param1.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("  (EntityGraphicalElementData) maxDelay : " + this.maxDelay);
                }
            }
            return;
        }// end function

    }
}
