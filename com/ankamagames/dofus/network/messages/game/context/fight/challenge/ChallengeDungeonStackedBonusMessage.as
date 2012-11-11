package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChallengeDungeonStackedBonusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var xpBonus:uint = 0;
        public var dropBonus:uint = 0;
        public static const protocolId:uint = 6151;

        public function ChallengeDungeonStackedBonusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6151;
        }// end function

        public function initChallengeDungeonStackedBonusMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ChallengeDungeonStackedBonusMessage
        {
            this.dungeonId = param1;
            this.xpBonus = param2;
            this.dropBonus = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
            this.xpBonus = 0;
            this.dropBonus = 0;
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
            this.serializeAs_ChallengeDungeonStackedBonusMessage(param1);
            return;
        }// end function

        public function serializeAs_ChallengeDungeonStackedBonusMessage(param1:IDataOutput) : void
        {
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeInt(this.dungeonId);
            if (this.xpBonus < 0)
            {
                throw new Error("Forbidden value (" + this.xpBonus + ") on element xpBonus.");
            }
            param1.writeInt(this.xpBonus);
            if (this.dropBonus < 0)
            {
                throw new Error("Forbidden value (" + this.dropBonus + ") on element dropBonus.");
            }
            param1.writeInt(this.dropBonus);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChallengeDungeonStackedBonusMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChallengeDungeonStackedBonusMessage(param1:IDataInput) : void
        {
            this.dungeonId = param1.readInt();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of ChallengeDungeonStackedBonusMessage.dungeonId.");
            }
            this.xpBonus = param1.readInt();
            if (this.xpBonus < 0)
            {
                throw new Error("Forbidden value (" + this.xpBonus + ") on element of ChallengeDungeonStackedBonusMessage.xpBonus.");
            }
            this.dropBonus = param1.readInt();
            if (this.dropBonus < 0)
            {
                throw new Error("Forbidden value (" + this.dropBonus + ") on element of ChallengeDungeonStackedBonusMessage.dropBonus.");
            }
            return;
        }// end function

    }
}
