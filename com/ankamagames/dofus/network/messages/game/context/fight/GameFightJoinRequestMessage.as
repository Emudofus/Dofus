package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightJoinRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fighterId:int = 0;
        public var fightId:int = 0;
        public static const protocolId:uint = 701;

        public function GameFightJoinRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 701;
        }// end function

        public function initGameFightJoinRequestMessage(param1:int = 0, param2:int = 0) : GameFightJoinRequestMessage
        {
            this.fighterId = param1;
            this.fightId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fighterId = 0;
            this.fightId = 0;
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
            this.serializeAs_GameFightJoinRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightJoinRequestMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.fighterId);
            param1.writeInt(this.fightId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightJoinRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightJoinRequestMessage(param1:IDataInput) : void
        {
            this.fighterId = param1.readInt();
            this.fightId = param1.readInt();
            return;
        }// end function

    }
}
