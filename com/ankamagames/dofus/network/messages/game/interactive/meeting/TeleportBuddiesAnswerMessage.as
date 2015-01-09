package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TeleportBuddiesAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6294;

        private var _isInitialized:Boolean = false;
        public var accept:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6294);
        }

        public function initTeleportBuddiesAnswerMessage(accept:Boolean=false):TeleportBuddiesAnswerMessage
        {
            this.accept = accept;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.accept = false;
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
            this.serializeAs_TeleportBuddiesAnswerMessage(output);
        }

        public function serializeAs_TeleportBuddiesAnswerMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.accept);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportBuddiesAnswerMessage(input);
        }

        public function deserializeAs_TeleportBuddiesAnswerMessage(input:ICustomDataInput):void
        {
            this.accept = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.meeting

