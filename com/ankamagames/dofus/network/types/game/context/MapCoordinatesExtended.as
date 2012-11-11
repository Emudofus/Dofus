package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapCoordinatesExtended extends MapCoordinatesAndId implements INetworkType
    {
        public var subAreaId:uint = 0;
        public static const protocolId:uint = 176;

        public function MapCoordinatesExtended()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 176;
        }// end function

        public function initMapCoordinatesExtended(param1:int = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : MapCoordinatesExtended
        {
            super.initMapCoordinatesAndId(param1, param2, param3);
            this.subAreaId = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.subAreaId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MapCoordinatesExtended(param1);
            return;
        }// end function

        public function serializeAs_MapCoordinatesExtended(param1:IDataOutput) : void
        {
            super.serializeAs_MapCoordinatesAndId(param1);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapCoordinatesExtended(param1);
            return;
        }// end function

        public function deserializeAs_MapCoordinatesExtended(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of MapCoordinatesExtended.subAreaId.");
            }
            return;
        }// end function

    }
}
