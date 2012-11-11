package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayDelayedActionFinishedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var delayedCharacterId:int = 0;
        public var delayTypeId:uint = 0;
        public static const protocolId:uint = 6150;

        public function GameRolePlayDelayedActionFinishedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6150;
        }// end function

        public function initGameRolePlayDelayedActionFinishedMessage(param1:int = 0, param2:uint = 0) : GameRolePlayDelayedActionFinishedMessage
        {
            this.delayedCharacterId = param1;
            this.delayTypeId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.delayedCharacterId = 0;
            this.delayTypeId = 0;
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
            this.serializeAs_GameRolePlayDelayedActionFinishedMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayDelayedActionFinishedMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.delayedCharacterId);
            param1.writeByte(this.delayTypeId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayDelayedActionFinishedMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayDelayedActionFinishedMessage(param1:IDataInput) : void
        {
            this.delayedCharacterId = param1.readInt();
            this.delayTypeId = param1.readByte();
            if (this.delayTypeId < 0)
            {
                throw new Error("Forbidden value (" + this.delayTypeId + ") on element of GameRolePlayDelayedActionFinishedMessage.delayTypeId.");
            }
            return;
        }// end function

    }
}
