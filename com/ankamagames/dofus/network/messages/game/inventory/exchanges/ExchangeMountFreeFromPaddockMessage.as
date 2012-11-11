package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeMountFreeFromPaddockMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var liberator:String = "";
        public static const protocolId:uint = 6055;

        public function ExchangeMountFreeFromPaddockMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6055;
        }// end function

        public function initExchangeMountFreeFromPaddockMessage(param1:String = "", param2:int = 0, param3:int = 0, param4:String = "") : ExchangeMountFreeFromPaddockMessage
        {
            this.name = param1;
            this.worldX = param2;
            this.worldY = param3;
            this.liberator = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.name = "";
            this.worldX = 0;
            this.worldY = 0;
            this.liberator = "";
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ExchangeMountFreeFromPaddockMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeMountFreeFromPaddockMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.name);
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
            param1.writeUTF(this.liberator);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeMountFreeFromPaddockMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeMountFreeFromPaddockMessage(param1:IDataInput) : void
        {
            this.name = param1.readUTF();
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeMountFreeFromPaddockMessage.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeMountFreeFromPaddockMessage.worldY.");
            }
            this.liberator = param1.readUTF();
            return;
        }// end function

    }
}
