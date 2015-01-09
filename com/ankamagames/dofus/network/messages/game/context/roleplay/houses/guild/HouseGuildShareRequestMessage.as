package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

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
            this.serializeAs_HouseGuildShareRequestMessage(output);
        }

        public function serializeAs_HouseGuildShareRequestMessage(output:IDataOutput):void
        {
            output.writeBoolean(this.enable);
            if ((((this.rights < 0)) || ((this.rights > 0xFFFFFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element rights.")));
            };
            output.writeUnsignedInt(this.rights);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_HouseGuildShareRequestMessage(input);
        }

        public function deserializeAs_HouseGuildShareRequestMessage(input:IDataInput):void
        {
            this.enable = input.readBoolean();
            this.rights = input.readUnsignedInt();
            if ((((this.rights < 0)) || ((this.rights > 0xFFFFFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element of HouseGuildShareRequestMessage.rights.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild

