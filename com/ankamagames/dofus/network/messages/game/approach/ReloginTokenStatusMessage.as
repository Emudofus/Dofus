package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ReloginTokenStatusMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6539;

        private var _isInitialized:Boolean = false;
        public var validToken:Boolean = false;
        public var token:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6539);
        }

        public function initReloginTokenStatusMessage(validToken:Boolean=false, token:String=""):ReloginTokenStatusMessage
        {
            this.validToken = validToken;
            this.token = token;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.validToken = false;
            this.token = "";
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
            this.serializeAs_ReloginTokenStatusMessage(output);
        }

        public function serializeAs_ReloginTokenStatusMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.validToken);
            output.writeUTF(this.token);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ReloginTokenStatusMessage(input);
        }

        public function deserializeAs_ReloginTokenStatusMessage(input:ICustomDataInput):void
        {
            this.validToken = input.readBoolean();
            this.token = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.approach

