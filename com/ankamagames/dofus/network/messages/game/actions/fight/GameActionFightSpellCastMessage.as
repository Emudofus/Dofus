package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightSpellCastMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellId:uint = 0;
        public var spellLevel:uint = 0;
        public static const protocolId:uint = 1010;

        public function GameActionFightSpellCastMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1010;
        }// end function

        public function initGameActionFightSpellCastMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 1, param6:Boolean = false, param7:uint = 0, param8:uint = 0) : GameActionFightSpellCastMessage
        {
            super.initAbstractGameActionFightTargetedAbilityMessage(param1, param2, param3, param4, param5, param6);
            this.spellId = param7;
            this.spellLevel = param8;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.spellId = 0;
            this.spellLevel = 0;
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
            this.serializeAs_GameActionFightSpellCastMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightSpellCastMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            param1.writeShort(this.spellId);
            if (this.spellLevel < 1 || this.spellLevel > 6)
            {
                throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
            }
            param1.writeByte(this.spellLevel);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightSpellCastMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightSpellCastMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.spellId = param1.readShort();
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightSpellCastMessage.spellId.");
            }
            this.spellLevel = param1.readByte();
            if (this.spellLevel < 1 || this.spellLevel > 6)
            {
                throw new Error("Forbidden value (" + this.spellLevel + ") on element of GameActionFightSpellCastMessage.spellLevel.");
            }
            return;
        }// end function

    }
}
