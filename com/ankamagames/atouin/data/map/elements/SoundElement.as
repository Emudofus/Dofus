package com.ankamagames.atouin.data.map.elements
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.enums.*;
    import flash.utils.*;

    public class SoundElement extends BasicElement
    {
        public var soundId:int;
        public var minDelayBetweenLoops:int;
        public var maxDelayBetweenLoops:int;
        public var baseVolume:int;
        public var fullVolumeDistance:int;
        public var nullVolumeDistance:int;

        public function SoundElement(param1:Cell)
        {
            super(param1);
            return;
        }// end function

        override public function get elementType() : int
        {
            return ElementTypesEnum.SOUND;
        }// end function

        override public function fromRaw(param1:IDataInput, param2:int) : void
        {
            var raw:* = param1;
            var mapVersion:* = param2;
            try
            {
                this.soundId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("      (SoundElement) Sound id : " + this.soundId);
                }
                this.baseVolume = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("      (SoundElement) Base volume : " + this.baseVolume);
                }
                this.fullVolumeDistance = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("      (SoundElement) Full volume distance : " + this.fullVolumeDistance);
                }
                this.nullVolumeDistance = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("      (SoundElement) Null volume distance : " + this.nullVolumeDistance);
                }
                this.minDelayBetweenLoops = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("      (SoundElement) Minimal delay between loops : " + this.minDelayBetweenLoops);
                }
                this.maxDelayBetweenLoops = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("      (SoundElement) Maximal delay between loops : " + this.maxDelayBetweenLoops);
                }
            }
            catch (e)
            {
                throw e;
            }
            return;
        }// end function

    }
}
