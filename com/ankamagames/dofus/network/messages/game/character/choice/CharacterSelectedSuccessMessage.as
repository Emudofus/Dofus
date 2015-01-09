package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterSelectedSuccessMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 153;

        private var _isInitialized:Boolean = false;
        public var infos:CharacterBaseInformations;
        public var isCollectingStats:Boolean = false;

        public function CharacterSelectedSuccessMessage()
        {
            this.infos = new CharacterBaseInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (153);
        }

        public function initCharacterSelectedSuccessMessage(infos:CharacterBaseInformations=null, isCollectingStats:Boolean=false):CharacterSelectedSuccessMessage
        {
            this.infos = infos;
            this.isCollectingStats = isCollectingStats;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.infos = new CharacterBaseInformations();
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
            this.serializeAs_CharacterSelectedSuccessMessage(output);
        }

        public function serializeAs_CharacterSelectedSuccessMessage(output:ICustomDataOutput):void
        {
            this.infos.serializeAs_CharacterBaseInformations(output);
            output.writeBoolean(this.isCollectingStats);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterSelectedSuccessMessage(input);
        }

        public function deserializeAs_CharacterSelectedSuccessMessage(input:ICustomDataInput):void
        {
            this.infos = new CharacterBaseInformations();
            this.infos.deserialize(input);
            this.isCollectingStats = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

