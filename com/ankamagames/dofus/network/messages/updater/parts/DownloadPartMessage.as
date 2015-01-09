package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class DownloadPartMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1503;

        private var _isInitialized:Boolean = false;
        public var id:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1503);
        }

        public function initDownloadPartMessage(id:String=""):DownloadPartMessage
        {
            this.id = id;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = "";
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
            this.serializeAs_DownloadPartMessage(output);
        }

        public function serializeAs_DownloadPartMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.id);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DownloadPartMessage(input);
        }

        public function deserializeAs_DownloadPartMessage(input:ICustomDataInput):void
        {
            this.id = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.updater.parts

