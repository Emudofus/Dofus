package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SpellItemBoostMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6011;

        private var _isInitialized:Boolean = false;
        public var statId:uint = 0;
        public var spellId:uint = 0;
        public var value:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6011);
        }

        public function initSpellItemBoostMessage(statId:uint=0, spellId:uint=0, value:int=0):SpellItemBoostMessage
        {
            this.statId = statId;
            this.spellId = spellId;
            this.value = value;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.statId = 0;
            this.spellId = 0;
            this.value = 0;
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
            this.serializeAs_SpellItemBoostMessage(output);
        }

        public function serializeAs_SpellItemBoostMessage(output:ICustomDataOutput):void
        {
            if (this.statId < 0)
            {
                throw (new Error((("Forbidden value (" + this.statId) + ") on element statId.")));
            };
            output.writeVarInt(this.statId);
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeVarShort(this.spellId);
            output.writeVarShort(this.value);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SpellItemBoostMessage(input);
        }

        public function deserializeAs_SpellItemBoostMessage(input:ICustomDataInput):void
        {
            this.statId = input.readVarUhInt();
            if (this.statId < 0)
            {
                throw (new Error((("Forbidden value (" + this.statId) + ") on element of SpellItemBoostMessage.statId.")));
            };
            this.spellId = input.readVarUhShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of SpellItemBoostMessage.spellId.")));
            };
            this.value = input.readVarShort();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.spell

