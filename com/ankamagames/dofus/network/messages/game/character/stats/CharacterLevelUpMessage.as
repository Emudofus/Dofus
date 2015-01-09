package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterLevelUpMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5670;

        private var _isInitialized:Boolean = false;
        public var newLevel:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5670);
        }

        public function initCharacterLevelUpMessage(newLevel:uint=0):CharacterLevelUpMessage
        {
            this.newLevel = newLevel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.newLevel = 0;
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
            this.serializeAs_CharacterLevelUpMessage(output);
        }

        public function serializeAs_CharacterLevelUpMessage(output:ICustomDataOutput):void
        {
            if ((((this.newLevel < 2)) || ((this.newLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.newLevel) + ") on element newLevel.")));
            };
            output.writeByte(this.newLevel);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterLevelUpMessage(input);
        }

        public function deserializeAs_CharacterLevelUpMessage(input:ICustomDataInput):void
        {
            this.newLevel = input.readUnsignedByte();
            if ((((this.newLevel < 2)) || ((this.newLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.newLevel) + ") on element of CharacterLevelUpMessage.newLevel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.stats

