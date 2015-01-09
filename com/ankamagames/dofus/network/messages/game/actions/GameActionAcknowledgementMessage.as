package com.ankamagames.dofus.network.messages.game.actions
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionAcknowledgementMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 957;

        private var _isInitialized:Boolean = false;
        public var valid:Boolean = false;
        public var actionId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (957);
        }

        public function initGameActionAcknowledgementMessage(valid:Boolean=false, actionId:int=0):GameActionAcknowledgementMessage
        {
            this.valid = valid;
            this.actionId = actionId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.valid = false;
            this.actionId = 0;
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
            this.serializeAs_GameActionAcknowledgementMessage(output);
        }

        public function serializeAs_GameActionAcknowledgementMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.valid);
            output.writeByte(this.actionId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionAcknowledgementMessage(input);
        }

        public function deserializeAs_GameActionAcknowledgementMessage(input:ICustomDataInput):void
        {
            this.valid = input.readBoolean();
            this.actionId = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions

