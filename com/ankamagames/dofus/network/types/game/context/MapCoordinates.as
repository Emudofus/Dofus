package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class MapCoordinates implements INetworkType 
    {

        public static const protocolId:uint = 174;

        public var worldX:int = 0;
        public var worldY:int = 0;


        public function getTypeId():uint
        {
            return (174);
        }

        public function initMapCoordinates(worldX:int=0, worldY:int=0):MapCoordinates
        {
            this.worldX = worldX;
            this.worldY = worldY;
            return (this);
        }

        public function reset():void
        {
            this.worldX = 0;
            this.worldY = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MapCoordinates(output);
        }

        public function serializeAs_MapCoordinates(output:ICustomDataOutput):void
        {
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element worldX.")));
            };
            output.writeShort(this.worldX);
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element worldY.")));
            };
            output.writeShort(this.worldY);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapCoordinates(input);
        }

        public function deserializeAs_MapCoordinates(input:ICustomDataInput):void
        {
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of MapCoordinates.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of MapCoordinates.worldY.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context

