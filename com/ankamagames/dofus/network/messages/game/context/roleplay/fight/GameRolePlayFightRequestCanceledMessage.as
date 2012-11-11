package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayFightRequestCanceledMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:int = 0;
        public var sourceId:uint = 0;
        public var targetId:int = 0;
        public static const protocolId:uint = 5822;

        public function GameRolePlayFightRequestCanceledMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5822;
        }// end function

        public function initGameRolePlayFightRequestCanceledMessage(param1:int = 0, param2:uint = 0, param3:int = 0) : GameRolePlayFightRequestCanceledMessage
        {
            this.fightId = param1;
            this.sourceId = param2;
            this.targetId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.sourceId = 0;
            this.targetId = 0;
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
            this.serializeAs_GameRolePlayFightRequestCanceledMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayFightRequestCanceledMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.fightId);
            if (this.sourceId < 0)
            {
                throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
            }
            param1.writeInt(this.sourceId);
            param1.writeInt(this.targetId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayFightRequestCanceledMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayFightRequestCanceledMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readInt();
            this.sourceId = param1.readInt();
            if (this.sourceId < 0)
            {
                throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayFightRequestCanceledMessage.sourceId.");
            }
            this.targetId = param1.readInt();
            return;
        }// end function

    }
}
