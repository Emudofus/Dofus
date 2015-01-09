package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class MapCoordinatesAndId extends MapCoordinates implements INetworkType 
    {

        public static const protocolId:uint = 392;

        public var mapId:int = 0;


        override public function getTypeId():uint
        {
            return (392);
        }

        public function initMapCoordinatesAndId(worldX:int=0, worldY:int=0, mapId:int=0):MapCoordinatesAndId
        {
            super.initMapCoordinates(worldX, worldY);
            this.mapId = mapId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.mapId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MapCoordinatesAndId(output);
        }

        public function serializeAs_MapCoordinatesAndId(output:ICustomDataOutput):void
        {
            super.serializeAs_MapCoordinates(output);
            output.writeInt(this.mapId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapCoordinatesAndId(input);
        }

        public function deserializeAs_MapCoordinatesAndId(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.mapId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context

