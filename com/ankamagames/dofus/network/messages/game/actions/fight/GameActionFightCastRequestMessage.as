package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightCastRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellId:uint = 0;
        public var cellId:int = 0;
        public static const protocolId:uint = 1005;

        public function GameActionFightCastRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1005;
        }// end function

        public function initGameActionFightCastRequestMessage(param1:uint = 0, param2:int = 0) : GameActionFightCastRequestMessage
        {
            this.spellId = param1;
            this.cellId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.spellId = 0;
            this.cellId = 0;
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
            this.serializeAs_GameActionFightCastRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightCastRequestMessage(param1:IDataOutput) : void
        {
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            param1.writeShort(this.spellId);
            if (this.cellId < -1 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
            }
            param1.writeShort(this.cellId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightCastRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightCastRequestMessage(param1:IDataInput) : void
        {
            this.spellId = param1.readShort();
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastRequestMessage.spellId.");
            }
            this.cellId = param1.readShort();
            if (this.cellId < -1 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionFightCastRequestMessage.cellId.");
            }
            return;
        }// end function

    }
}
