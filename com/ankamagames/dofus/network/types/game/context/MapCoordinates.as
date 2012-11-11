package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapCoordinates extends Object implements INetworkType
    {
        public var worldX:int = 0;
        public var worldY:int = 0;
        public static const protocolId:uint = 174;

        public function MapCoordinates()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 174;
        }// end function

        public function initMapCoordinates(param1:int = 0, param2:int = 0) : MapCoordinates
        {
            this.worldX = param1;
            this.worldY = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.worldX = 0;
            this.worldY = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MapCoordinates(param1);
            return;
        }// end function

        public function serializeAs_MapCoordinates(param1:IDataOutput) : void
        {
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
            }
            param1.writeShort(this.worldX);
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            param1.writeShort(this.worldY);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapCoordinates(param1);
            return;
        }// end function

        public function deserializeAs_MapCoordinates(param1:IDataInput) : void
        {
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of MapCoordinates.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of MapCoordinates.worldY.");
            }
            return;
        }// end function

    }
}
