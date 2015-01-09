package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicWhoIsRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 181;

        private var _isInitialized:Boolean = false;
        public var verbose:Boolean = false;
        public var search:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (181);
        }

        public function initBasicWhoIsRequestMessage(verbose:Boolean=false, search:String=""):BasicWhoIsRequestMessage
        {
            this.verbose = verbose;
            this.search = search;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.verbose = false;
            this.search = "";
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
            this.serializeAs_BasicWhoIsRequestMessage(output);
        }

        public function serializeAs_BasicWhoIsRequestMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.verbose);
            output.writeUTF(this.search);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicWhoIsRequestMessage(input);
        }

        public function deserializeAs_BasicWhoIsRequestMessage(input:ICustomDataInput):void
        {
            this.verbose = input.readBoolean();
            this.search = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

