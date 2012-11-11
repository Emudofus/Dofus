package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightOptionStateUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var teamId:uint = 2;
        public var option:uint = 3;
        public var state:Boolean = false;
        public static const protocolId:uint = 5927;

        public function GameFightOptionStateUpdateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5927;
        }// end function

        public function initGameFightOptionStateUpdateMessage(param1:uint = 0, param2:uint = 2, param3:uint = 3, param4:Boolean = false) : GameFightOptionStateUpdateMessage
        {
            this.fightId = param1;
            this.teamId = param2;
            this.option = param3;
            this.state = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.teamId = 2;
            this.option = 3;
            this.state = false;
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
            this.serializeAs_GameFightOptionStateUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightOptionStateUpdateMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeShort(this.fightId);
            param1.writeByte(this.teamId);
            param1.writeByte(this.option);
            param1.writeBoolean(this.state);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightOptionStateUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightOptionStateUpdateMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readShort();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightOptionStateUpdateMessage.fightId.");
            }
            this.teamId = param1.readByte();
            if (this.teamId < 0)
            {
                throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightOptionStateUpdateMessage.teamId.");
            }
            this.option = param1.readByte();
            if (this.option < 0)
            {
                throw new Error("Forbidden value (" + this.option + ") on element of GameFightOptionStateUpdateMessage.option.");
            }
            this.state = param1.readBoolean();
            return;
        }// end function

    }
}
