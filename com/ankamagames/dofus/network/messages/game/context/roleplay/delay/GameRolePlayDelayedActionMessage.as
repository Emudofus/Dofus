package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayDelayedActionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var delayedCharacterId:int = 0;
        public var delayTypeId:uint = 0;
        public var delayDuration:uint = 0;
        public static const protocolId:uint = 6153;

        public function GameRolePlayDelayedActionMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6153;
        }// end function

        public function initGameRolePlayDelayedActionMessage(param1:int = 0, param2:uint = 0, param3:uint = 0) : GameRolePlayDelayedActionMessage
        {
            this.delayedCharacterId = param1;
            this.delayTypeId = param2;
            this.delayDuration = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.delayedCharacterId = 0;
            this.delayTypeId = 0;
            this.delayDuration = 0;
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
            this.serializeAs_GameRolePlayDelayedActionMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayDelayedActionMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.delayedCharacterId);
            param1.writeByte(this.delayTypeId);
            if (this.delayDuration < 0)
            {
                throw new Error("Forbidden value (" + this.delayDuration + ") on element delayDuration.");
            }
            param1.writeInt(this.delayDuration);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayDelayedActionMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayDelayedActionMessage(param1:IDataInput) : void
        {
            this.delayedCharacterId = param1.readInt();
            this.delayTypeId = param1.readByte();
            if (this.delayTypeId < 0)
            {
                throw new Error("Forbidden value (" + this.delayTypeId + ") on element of GameRolePlayDelayedActionMessage.delayTypeId.");
            }
            this.delayDuration = param1.readInt();
            if (this.delayDuration < 0)
            {
                throw new Error("Forbidden value (" + this.delayDuration + ") on element of GameRolePlayDelayedActionMessage.delayDuration.");
            }
            return;
        }// end function

    }
}
