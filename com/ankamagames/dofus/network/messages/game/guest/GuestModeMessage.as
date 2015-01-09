package com.ankamagames.dofus.network.messages.game.guest
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuestModeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6505;

        private var _isInitialized:Boolean = false;
        public var active:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6505);
        }

        public function initGuestModeMessage(active:Boolean=false):GuestModeMessage
        {
            this.active = active;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.active = false;
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
            this.serializeAs_GuestModeMessage(output);
        }

        public function serializeAs_GuestModeMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.active);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuestModeMessage(input);
        }

        public function deserializeAs_GuestModeMessage(input:ICustomDataInput):void
        {
            this.active = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guest

