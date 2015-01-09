package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseGuildShareRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5704;

        private var _isInitialized:Boolean = false;
        public var enable:Boolean = false;
        public var rights:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5704);
        }

        public function initHouseGuildShareRequestMessage(enable:Boolean=false, rights:uint=0):HouseGuildShareRequestMessage
        {
            this.enable = enable;
            this.rights = rights;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.enable = false;
            this.rights = 0;
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
            this.serializeAs_HouseGuildShareRequestMessage(output);
        }

        public function serializeAs_HouseGuildShareRequestMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.enable);
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element rights.")));
            };
            output.writeVarInt(this.rights);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseGuildShareRequestMessage(input);
        }

        public function deserializeAs_HouseGuildShareRequestMessage(input:ICustomDataInput):void
        {
            this.enable = input.readBoolean();
            this.rights = input.readVarUhInt();
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element of HouseGuildShareRequestMessage.rights.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild

