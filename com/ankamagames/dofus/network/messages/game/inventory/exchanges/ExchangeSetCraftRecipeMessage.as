package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeSetCraftRecipeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6389;

        private var _isInitialized:Boolean = false;
        public var objectGID:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6389);
        }

        public function initExchangeSetCraftRecipeMessage(objectGID:uint=0):ExchangeSetCraftRecipeMessage
        {
            this.objectGID = objectGID;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectGID = 0;
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
            this.serializeAs_ExchangeSetCraftRecipeMessage(output);
        }

        public function serializeAs_ExchangeSetCraftRecipeMessage(output:ICustomDataOutput):void
        {
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element objectGID.")));
            };
            output.writeVarShort(this.objectGID);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeSetCraftRecipeMessage(input);
        }

        public function deserializeAs_ExchangeSetCraftRecipeMessage(input:ICustomDataInput):void
        {
            this.objectGID = input.readVarUhShort();
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element of ExchangeSetCraftRecipeMessage.objectGID.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

