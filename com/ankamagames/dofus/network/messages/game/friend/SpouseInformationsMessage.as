package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SpouseInformationsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spouse:FriendSpouseInformations;
        public static const protocolId:uint = 6356;

        public function SpouseInformationsMessage()
        {
            this.spouse = new FriendSpouseInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6356;
        }// end function

        public function initSpouseInformationsMessage(param1:FriendSpouseInformations = null) : SpouseInformationsMessage
        {
            this.spouse = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.spouse = new FriendSpouseInformations();
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
            this.serializeAs_SpouseInformationsMessage(param1);
            return;
        }// end function

        public function serializeAs_SpouseInformationsMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.spouse.getTypeId());
            this.spouse.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SpouseInformationsMessage(param1);
            return;
        }// end function

        public function deserializeAs_SpouseInformationsMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.spouse = ProtocolTypeManager.getInstance(FriendSpouseInformations, _loc_2);
            this.spouse.deserialize(param1);
            return;
        }// end function

    }
}
