package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

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
            this.serializeAs_ChallengeTargetsListRequestMessage(output);
        }

        public function serializeAs_ChallengeTargetsListRequestMessage(output:ICustomDataOutput):void
        {
            if (this.challengeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.challengeId) + ") on element challengeId.")));
            };
            output.writeVarShort(this.challengeId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChallengeTargetsListRequestMessage(input);
        }

        public function deserializeAs_ChallengeTargetsListRequestMessage(input:ICustomDataInput):void
        {
            this.challengeId = input.readVarUhShort();
            if (this.challengeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.challengeId) + ") on element of ChallengeTargetsListRequestMessage.challengeId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight.challenge

