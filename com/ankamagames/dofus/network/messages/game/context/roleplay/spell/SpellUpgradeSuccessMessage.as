package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SpellUpgradeSuccessMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1201;

        private var _isInitialized:Boolean = false;
        public var spellId:int = 0;
        public var spellLevel:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1201);
        }

        public function initSpellUpgradeSuccessMessage(spellId:int=0, spellLevel:uint=0):SpellUpgradeSuccessMessage
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
            this.serializeAs_SpellUpgradeSuccessMessage(output);
        }

        public function serializeAs_SpellUpgradeSuccessMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.spellId);
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element spellLevel.")));
            };
            output.writeByte(this.spellLevel);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SpellUpgradeSuccessMessage(input);
        }

        public function deserializeAs_SpellUpgradeSuccessMessage(input:ICustomDataInput):void
        {
            this.spellId = input.readInt();
            this.spellLevel = input.readByte();
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element of SpellUpgradeSuccessMessage.spellLevel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.spell

