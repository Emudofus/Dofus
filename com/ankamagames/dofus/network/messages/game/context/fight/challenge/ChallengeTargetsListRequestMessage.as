package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ChallengeTargetsListRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5614;

        private var _isInitialized:Boolean = false;
        public var challengeId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5614);
        }

        public function initChallengeTargetsListRequestMessage(challengeId:uint=0):ChallengeTargetsListRequestMessage
        {
            this.challengeId = challengeId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.challengeId = 0;
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
            this.serializeAs_ChallengeTargetsListRequestMessage(output);
        }

        public function serializeAs_ChallengeTargetsListRequestMessage(output:IDataOutput):void
        {
            if (this.challengeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.challengeId) + ") on element challengeId.")));
            };
            output.writeShort(this.challengeId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ChallengeTargetsListRequestMessage(input);
        }

        public function deserializeAs_ChallengeTargetsListRequestMessage(input:IDataInput):void
        {
            this.challengeId = input.readShort();
            if (this.challengeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.challengeId) + ") on element of ChallengeTargetsListRequestMessage.challengeId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight.challenge

