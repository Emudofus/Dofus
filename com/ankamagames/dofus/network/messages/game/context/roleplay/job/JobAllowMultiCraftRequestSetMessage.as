package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class JobAllowMultiCraftRequestSetMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5749;

        private var _isInitialized:Boolean = false;
        public var enabled:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5749);
        }

        public function initJobAllowMultiCraftRequestSetMessage(enabled:Boolean=false):JobAllowMultiCraftRequestSetMessage
        {
            this.enabled = enabled;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.enabled = false;
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
            this.serializeAs_JobAllowMultiCraftRequestSetMessage(output);
        }

        public function serializeAs_JobAllowMultiCraftRequestSetMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.enabled);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobAllowMultiCraftRequestSetMessage(input);
        }

        public function deserializeAs_JobAllowMultiCraftRequestSetMessage(input:ICustomDataInput):void
        {
            this.enabled = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

