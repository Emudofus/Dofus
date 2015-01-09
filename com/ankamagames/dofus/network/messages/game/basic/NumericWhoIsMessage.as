package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class NumericWhoIsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6297;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;
        public var accountId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6297);
        }

        public function initNumericWhoIsMessage(playerId:uint=0, accountId:uint=0):NumericWhoIsMessage
        {
            this.playerId = playerId;
            this.accountId = accountId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.playerId = 0;
            this.accountId = 0;
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
            this.serializeAs_NumericWhoIsMessage(output);
        }

        public function serializeAs_NumericWhoIsMessage(output:ICustomDataOutput):void
        {
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NumericWhoIsMessage(input);
        }

        public function deserializeAs_NumericWhoIsMessage(input:ICustomDataInput):void
        {
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of NumericWhoIsMessage.playerId.")));
            };
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of NumericWhoIsMessage.accountId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

