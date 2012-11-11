package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightNoSpellCastMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellLevelId:uint = 0;
        public static const protocolId:uint = 6132;

        public function GameActionFightNoSpellCastMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6132;
        }// end function

        public function initGameActionFightNoSpellCastMessage(param1:uint = 0) : GameActionFightNoSpellCastMessage
        {
            this.spellLevelId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.spellLevelId = 0;
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
            this.serializeAs_GameActionFightNoSpellCastMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightNoSpellCastMessage(param1:IDataOutput) : void
        {
            if (this.spellLevelId < 0)
            {
                throw new Error("Forbidden value (" + this.spellLevelId + ") on element spellLevelId.");
            }
            param1.writeInt(this.spellLevelId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightNoSpellCastMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightNoSpellCastMessage(param1:IDataInput) : void
        {
            this.spellLevelId = param1.readInt();
            if (this.spellLevelId < 0)
            {
                throw new Error("Forbidden value (" + this.spellLevelId + ") on element of GameActionFightNoSpellCastMessage.spellLevelId.");
            }
            return;
        }// end function

    }
}
