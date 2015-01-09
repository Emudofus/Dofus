package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildFightLeaveRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5715;

        private var _isInitialized:Boolean = false;
        public var taxCollectorId:uint = 0;
        public var characterId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5715);
        }

        public function initGuildFightLeaveRequestMessage(taxCollectorId:uint=0, characterId:uint=0):GuildFightLeaveRequestMessage
        {
            this.taxCollectorId = taxCollectorId;
            this.characterId = characterId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.taxCollectorId = 0;
            this.characterId = 0;
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
            this.serializeAs_GuildFightLeaveRequestMessage(output);
        }

        public function serializeAs_GuildFightLeaveRequestMessage(output:ICustomDataOutput):void
        {
            if (this.taxCollectorId < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorId) + ") on element taxCollectorId.")));
            };
            output.writeInt(this.taxCollectorId);
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element characterId.")));
            };
            output.writeVarInt(this.characterId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildFightLeaveRequestMessage(input);
        }

        public function deserializeAs_GuildFightLeaveRequestMessage(input:ICustomDataInput):void
        {
            this.taxCollectorId = input.readInt();
            if (this.taxCollectorId < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorId) + ") on element of GuildFightLeaveRequestMessage.taxCollectorId.")));
            };
            this.characterId = input.readVarUhInt();
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element of GuildFightLeaveRequestMessage.characterId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

