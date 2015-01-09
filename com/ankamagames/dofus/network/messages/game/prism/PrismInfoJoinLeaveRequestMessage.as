package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PrismInfoJoinLeaveRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5844;

        private var _isInitialized:Boolean = false;
        public var join:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5844);
        }

        public function initPrismInfoJoinLeaveRequestMessage(join:Boolean=false):PrismInfoJoinLeaveRequestMessage
        {
            this.join = join;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.join = false;
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
            this.serializeAs_PrismInfoJoinLeaveRequestMessage(output);
        }

        public function serializeAs_PrismInfoJoinLeaveRequestMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.join);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismInfoJoinLeaveRequestMessage(input);
        }

        public function deserializeAs_PrismInfoJoinLeaveRequestMessage(input:ICustomDataInput):void
        {
            this.join = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

