package com.ankamagames.dofus.network.messages.game.context.roleplay.visual
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlaySpellAnimMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6114;

        private var _isInitialized:Boolean = false;
        public var casterId:int = 0;
        public var targetCellId:uint = 0;
        public var spellId:uint = 0;
        public var spellLevel:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6114);
        }

        public function initGameRolePlaySpellAnimMessage(casterId:int=0, targetCellId:uint=0, spellId:uint=0, spellLevel:uint=0):GameRolePlaySpellAnimMessage
        {
            this.casterId = casterId;
            this.targetCellId = targetCellId;
            this.spellId = spellId;
            this.spellLevel = spellLevel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.casterId = 0;
            this.targetCellId = 0;
            this.spellId = 0;
            this.spellLevel = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlaySpellAnimMessage(output);
        }

        public function serializeAs_GameRolePlaySpellAnimMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.casterId);
            if ((((this.targetCellId < 0)) || ((this.targetCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.targetCellId) + ") on element targetCellId.")));
            };
            output.writeVarShort(this.targetCellId);
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeVarShort(this.spellId);
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element spellLevel.")));
            };
            output.writeByte(this.spellLevel);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlaySpellAnimMessage(input);
        }

        public function deserializeAs_GameRolePlaySpellAnimMessage(input:ICustomDataInput):void
        {
            this.casterId = input.readInt();
            this.targetCellId = input.readVarUhShort();
            if ((((this.targetCellId < 0)) || ((this.targetCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.targetCellId) + ") on element of GameRolePlaySpellAnimMessage.targetCellId.")));
            };
            this.spellId = input.readVarUhShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of GameRolePlaySpellAnimMessage.spellId.")));
            };
            this.spellLevel = input.readByte();
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element of GameRolePlaySpellAnimMessage.spellLevel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.visual

