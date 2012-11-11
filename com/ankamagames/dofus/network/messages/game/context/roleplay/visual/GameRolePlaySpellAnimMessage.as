package com.ankamagames.dofus.network.messages.game.context.roleplay.visual
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlaySpellAnimMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var casterId:int = 0;
        public var targetCellId:uint = 0;
        public var spellId:uint = 0;
        public var spellLevel:uint = 0;
        public static const protocolId:uint = 6114;

        public function GameRolePlaySpellAnimMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6114;
        }// end function

        public function initGameRolePlaySpellAnimMessage(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : GameRolePlaySpellAnimMessage
        {
            this.casterId = param1;
            this.targetCellId = param2;
            this.spellId = param3;
            this.spellLevel = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.casterId = 0;
            this.targetCellId = 0;
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlaySpellAnimMessage(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlaySpellAnimMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.casterId);
            if (this.targetCellId < 0 || this.targetCellId > 559)
            {
                throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
            }
            param1.writeShort(this.targetCellId);
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

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlaySpellAnimMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlaySpellAnimMessage(param1:IDataInput) : void
        {
            this.casterId = param1.readInt();
            this.targetCellId = param1.readShort();
            if (this.targetCellId < 0 || this.targetCellId > 559)
            {
                throw new Error("Forbidden value (" + this.targetCellId + ") on element of GameRolePlaySpellAnimMessage.targetCellId.");
            }
            this.spellId = param1.readShort();
            if (this.spellId < 0)
            {
                throw new Error("Forbidden value (" + this.spellId + ") on element of GameRolePlaySpellAnimMessage.spellId.");
            }
            this.spellLevel = param1.readByte();
            if (this.spellLevel < 1 || this.spellLevel > 6)
            {
                throw new Error("Forbidden value (" + this.spellLevel + ") on element of GameRolePlaySpellAnimMessage.spellLevel.");
            }
            return;
        }// end function

    }
}
