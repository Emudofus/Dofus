package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicWhoIsNoMatchMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 179;

        private var _isInitialized:Boolean = false;
        public var search:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (179);
        }

        public function initBasicWhoIsNoMatchMessage(search:String=""):BasicWhoIsNoMatchMessage
        {
            this.search = search;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_BasicWhoIsNoMatchMessage(output);
        }

        public function serializeAs_BasicWhoIsNoMatchMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.search);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicWhoIsNoMatchMessage(input);
        }

        public function deserializeAs_BasicWhoIsNoMatchMessage(input:ICustomDataInput):void
        {
            this.search = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

