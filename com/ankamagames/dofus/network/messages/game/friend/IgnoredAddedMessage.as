package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IgnoredAddedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var ignoreAdded:IgnoredInformations;
        public var session:Boolean = false;
        public static const protocolId:uint = 5678;

        public function IgnoredAddedMessage()
        {
            this.ignoreAdded = new IgnoredInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5678;
        }// end function

        public function initIgnoredAddedMessage(param1:IgnoredInformations = null, param2:Boolean = false) : IgnoredAddedMessage
        {
            this.ignoreAdded = param1;
            this.session = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.ignoreAdded = new IgnoredInformations();
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
            this.serializeAs_IgnoredAddedMessage(param1);
            return;
        }// end function

        public function serializeAs_IgnoredAddedMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.ignoreAdded.getTypeId());
            this.ignoreAdded.serialize(param1);
            param1.writeBoolean(this.session);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IgnoredAddedMessage(param1);
            return;
        }// end function

        public function deserializeAs_IgnoredAddedMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.ignoreAdded = ProtocolTypeManager.getInstance(IgnoredInformations, _loc_2);
            this.ignoreAdded.deserialize(param1);
            this.session = param1.readBoolean();
            return;
        }// end function

    }
}
