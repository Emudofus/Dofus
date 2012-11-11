package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayAggressionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var attackerId:uint = 0;
        public var defenderId:uint = 0;
        public static const protocolId:uint = 6073;

        public function GameRolePlayAggressionMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6073;
        }// end function

        public function initGameRolePlayAggressionMessage(param1:uint = 0, param2:uint = 0) : GameRolePlayAggressionMessage
        {
            this.attackerId = param1;
            this.defenderId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.attackerId = 0;
            this.defenderId = 0;
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
            this.serializeAs_GameRolePlayAggressionMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayAggressionMessage(param1:IDataOutput) : void
        {
            if (this.attackerId < 0)
            {
                throw new Error("Forbidden value (" + this.attackerId + ") on element attackerId.");
            }
            param1.writeInt(this.attackerId);
            if (this.defenderId < 0)
            {
                throw new Error("Forbidden value (" + this.defenderId + ") on element defenderId.");
            }
            param1.writeInt(this.defenderId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayAggressionMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayAggressionMessage(param1:IDataInput) : void
        {
            this.attackerId = param1.readInt();
            if (this.attackerId < 0)
            {
                throw new Error("Forbidden value (" + this.attackerId + ") on element of GameRolePlayAggressionMessage.attackerId.");
            }
            this.defenderId = param1.readInt();
            if (this.defenderId < 0)
            {
                throw new Error("Forbidden value (" + this.defenderId + ") on element of GameRolePlayAggressionMessage.defenderId.");
            }
            return;
        }// end function

    }
}
