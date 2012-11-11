package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountRenamedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mountId:Number = 0;
        public var name:String = "";
        public static const protocolId:uint = 5983;

        public function MountRenamedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5983;
        }// end function

        public function initMountRenamedMessage(param1:Number = 0, param2:String = "") : MountRenamedMessage
        {
            this.mountId = param1;
            this.name = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mountId = 0;
            this.name = "";
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MountRenamedMessage(param1);
            return;
        }// end function

        public function serializeAs_MountRenamedMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.mountId);
            param1.writeUTF(this.name);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountRenamedMessage(param1);
            return;
        }// end function

        public function deserializeAs_MountRenamedMessage(param1:IDataInput) : void
        {
            this.mountId = param1.readDouble();
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
