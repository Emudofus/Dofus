package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class NpcDialogQuestionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5617;

        private var _isInitialized:Boolean = false;
        public var messageId:uint = 0;
        public var dialogParams:Vector.<String>;
        public var visibleReplies:Vector.<uint>;

        public function NpcDialogQuestionMessage()
        {
            this.dialogParams = new Vector.<String>();
            this.visibleReplies = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5617);
        }

        public function initNpcDialogQuestionMessage(messageId:uint=0, dialogParams:Vector.<String>=null, visibleReplies:Vector.<uint>=null):NpcDialogQuestionMessage
        {
            this.messageId = messageId;
            this.dialogParams = dialogParams;
            this.visibleReplies = visibleReplies;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.messageId = 0;
            this.dialogParams = new Vector.<String>();
            this.visibleReplies = new Vector.<uint>();
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
            this.serializeAs_NpcDialogQuestionMessage(output);
        }

        public function serializeAs_NpcDialogQuestionMessage(output:ICustomDataOutput):void
        {
            if (this.messageId < 0)
            {
                throw (new Error((("Forbidden value (" + this.messageId) + ") on element messageId.")));
            };
            output.writeVarShort(this.messageId);
            output.writeShort(this.dialogParams.length);
            var _i2:uint;
            while (_i2 < this.dialogParams.length)
            {
                output.writeUTF(this.dialogParams[_i2]);
                _i2++;
            };
            output.writeShort(this.visibleReplies.length);
            var _i3:uint;
            while (_i3 < this.visibleReplies.length)
            {
                if (this.visibleReplies[_i3] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.visibleReplies[_i3]) + ") on element 3 (starting at 1) of visibleReplies.")));
                };
                output.writeVarShort(this.visibleReplies[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NpcDialogQuestionMessage(input);
        }

        public function deserializeAs_NpcDialogQuestionMessage(input:ICustomDataInput):void
        {
            var _val2:String;
            var _val3:uint;
            this.messageId = input.readVarUhShort();
            if (this.messageId < 0)
            {
                throw (new Error((("Forbidden value (" + this.messageId) + ") on element of NpcDialogQuestionMessage.messageId.")));
            };
            var _dialogParamsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _dialogParamsLen)
            {
                _val2 = input.readUTF();
                this.dialogParams.push(_val2);
                _i2++;
            };
            var _visibleRepliesLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _visibleRepliesLen)
            {
                _val3 = input.readVarUhShort();
                if (_val3 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of visibleReplies.")));
                };
                this.visibleReplies.push(_val3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.npc

