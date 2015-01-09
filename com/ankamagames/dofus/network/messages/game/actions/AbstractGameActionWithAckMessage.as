package com.ankamagames.dofus.network.messages.game.actions
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AbstractGameActionWithAckMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1001;

        private var _isInitialized:Boolean = false;
        public var waitAckId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (1001);
        }

        public function initAbstractGameActionWithAckMessage(actionId:uint=0, sourceId:int=0, waitAckId:int=0):AbstractGameActionWithAckMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.waitAckId = waitAckId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.waitAckId = 0;
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
            this.serializeAs_AbstractGameActionWithAckMessage(output);
        }

        public function serializeAs_AbstractGameActionWithAckMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeShort(this.waitAckId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AbstractGameActionWithAckMessage(input);
        }

        public function deserializeAs_AbstractGameActionWithAckMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.waitAckId = input.readShort();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions

