package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChallengeInfoMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var challengeId:uint = 0;
        public var targetId:int = 0;
        public var baseXpBonus:uint = 0;
        public var extraXpBonus:uint = 0;
        public var baseDropBonus:uint = 0;
        public var extraDropBonus:uint = 0;
        public static const protocolId:uint = 6022;

        public function ChallengeInfoMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6022;
        }// end function

        public function initChallengeInfoMessage(param1:uint = 0, param2:int = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) : ChallengeInfoMessage
        {
            this.challengeId = param1;
            this.targetId = param2;
            this.baseXpBonus = param3;
            this.extraXpBonus = param4;
            this.baseDropBonus = param5;
            this.extraDropBonus = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.challengeId = 0;
            this.targetId = 0;
            this.baseXpBonus = 0;
            this.extraXpBonus = 0;
            this.baseDropBonus = 0;
            this.extraDropBonus = 0;
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
            this.serializeAs_ChallengeInfoMessage(param1);
            return;
        }// end function

        public function serializeAs_ChallengeInfoMessage(param1:IDataOutput) : void
        {
            if (this.challengeId < 0)
            {
                throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
            }
            param1.writeByte(this.challengeId);
            param1.writeInt(this.targetId);
            if (this.baseXpBonus < 0)
            {
                throw new Error("Forbidden value (" + this.baseXpBonus + ") on element baseXpBonus.");
            }
            param1.writeInt(this.baseXpBonus);
            if (this.extraXpBonus < 0)
            {
                throw new Error("Forbidden value (" + this.extraXpBonus + ") on element extraXpBonus.");
            }
            param1.writeInt(this.extraXpBonus);
            if (this.baseDropBonus < 0)
            {
                throw new Error("Forbidden value (" + this.baseDropBonus + ") on element baseDropBonus.");
            }
            param1.writeInt(this.baseDropBonus);
            if (this.extraDropBonus < 0)
            {
                throw new Error("Forbidden value (" + this.extraDropBonus + ") on element extraDropBonus.");
            }
            param1.writeInt(this.extraDropBonus);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChallengeInfoMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChallengeInfoMessage(param1:IDataInput) : void
        {
            this.challengeId = param1.readByte();
            if (this.challengeId < 0)
            {
                throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeInfoMessage.challengeId.");
            }
            this.targetId = param1.readInt();
            this.baseXpBonus = param1.readInt();
            if (this.baseXpBonus < 0)
            {
                throw new Error("Forbidden value (" + this.baseXpBonus + ") on element of ChallengeInfoMessage.baseXpBonus.");
            }
            this.extraXpBonus = param1.readInt();
            if (this.extraXpBonus < 0)
            {
                throw new Error("Forbidden value (" + this.extraXpBonus + ") on element of ChallengeInfoMessage.extraXpBonus.");
            }
            this.baseDropBonus = param1.readInt();
            if (this.baseDropBonus < 0)
            {
                throw new Error("Forbidden value (" + this.baseDropBonus + ") on element of ChallengeInfoMessage.baseDropBonus.");
            }
            this.extraDropBonus = param1.readInt();
            if (this.extraDropBonus < 0)
            {
                throw new Error("Forbidden value (" + this.extraDropBonus + ") on element of ChallengeInfoMessage.extraDropBonus.");
            }
            return;
        }// end function

    }
}
