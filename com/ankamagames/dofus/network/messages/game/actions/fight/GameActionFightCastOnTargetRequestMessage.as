package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightCastOnTargetRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellId:uint = 0;
        public var targetId:int = 0;
        public static const protocolId:uint = 6330;

        public function GameActionFightCastOnTargetRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6330;
        }// end function

        public function initGameActionFightCastOnTargetRequestMessage(param1:uint = 0, param2:int = 0) : GameActionFightCastOnTargetRequestMessage
        {
            this.spellId = param1;
            this.targetId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.spellId = 0;
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
            this.serializeAs_GameActionFightCastOnTargetRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightCastOnTargetRequestMessage(param1:IDataOutput) : void
        {
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            param1.writeShort(this.spellId);
            param1.writeInt(this.targetId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightCastOnTargetRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightCastOnTargetRequestMessage(param1:IDataInput) : void
        {
            this.spellId = param1.readShort();
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastOnTargetRequestMessage.spellId.");
            }
            this.targetId = param1.readInt();
            return;
        }// end function

    }
}
