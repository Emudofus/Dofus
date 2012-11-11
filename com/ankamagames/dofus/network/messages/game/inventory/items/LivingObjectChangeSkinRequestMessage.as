package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LivingObjectChangeSkinRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var livingUID:uint = 0;
        public var livingPosition:uint = 0;
        public var skinId:uint = 0;
        public static const protocolId:uint = 5725;

        public function LivingObjectChangeSkinRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5725;
        }// end function

        public function initLivingObjectChangeSkinRequestMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : LivingObjectChangeSkinRequestMessage
        {
            this.livingUID = param1;
            this.livingPosition = param2;
            this.skinId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.livingUID = 0;
            this.livingPosition = 0;
            this.skinId = 0;
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
            this.serializeAs_LivingObjectChangeSkinRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_LivingObjectChangeSkinRequestMessage(param1:IDataOutput) : void
        {
            if (this.livingUID < 0)
            {
                throw new Error("Forbidden value (" + this.livingUID + ") on element livingUID.");
            }
            param1.writeInt(this.livingUID);
            if (this.livingPosition < 0 || this.livingPosition > 255)
            {
                throw new Error("Forbidden value (" + this.livingPosition + ") on element livingPosition.");
            }
            param1.writeByte(this.livingPosition);
            if (this.skinId < 0)
            {
                throw new Error("Forbidden value (" + this.skinId + ") on element skinId.");
            }
            param1.writeInt(this.skinId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LivingObjectChangeSkinRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_LivingObjectChangeSkinRequestMessage(param1:IDataInput) : void
        {
            this.livingUID = param1.readInt();
            if (this.livingUID < 0)
            {
                throw new Error("Forbidden value (" + this.livingUID + ") on element of LivingObjectChangeSkinRequestMessage.livingUID.");
            }
            this.livingPosition = param1.readUnsignedByte();
            if (this.livingPosition < 0 || this.livingPosition > 255)
            {
                throw new Error("Forbidden value (" + this.livingPosition + ") on element of LivingObjectChangeSkinRequestMessage.livingPosition.");
            }
            this.skinId = param1.readInt();
            if (this.skinId < 0)
            {
                throw new Error("Forbidden value (" + this.skinId + ") on element of LivingObjectChangeSkinRequestMessage.skinId.");
            }
            return;
        }// end function

    }
}
