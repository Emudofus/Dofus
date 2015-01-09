package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ChallengeTargetUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6123;

        private var _isInitialized:Boolean = false;
        public var challengeId:uint = 0;
        public var targetId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6123);
        }

        public function initChallengeTargetUpdateMessage(challengeId:uint=0, targetId:int=0):ChallengeTargetUpdateMessage
        {
            this.challengeId = challengeId;
            this.targetId = targetId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.challengeId = 0;
            this.targetId = 0;
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
            this.serializeAs_ChallengeTargetUpdateMessage(output);
        }

        public function serializeAs_ChallengeTargetUpdateMessage(output:ICustomDataOutput):void
        {
            if (this.challengeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.challengeId) + ") on element challengeId.")));
            };
            output.writeVarShort(this.challengeId);
            output.writeInt(this.targetId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChallengeTargetUpdateMessage(input);
        }

        public function deserializeAs_ChallengeTargetUpdateMessage(input:ICustomDataInput):void
        {
            this.challengeId = input.readVarUhShort();
            if (this.challengeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.challengeId) + ") on element of ChallengeTargetUpdateMessage.challengeId.")));
            };
            this.targetId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight.challenge

