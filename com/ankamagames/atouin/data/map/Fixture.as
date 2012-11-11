package com.ankamagames.atouin.data.map
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Fixture extends Object
    {
        public var fixtureId:int;
        public var offset:Point;
        public var hue:int;
        public var redMultiplier:int;
        public var greenMultiplier:int;
        public var blueMultiplier:int;
        public var alpha:uint;
        public var xScale:int;
        public var yScale:int;
        public var rotation:int;
        private var _map:Map;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Fixture));

        public function Fixture(param1:Map)
        {
            this._map = param1;
            return;
        }// end function

        public function get map() : Map
        {
            return this._map;
        }// end function

        public function fromRaw(param1:IDataInput) : void
        {
            var raw:* = param1;
            try
            {
                this.fixtureId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Fixture) Id : " + this.fixtureId);
                }
                this.offset = new Point();
                this.offset.x = raw.readShort();
                this.offset.y = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Fixture) Offset : (" + this.offset.x + ";" + this.offset.y + ")");
                }
                this.rotation = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Fixture) Rotation : " + this.rotation);
                }
                this.xScale = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Fixture) Scale X : " + this.xScale);
                }
                this.yScale = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Fixture) Scale Y : " + this.yScale);
                }
                this.redMultiplier = raw.readByte();
                this.greenMultiplier = raw.readByte();
                this.blueMultiplier = raw.readByte();
                this.hue = this.redMultiplier | this.greenMultiplier | this.blueMultiplier;
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Fixture) Hue : 0x" + this.hue.toString(16));
                }
                this.alpha = raw.readUnsignedByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Fixture) Alpha : " + this.alpha);
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
