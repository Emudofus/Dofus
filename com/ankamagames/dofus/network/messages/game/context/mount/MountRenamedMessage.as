package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MountRenamedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5983;

        private var _isInitialized:Boolean = false;
        public var mountId:Number = 0;
        public var name:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5983);
        }

        public function initMountRenamedMessage(mountId:Number=0, name:String=""):MountRenamedMessage
        {
            this.mountId = mountId;
            this.name = name;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mountId = 0;
            this.name = "";
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
            this.serializeAs_MountRenamedMessage(output);
        }

        public function serializeAs_MountRenamedMessage(output:ICustomDataOutput):void
        {
            if ((((this.mountId < -9007199254740992)) || ((this.mountId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.mountId) + ") on element mountId.")));
            };
            output.writeDouble(this.mountId);
            output.writeUTF(this.name);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountRenamedMessage(input);
        }

        public function deserializeAs_MountRenamedMessage(input:ICustomDataInput):void
        {
            this.mountId = input.readDouble();
            if ((((this.mountId < -9007199254740992)) || ((this.mountId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.mountId) + ") on element of MountRenamedMessage.mountId.")));
            };
            this.name = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

