package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class QuestListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5626;

        private var _isInitialized:Boolean = false;
        public var finishedQuestsIds:Vector.<uint>;
        public var finishedQuestsCounts:Vector.<uint>;
        public var activeQuests:Vector.<QuestActiveInformations>;

        public function QuestListMessage()
        {
            this.finishedQuestsIds = new Vector.<uint>();
            this.finishedQuestsCounts = new Vector.<uint>();
            this.activeQuests = new Vector.<QuestActiveInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5626);
        }

        public function initQuestListMessage(finishedQuestsIds:Vector.<uint>=null, finishedQuestsCounts:Vector.<uint>=null, activeQuests:Vector.<QuestActiveInformations>=null):QuestListMessage
        {
            this.finishedQuestsIds = finishedQuestsIds;
            this.finishedQuestsCounts = finishedQuestsCounts;
            this.activeQuests = activeQuests;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.finishedQuestsIds = new Vector.<uint>();
            this.finishedQuestsCounts = new Vector.<uint>();
            this.activeQuests = new Vector.<QuestActiveInformations>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_QuestListMessage(output);
        }

        public function serializeAs_QuestListMessage(output:IDataOutput):void
        {
            output.writeShort(this.finishedQuestsIds.length);
            var _i1:uint;
            while (_i1 < this.finishedQuestsIds.length)
            {
                if (this.finishedQuestsIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.finishedQuestsIds[_i1]) + ") on element 1 (starting at 1) of finishedQuestsIds.")));
                };
                output.writeShort(this.finishedQuestsIds[_i1]);
                _i1++;
            };
            output.writeShort(this.finishedQuestsCounts.length);
            var _i2:uint;
            while (_i2 < this.finishedQuestsCounts.length)
            {
                if (this.finishedQuestsCounts[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.finishedQuestsCounts[_i2]) + ") on element 2 (starting at 1) of finishedQuestsCounts.")));
                };
                output.writeShort(this.finishedQuestsCounts[_i2]);
                _i2++;
            };
            output.writeShort(this.activeQuests.length);
            var _i3:uint;
            while (_i3 < this.activeQuests.length)
            {
                output.writeShort((this.activeQuests[_i3] as QuestActiveInformations).getTypeId());
                (this.activeQuests[_i3] as QuestActiveInformations).serialize(output);
                _i3++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_QuestListMessage(input);
        }

        public function deserializeAs_QuestListMessage(input:IDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _id3:uint;
            var _item3:QuestActiveInformations;
            var _finishedQuestsIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _finishedQuestsIdsLen)
            {
                _val1 = input.readShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of finishedQuestsIds.")));
                };
                this.finishedQuestsIds.push(_val1);
                _i1++;
            };
            var _finishedQuestsCountsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _finishedQuestsCountsLen)
            {
                _val2 = input.readShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of finishedQuestsCounts.")));
                };
                this.finishedQuestsCounts.push(_val2);
                _i2++;
            };
            var _activeQuestsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _activeQuestsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(QuestActiveInformations, _id3);
                _item3.deserialize(input);
                this.activeQuests.push(_item3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.quest

