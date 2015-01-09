package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class IgnoredDeleteRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5680;

        private var _isInitialized:Boolean = false;
        public var accountId:uint = 0;
        public var session:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5680);
        }

        public function initIgnoredDeleteRequestMessage(accountId:uint=0, session:Boolean=false):IgnoredDeleteRequestMessage
        {
            this.accountId = accountId;
            this.session = session;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.accountId = 0;
            this.session = false;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_IgnoredDeleteRequestMessage(output);
        }

        public function serializeAs_IgnoredDeleteRequestMessage(output:ICustomDataOutput):void
        {
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
            output.writeBoolean(this.session);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IgnoredDeleteRequestMessage(input);
        }

        public function deserializeAs_IgnoredDeleteRequestMessage(input:ICustomDataInput):void
        {
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of IgnoredDeleteRequestMessage.accountId.")));
            };
            this.session = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

