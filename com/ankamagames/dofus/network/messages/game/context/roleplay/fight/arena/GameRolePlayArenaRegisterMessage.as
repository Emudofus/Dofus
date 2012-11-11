package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayArenaRegisterMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var battleMode:uint = 3;
        public static const protocolId:uint = 6280;

        public function GameRolePlayArenaRegisterMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6280;
        }// end function

        public function initGameRolePlayArenaRegisterMessage(param1:uint = 3) : GameRolePlayArenaRegisterMessage
        {
            this.battleMode = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
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
            this.serializeAs_GameRolePlayArenaRegisterMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayArenaRegisterMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.battleMode);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayArenaRegisterMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayArenaRegisterMessage(param1:IDataInput) : void
        {
            this.battleMode = param1.readInt();
            if (this.battleMode < 0)
            {
                throw new Error("Forbidden value (" + this.battleMode + ") on element of GameRolePlayArenaRegisterMessage.battleMode.");
            }
            return;
        }// end function

    }
}
