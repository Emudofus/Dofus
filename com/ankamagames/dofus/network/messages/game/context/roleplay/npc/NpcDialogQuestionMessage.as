package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NpcDialogQuestionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var messageId:uint = 0;
        public var dialogParams:Vector.<String>;
        public var visibleReplies:Vector.<uint>;
        public static const protocolId:uint = 5617;

        public function NpcDialogQuestionMessage()
        {
            this.dialogParams = new Vector.<String>;
            this.visibleReplies = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5617;
        }// end function

        public function initNpcDialogQuestionMessage(param1:uint = 0, param2:Vector.<String> = null, param3:Vector.<uint> = null) : NpcDialogQuestionMessage
        {
            this.messageId = param1;
            this.dialogParams = param2;
            this.visibleReplies = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.messageId = 0;
            this.dialogParams = new Vector.<String>;
            this.visibleReplies = new Vector.<uint>;
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
            this.serializeAs_NpcDialogQuestionMessage(param1);
            return;
        }// end function

        public function serializeAs_NpcDialogQuestionMessage(param1:IDataOutput) : void
        {
            if (this.messageId < 0)
            {
                throw new Error("Forbidden value (" + this.messageId + ") on element messageId.");
            }
            param1.writeShort(this.messageId);
            param1.writeShort(this.dialogParams.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.dialogParams.length)
            {
                
                param1.writeUTF(this.dialogParams[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.visibleReplies.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.visibleReplies.length)
            {
                
                if (this.visibleReplies[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.visibleReplies[_loc_3] + ") on element 3 (starting at 1) of visibleReplies.");
                }
                param1.writeShort(this.visibleReplies[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NpcDialogQuestionMessage(param1);
            return;
        }// end function

        public function deserializeAs_NpcDialogQuestionMessage(param1:IDataInput) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            this.messageId = param1.readShort();
            if (this.messageId < 0)
            {
                throw new Error("Forbidden value (" + this.messageId + ") on element of NpcDialogQuestionMessage.messageId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readUTF();
                this.dialogParams.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readShort();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of visibleReplies.");
                }
                this.visibleReplies.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
