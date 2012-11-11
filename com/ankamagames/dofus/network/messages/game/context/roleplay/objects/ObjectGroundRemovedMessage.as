package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectGroundRemovedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cell:uint = 0;
        public static const protocolId:uint = 3014;

        public function ObjectGroundRemovedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 3014;
        }// end function

        public function initObjectGroundRemovedMessage(param1:uint = 0) : ObjectGroundRemovedMessage
        {
            this.cell = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.cell = 0;
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
            this.serializeAs_ObjectGroundRemovedMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectGroundRemovedMessage(param1:IDataOutput) : void
        {
            if (this.cell < 0 || this.cell > 559)
            {
                throw new Error("Forbidden value (" + this.cell + ") on element cell.");
            }
            param1.writeShort(this.cell);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectGroundRemovedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectGroundRemovedMessage(param1:IDataInput) : void
        {
            this.cell = param1.readShort();
            if (this.cell < 0 || this.cell > 559)
            {
                throw new Error("Forbidden value (" + this.cell + ") on element of ObjectGroundRemovedMessage.cell.");
            }
            return;
        }// end function

    }
}
