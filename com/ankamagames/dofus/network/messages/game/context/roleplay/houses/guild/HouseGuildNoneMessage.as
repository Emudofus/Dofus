package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseGuildNoneMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5701;

        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5701);
        }

        public function initHouseGuildNoneMessage(houseId:uint=0):HouseGuildNoneMessage
        {
            this.houseId = houseId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.houseId = 0;
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
            this.serializeAs_HouseGuildNoneMessage(output);
        }

        public function serializeAs_HouseGuildNoneMessage(output:ICustomDataOutput):void
        {
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeVarShort(this.houseId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseGuildNoneMessage(input);
        }

        public function deserializeAs_HouseGuildNoneMessage(input:ICustomDataInput):void
        {
            this.houseId = input.readVarUhShort();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of HouseGuildNoneMessage.houseId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild

