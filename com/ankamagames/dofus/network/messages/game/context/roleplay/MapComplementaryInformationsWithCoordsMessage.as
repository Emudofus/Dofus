package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapComplementaryInformationsWithCoordsMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public static const protocolId:uint = 6268;

        public function MapComplementaryInformationsWithCoordsMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6268;
        }// end function

        public function initMapComplementaryInformationsWithCoordsMessage(param1:uint = 0, param2:uint = 0, param3:int = 0, param4:Vector.<HouseInformations> = null, param5:Vector.<GameRolePlayActorInformations> = null, param6:Vector.<InteractiveElement> = null, param7:Vector.<StatedElement> = null, param8:Vector.<MapObstacle> = null, param9:Vector.<FightCommonInformations> = null, param10:int = 0, param11:int = 0) : MapComplementaryInformationsWithCoordsMessage
        {
            super.initMapComplementaryInformationsDataMessage(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            this.worldX = param10;
            this.worldY = param11;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.worldX = 0;
            this.worldY = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MapComplementaryInformationsWithCoordsMessage(param1);
            return;
        }// end function

        public function serializeAs_MapComplementaryInformationsWithCoordsMessage(param1:IDataOutput) : void
        {
            super.serializeAs_MapComplementaryInformationsDataMessage(param1);
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

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapComplementaryInformationsWithCoordsMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapComplementaryInformationsWithCoordsMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of MapComplementaryInformationsWithCoordsMessage.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of MapComplementaryInformationsWithCoordsMessage.worldY.");
            }
            return;
        }// end function

    }
}
