package com.ankamagames.dofus.network.messages.game.startup
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class StartupActionsObjetAttributionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1303;

        private var _isInitialized:Boolean = false;
        public var actionId:uint = 0;
        public var characterId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1303);
        }

        public function initStartupActionsObjetAttributionMessage(actionId:uint=0, characterId:uint=0):StartupActionsObjetAttributionMessage
        {
            this.actionId = actionId;
            this.characterId = characterId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.actionId = 0;
            this.characterId = 0;
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
            this.serializeAs_StartupActionsObjetAttributionMessage(output);
        }

        public function serializeAs_StartupActionsObjetAttributionMessage(output:IDataOutput):void
        {
            if (this.actionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actionId) + ") on element actionId.")));
            };
            output.writeInt(this.actionId);
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element characterId.")));
            };
            output.writeInt(this.characterId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_StartupActionsObjetAttributionMessage(input);
        }

        public function deserializeAs_StartupActionsObjetAttributionMessage(input:IDataInput):void
        {
            this.actionId = input.readInt();
            if (this.actionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actionId) + ") on element of StartupActionsObjetAttributionMessage.actionId.")));
            };
            this.characterId = input.readInt();
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element of StartupActionsObjetAttributionMessage.characterId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.startup

