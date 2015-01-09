package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class AtlasPointsInformations implements INetworkType 
    {

        public static const protocolId:uint = 175;

        public var type:uint = 0;
        public var coords:Vector.<MapCoordinatesExtended>;

        public function AtlasPointsInformations()
        {
            this.coords = new Vector.<MapCoordinatesExtended>();
            super();
        }

        public function getTypeId():uint
        {
            return (175);
        }

        public function initAtlasPointsInformations(type:uint=0, coords:Vector.<MapCoordinatesExtended>=null):AtlasPointsInformations
        {
            this.type = type;
            this.coords = coords;
            return (this);
        }

        public function reset():void
        {
            this.type = 0;
            this.coords = new Vector.<MapCoordinatesExtended>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AtlasPointsInformations(output);
        }

        public function serializeAs_AtlasPointsInformations(output:ICustomDataOutput):void
        {
            output.writeByte(this.type);
            output.writeShort(this.coords.length);
            var _i2:uint;
            while (_i2 < this.coords.length)
            {
                (this.coords[_i2] as MapCoordinatesExtended).serializeAs_MapCoordinatesExtended(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AtlasPointsInformations(input);
        }

        public function deserializeAs_AtlasPointsInformations(input:ICustomDataInput):void
        {
            var _item2:MapCoordinatesExtended;
            this.type = input.readByte();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of AtlasPointsInformations.type.")));
            };
            var _coordsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _coordsLen)
            {
                _item2 = new MapCoordinatesExtended();
                _item2.deserialize(input);
                this.coords.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

