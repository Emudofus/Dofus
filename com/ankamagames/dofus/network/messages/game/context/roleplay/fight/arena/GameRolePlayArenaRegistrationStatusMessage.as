package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayArenaRegistrationStatusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var registered:Boolean = false;
        public var step:uint = 0;
        public var battleMode:uint = 3;
        public static const protocolId:uint = 6284;

        public function GameRolePlayArenaRegistrationStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6284;
        }// end function

        public function initGameRolePlayArenaRegistrationStatusMessage(param1:Boolean = false, param2:uint = 0, param3:uint = 3) : GameRolePlayArenaRegistrationStatusMessage
        {
            this.registered = param1;
            this.step = param2;
            this.battleMode = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.registered = false;
            this.step = 0;
            this.battleMode = 3;
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
            this.serializeAs_GameRolePlayArenaRegistrationStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayArenaRegistrationStatusMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.registered);
            param1.writeByte(this.step);
            param1.writeInt(this.battleMode);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayArenaRegistrationStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayArenaRegistrationStatusMessage(param1:IDataInput) : void
        {
            this.registered = param1.readBoolean();
            this.step = param1.readByte();
            if (this.step < 0)
            {
                throw new Error("Forbidden value (" + this.step + ") on element of GameRolePlayArenaRegistrationStatusMessage.step.");
            }
            this.battleMode = param1.readInt();
            if (this.battleMode < 0)
            {
                throw new Error("Forbidden value (" + this.battleMode + ") on element of GameRolePlayArenaRegistrationStatusMessage.battleMode.");
            }
            return;
        }// end function

    }
}
