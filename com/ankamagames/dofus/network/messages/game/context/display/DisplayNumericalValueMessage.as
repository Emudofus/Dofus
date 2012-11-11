package com.ankamagames.dofus.network.messages.game.context.display
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DisplayNumericalValueMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var entityId:int = 0;
        public var value:int = 0;
        public var type:uint = 0;
        public static const protocolId:uint = 5808;

        public function DisplayNumericalValueMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5808;
        }// end function

        public function initDisplayNumericalValueMessage(param1:int = 0, param2:int = 0, param3:uint = 0) : DisplayNumericalValueMessage
        {
            this.entityId = param1;
            this.value = param2;
            this.type = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.entityId = 0;
            this.value = 0;
            this.type = 0;
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
            this.serializeAs_DisplayNumericalValueMessage(param1);
            return;
        }// end function

        public function serializeAs_DisplayNumericalValueMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.entityId);
            param1.writeInt(this.value);
            param1.writeByte(this.type);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DisplayNumericalValueMessage(param1);
            return;
        }// end function

        public function deserializeAs_DisplayNumericalValueMessage(param1:IDataInput) : void
        {
            this.entityId = param1.readInt();
            this.value = param1.readInt();
            this.type = param1.readByte();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of DisplayNumericalValueMessage.type.");
            }
            return;
        }// end function

    }
}
