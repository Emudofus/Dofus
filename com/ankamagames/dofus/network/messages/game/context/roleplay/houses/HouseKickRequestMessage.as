package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseKickRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5698;

        private var _isInitialized:Boolean = false;
        public var id:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5698);
        }

        public function initHouseKickRequestMessage(id:uint=0):HouseKickRequestMessage
        {
            this.id = id;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = 0;
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
            this.serializeAs_HouseKickRequestMessage(output);
        }

        public function serializeAs_HouseKickRequestMessage(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarInt(this.id);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseKickRequestMessage(input);
        }

        public function deserializeAs_HouseKickRequestMessage(input:ICustomDataInput):void
        {
            this.id = input.readVarUhInt();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of HouseKickRequestMessage.id.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

