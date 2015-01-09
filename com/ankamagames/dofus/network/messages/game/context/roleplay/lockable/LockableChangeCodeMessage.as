package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class LockableChangeCodeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5666;

        private var _isInitialized:Boolean = false;
        public var code:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5666);
        }

        public function initLockableChangeCodeMessage(code:String=""):LockableChangeCodeMessage
        {
            this.code = code;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.code = "";
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
            this.serializeAs_LockableChangeCodeMessage(output);
        }

        public function serializeAs_LockableChangeCodeMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.code);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_LockableChangeCodeMessage(input);
        }

        public function deserializeAs_LockableChangeCodeMessage(input:ICustomDataInput):void
        {
            this.code = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable

