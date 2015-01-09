package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterSelectionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 152;

        private var _isInitialized:Boolean = false;
        public var id:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (152);
        }

        public function initCharacterSelectionMessage(id:int=0):CharacterSelectionMessage
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
            this.serializeAs_CharacterSelectionMessage(output);
        }

        public function serializeAs_CharacterSelectionMessage(output:ICustomDataOutput):void
        {
            if ((((this.id < 1)) || ((this.id > 2147483647))))
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeInt(this.id);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterSelectionMessage(input);
        }

        public function deserializeAs_CharacterSelectionMessage(input:ICustomDataInput):void
        {
            this.id = input.readInt();
            if ((((this.id < 1)) || ((this.id > 2147483647))))
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of CharacterSelectionMessage.id.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

