package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;

    [Trusted]
    public class IgnoredDeleteResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5677;

        private var _isInitialized:Boolean = false;
        public var success:Boolean = false;
        public var name:String = "";
        public var session:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5677);
        }

        public function initIgnoredDeleteResultMessage(success:Boolean=false, name:String="", session:Boolean=false):IgnoredDeleteResultMessage
        {
            this.success = success;
            this.name = name;
            this.session = session;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.success = false;
            this.name = "";
            this.session = false;
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
            this.serializeAs_IgnoredDeleteResultMessage(output);
        }

        public function serializeAs_IgnoredDeleteResultMessage(output:ICustomDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.success);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.session);
            output.writeByte(_box0);
            output.writeUTF(this.name);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IgnoredDeleteResultMessage(input);
        }

        public function deserializeAs_IgnoredDeleteResultMessage(input:ICustomDataInput):void
        {
            var _box0:uint = input.readByte();
            this.success = BooleanByteWrapper.getFlag(_box0, 0);
            this.session = BooleanByteWrapper.getFlag(_box0, 1);
            this.name = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

