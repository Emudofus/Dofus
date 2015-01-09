package com.ankamagames.dofus.network.messages.game.actions
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class AbstractGameActionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1000;

        private var _isInitialized:Boolean = false;
        public var actionId:uint = 0;
        public var sourceId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1000);
        }

        public function initAbstractGameActionMessage(actionId:uint=0, sourceId:int=0):AbstractGameActionMessage
        {
            this.actionId = actionId;
            this.sourceId = sourceId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.actionId = 0;
            this.sourceId = 0;
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
            this.serializeAs_AbstractGameActionMessage(output);
        }

        public function serializeAs_AbstractGameActionMessage(output:IDataOutput):void
        {
            if (this.actionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actionId) + ") on element actionId.")));
            };
            output.writeShort(this.actionId);
            output.writeInt(this.sourceId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_AbstractGameActionMessage(input);
        }

        public function deserializeAs_AbstractGameActionMessage(input:IDataInput):void
        {
            this.actionId = input.readShort();
            if (this.actionId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actionId) + ") on element of AbstractGameActionMessage.actionId.")));
            };
            this.sourceId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions

