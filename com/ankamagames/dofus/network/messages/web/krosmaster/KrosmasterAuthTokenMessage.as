package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class KrosmasterAuthTokenMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6351;

        private var _isInitialized:Boolean = false;
        public var token:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6351);
        }

        public function initKrosmasterAuthTokenMessage(token:String=""):KrosmasterAuthTokenMessage
        {
            this.token = token;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_KrosmasterAuthTokenMessage(output);
        }

        public function serializeAs_KrosmasterAuthTokenMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.token);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_KrosmasterAuthTokenMessage(input);
        }

        public function deserializeAs_KrosmasterAuthTokenMessage(input:ICustomDataInput):void
        {
            this.token = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.web.krosmaster

