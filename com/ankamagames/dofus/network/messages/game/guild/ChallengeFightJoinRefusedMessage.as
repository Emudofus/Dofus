package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChallengeFightJoinRefusedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;
        public var reason:int = 0;
        public static const protocolId:uint = 5908;

        public function ChallengeFightJoinRefusedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5908;
        }// end function

        public function initChallengeFightJoinRefusedMessage(param1:uint = 0, param2:int = 0) : ChallengeFightJoinRefusedMessage
        {
            this.playerId = param1;
            this.reason = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.playerId = 0;
            this.reason = 0;
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
            this.serializeAs_ChallengeFightJoinRefusedMessage(param1);
            return;
        }// end function

        public function serializeAs_ChallengeFightJoinRefusedMessage(param1:IDataOutput) : void
        {
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            param1.writeByte(this.reason);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChallengeFightJoinRefusedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChallengeFightJoinRefusedMessage(param1:IDataInput) : void
        {
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of ChallengeFightJoinRefusedMessage.playerId.");
            }
            this.reason = param1.readByte();
            return;
        }// end function

    }
}
