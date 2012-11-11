package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NpcDialogReplyMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var replyId:uint = 0;
        public static const protocolId:uint = 5616;

        public function NpcDialogReplyMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5616;
        }// end function

        public function initNpcDialogReplyMessage(param1:uint = 0) : NpcDialogReplyMessage
        {
            this.replyId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.replyId = 0;
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
            this.serializeAs_NpcDialogReplyMessage(param1);
            return;
        }// end function

        public function serializeAs_NpcDialogReplyMessage(param1:IDataOutput) : void
        {
            if (this.replyId < 0)
            {
                throw new Error("Forbidden value (" + this.replyId + ") on element replyId.");
            }
            param1.writeShort(this.replyId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NpcDialogReplyMessage(param1);
            return;
        }// end function

        public function deserializeAs_NpcDialogReplyMessage(param1:IDataInput) : void
        {
            this.replyId = param1.readShort();
            if (this.replyId < 0)
            {
                throw new Error("Forbidden value (" + this.replyId + ") on element of NpcDialogReplyMessage.replyId.");
            }
            return;
        }// end function

    }
}
