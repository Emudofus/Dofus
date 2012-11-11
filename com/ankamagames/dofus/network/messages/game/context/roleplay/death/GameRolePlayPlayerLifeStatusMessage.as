package com.ankamagames.dofus.network.messages.game.context.roleplay.death
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayPlayerLifeStatusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var state:uint = 0;
        public static const protocolId:uint = 5996;

        public function GameRolePlayPlayerLifeStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5996;
        }// end function

        public function initGameRolePlayPlayerLifeStatusMessage(param1:uint = 0) : GameRolePlayPlayerLifeStatusMessage
        {
            this.state = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.state = 0;
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
            this.serializeAs_GameRolePlayPlayerLifeStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayPlayerLifeStatusMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.state);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayPlayerLifeStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayPlayerLifeStatusMessage(param1:IDataInput) : void
        {
            this.state = param1.readByte();
            if (this.state < 0)
            {
                throw new Error("Forbidden value (" + this.state + ") on element of GameRolePlayPlayerLifeStatusMessage.state.");
            }
            return;
        }// end function

    }
}
