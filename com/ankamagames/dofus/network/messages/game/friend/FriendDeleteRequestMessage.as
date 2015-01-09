package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class FriendDeleteRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5603;

        private var _isInitialized:Boolean = false;
        public var accountId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5603);
        }

        public function initFriendDeleteRequestMessage(accountId:uint=0):FriendDeleteRequestMessage
        {
            this.accountId = accountId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.accountId = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_FriendDeleteRequestMessage(output);
        }

        public function serializeAs_FriendDeleteRequestMessage(output:IDataOutput):void
        {
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_FriendDeleteRequestMessage(input);
        }

        public function deserializeAs_FriendDeleteRequestMessage(input:IDataInput):void
        {
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of FriendDeleteRequestMessage.accountId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

