package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class LockableUseCodeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5667;

        private var _isInitialized:Boolean = false;
        public var code:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5667);
        }

        public function initLockableUseCodeMessage(code:String=""):LockableUseCodeMessage
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
            this.serializeAs_LockableUseCodeMessage(output);
        }

        public function serializeAs_LockableUseCodeMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.code);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_LockableUseCodeMessage(input);
        }

        public function deserializeAs_LockableUseCodeMessage(input:ICustomDataInput):void
        {
            this.code = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable

