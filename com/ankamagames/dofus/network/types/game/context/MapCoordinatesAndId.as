package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapCoordinatesAndId extends MapCoordinates implements INetworkType
    {
        public var mapId:int = 0;
        public static const protocolId:uint = 392;

        public function MapCoordinatesAndId()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 392;
        }// end function

        public function initMapCoordinatesAndId(param1:int = 0, param2:int = 0, param3:int = 0) : MapCoordinatesAndId
        {
            super.initMapCoordinates(param1, param2);
            this.mapId = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.mapId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MapCoordinatesAndId(param1);
            return;
        }// end function

        public function serializeAs_MapCoordinatesAndId(param1:IDataOutput) : void
        {
            super.serializeAs_MapCoordinates(param1);
            param1.writeInt(this.mapId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapCoordinatesAndId(param1);
            return;
        }// end function

        public function deserializeAs_MapCoordinatesAndId(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.mapId = param1.readInt();
            return;
        }// end function

    }
}
