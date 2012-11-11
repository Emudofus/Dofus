package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightDispellSpellMessage extends GameActionFightDispellMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellId:uint = 0;
        public static const protocolId:uint = 6176;

        public function GameActionFightDispellSpellMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6176;
        }// end function

        public function initGameActionFightDispellSpellMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : GameActionFightDispellSpellMessage
        {
            super.initGameActionFightDispellMessage(param1, param2, param3);
            this.spellId = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.spellId = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameActionFightDispellSpellMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightDispellSpellMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GameActionFightDispellMessage(param1);
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            param1.writeInt(this.spellId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightDispellSpellMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightDispellSpellMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.spellId = param1.readInt();
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightDispellSpellMessage.spellId.");
            }
            return;
        }// end function

    }
}
