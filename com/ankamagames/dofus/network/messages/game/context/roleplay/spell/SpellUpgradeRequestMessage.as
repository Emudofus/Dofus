package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class SpellUpgradeRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5608;

        private var _isInitialized:Boolean = false;
        public var spellId:uint = 0;
        public var spellLevel:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5608);
        }

        public function initSpellUpgradeRequestMessage(spellId:uint=0, spellLevel:uint=0):SpellUpgradeRequestMessage
        {
            this.spellId = spellId;
            this.spellLevel = spellLevel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.spellId = 0;
            this.spellLevel = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_SpellUpgradeRequestMessage(output);
        }

        public function serializeAs_SpellUpgradeRequestMessage(output:IDataOutput):void
        {
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeShort(this.spellId);
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element spellLevel.")));
            };
            output.writeByte(this.spellLevel);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_SpellUpgradeRequestMessage(input);
        }

        public function deserializeAs_SpellUpgradeRequestMessage(input:IDataInput):void
        {
            this.spellId = input.readShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of SpellUpgradeRequestMessage.spellId.")));
            };
            this.spellLevel = input.readByte();
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element of SpellUpgradeRequestMessage.spellLevel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.spell

