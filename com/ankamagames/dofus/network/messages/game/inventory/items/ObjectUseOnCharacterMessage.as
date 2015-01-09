package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectUseOnCharacterMessage extends ObjectUseMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 3003;

        private var _isInitialized:Boolean = false;
        public var characterId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (3003);
        }

        public function initObjectUseOnCharacterMessage(objectUID:uint=0, characterId:uint=0):ObjectUseOnCharacterMessage
        {
            super.initObjectUseMessage(objectUID);
            this.characterId = characterId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectUseOnCharacterMessage(output);
        }

        public function serializeAs_ObjectUseOnCharacterMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ObjectUseMessage(output);
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element characterId.")));
            };
            output.writeVarInt(this.characterId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectUseOnCharacterMessage(input);
        }

        public function deserializeAs_ObjectUseOnCharacterMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.characterId = input.readVarUhInt();
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element of ObjectUseOnCharacterMessage.characterId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

