package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChallengeResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var challengeId:uint = 0;
        public var success:Boolean = false;
        public static const protocolId:uint = 6019;

        public function ChallengeResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6019;
        }// end function

        public function initChallengeResultMessage(param1:uint = 0, param2:Boolean = false) : ChallengeResultMessage
        {
            this.challengeId = param1;
            this.success = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.challengeId = 0;
            this.success = false;
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
            this.serializeAs_ChallengeResultMessage(param1);
            return;
        }// end function

        public function serializeAs_ChallengeResultMessage(param1:IDataOutput) : void
        {
            if (this.challengeId < 0)
            {
                throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
            }
            param1.writeByte(this.challengeId);
            param1.writeBoolean(this.success);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChallengeResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChallengeResultMessage(param1:IDataInput) : void
        {
            this.challengeId = param1.readByte();
            if (this.challengeId < 0)
            {
                throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeResultMessage.challengeId.");
            }
            this.success = param1.readBoolean();
            return;
        }// end function

    }
}
