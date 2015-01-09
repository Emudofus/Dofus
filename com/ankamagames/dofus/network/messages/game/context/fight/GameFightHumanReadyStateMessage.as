package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightHumanReadyStateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 740;

        private var _isInitialized:Boolean = false;
        public var characterId:uint = 0;
        public var isReady:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (740);
        }

        public function initGameFightHumanReadyStateMessage(characterId:uint=0, isReady:Boolean=false):GameFightHumanReadyStateMessage
        {
            this.characterId = characterId;
            this.isReady = isReady;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.characterId = 0;
            this.isReady = false;
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
            this.serializeAs_GameFightHumanReadyStateMessage(output);
        }

        public function serializeAs_GameFightHumanReadyStateMessage(output:ICustomDataOutput):void
        {
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element characterId.")));
            };
            output.writeVarInt(this.characterId);
            output.writeBoolean(this.isReady);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightHumanReadyStateMessage(input);
        }

        public function deserializeAs_GameFightHumanReadyStateMessage(input:ICustomDataInput):void
        {
            this.characterId = input.readVarUhInt();
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element of GameFightHumanReadyStateMessage.characterId.")));
            };
            this.isReady = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

