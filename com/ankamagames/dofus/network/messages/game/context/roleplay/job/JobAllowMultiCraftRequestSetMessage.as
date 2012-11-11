package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobAllowMultiCraftRequestSetMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var enabled:Boolean = false;
        public static const protocolId:uint = 5749;

        public function JobAllowMultiCraftRequestSetMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5749;
        }// end function

        public function initJobAllowMultiCraftRequestSetMessage(param1:Boolean = false) : JobAllowMultiCraftRequestSetMessage
        {
            this.enabled = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.enabled = false;
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
            this.serializeAs_JobAllowMultiCraftRequestSetMessage(param1);
            return;
        }// end function

        public function serializeAs_JobAllowMultiCraftRequestSetMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.enabled);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobAllowMultiCraftRequestSetMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobAllowMultiCraftRequestSetMessage(param1:IDataInput) : void
        {
            this.enabled = param1.readBoolean();
            return;
        }// end function

    }
}
