package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AtlasPointsInformations extends Object implements INetworkType
    {
        public var type:uint = 0;
        public var coords:Vector.<MapCoordinatesExtended>;
        public static const protocolId:uint = 175;

        public function AtlasPointsInformations()
        {
            this.coords = new Vector.<MapCoordinatesExtended>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 175;
        }// end function

        public function initAtlasPointsInformations(param1:uint = 0, param2:Vector.<MapCoordinatesExtended> = null) : AtlasPointsInformations
        {
            this.type = param1;
            this.coords = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.type = 0;
            this.coords = new Vector.<MapCoordinatesExtended>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AtlasPointsInformations(param1);
            return;
        }// end function

        public function serializeAs_AtlasPointsInformations(param1:IDataOutput) : void
        {
            param1.writeByte(this.type);
            param1.writeShort(this.coords.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.coords.length)
            {
                
                (this.coords[_loc_2] as MapCoordinatesExtended).serializeAs_MapCoordinatesExtended(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AtlasPointsInformations(param1);
            return;
        }// end function

        public function deserializeAs_AtlasPointsInformations(param1:IDataInput) : void
        {
            var _loc_4:MapCoordinatesExtended = null;
            this.type = param1.readByte();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of AtlasPointsInformations.type.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new MapCoordinatesExtended();
                _loc_4.deserialize(param1);
                this.coords.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
