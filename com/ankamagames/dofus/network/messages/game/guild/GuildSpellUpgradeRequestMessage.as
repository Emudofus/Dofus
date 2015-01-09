package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildSpellUpgradeRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5699;

        private var _isInitialized:Boolean = false;
        public var spellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5699);
        }

        public function initGuildSpellUpgradeRequestMessage(spellId:uint=0):GuildSpellUpgradeRequestMessage
        {
            this.spellId = spellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.spellId = 0;
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
            this.serializeAs_GuildSpellUpgradeRequestMessage(output);
        }

        public function serializeAs_GuildSpellUpgradeRequestMessage(output:ICustomDataOutput):void
        {
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeInt(this.spellId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildSpellUpgradeRequestMessage(input);
        }

        public function deserializeAs_GuildSpellUpgradeRequestMessage(input:ICustomDataInput):void
        {
            this.spellId = input.readInt();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of GuildSpellUpgradeRequestMessage.spellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

