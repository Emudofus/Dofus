package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class MapCoordinatesExtended extends MapCoordinatesAndId implements INetworkType 
    {

        public static const protocolId:uint = 176;

        public var subAreaId:uint = 0;


        override public function getTypeId():uint
        {
            return (176);
        }

        public function initMapCoordinatesExtended(worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0):MapCoordinatesExtended
        {
            super.initMapCoordinatesAndId(worldX, worldY, mapId);
            this.subAreaId = subAreaId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.subAreaId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MapCoordinatesExtended(output);
        }

        public function serializeAs_MapCoordinatesExtended(output:ICustomDataOutput):void
        {
            super.serializeAs_MapCoordinatesAndId(output);
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeVarShort(this.subAreaId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapCoordinatesExtended(input);
        }

        public function deserializeAs_MapCoordinatesExtended(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of MapCoordinatesExtended.subAreaId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context

