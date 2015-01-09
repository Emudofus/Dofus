package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class FighterStatsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6322;

        private var _isInitialized:Boolean = false;
        public var stats:CharacterCharacteristicsInformations;

        public function FighterStatsListMessage()
        {
            this.stats = new CharacterCharacteristicsInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6322);
        }

        public function initFighterStatsListMessage(stats:CharacterCharacteristicsInformations=null):FighterStatsListMessage
        {
            this.stats = stats;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.stats = new CharacterCharacteristicsInformations();
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
            this.serializeAs_FighterStatsListMessage(output);
        }

        public function serializeAs_FighterStatsListMessage(output:ICustomDataOutput):void
        {
            this.stats.serializeAs_CharacterCharacteristicsInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FighterStatsListMessage(input);
        }

        public function deserializeAs_FighterStatsListMessage(input:ICustomDataInput):void
        {
            this.stats = new CharacterCharacteristicsInformations();
            this.stats.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.stats

