package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class QuestListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var finishedQuestsIds:Vector.<uint>;
        public var finishedQuestsCounts:Vector.<uint>;
        public var activeQuests:Vector.<QuestActiveInformations>;
        public static const protocolId:uint = 5626;

        public function QuestListMessage()
        {
            this.finishedQuestsIds = new Vector.<uint>;
            this.finishedQuestsCounts = new Vector.<uint>;
            this.activeQuests = new Vector.<QuestActiveInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5626;
        }// end function

        public function initQuestListMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null, param3:Vector.<QuestActiveInformations> = null) : QuestListMessage
        {
            this.finishedQuestsIds = param1;
            this.finishedQuestsCounts = param2;
            this.activeQuests = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.finishedQuestsIds = new Vector.<uint>;
            this.finishedQuestsCounts = new Vector.<uint>;
            this.activeQuests = new Vector.<QuestActiveInformations>;
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
            this.serializeAs_QuestListMessage(param1);
            return;
        }// end function

        public function serializeAs_QuestListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.finishedQuestsIds.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.finishedQuestsIds.length)
            {
                
                if (this.finishedQuestsIds[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.finishedQuestsIds[_loc_2] + ") on element 1 (starting at 1) of finishedQuestsIds.");
                }
                param1.writeShort(this.finishedQuestsIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.finishedQuestsCounts.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.finishedQuestsCounts.length)
            {
                
                if (this.finishedQuestsCounts[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.finishedQuestsCounts[_loc_3] + ") on element 2 (starting at 1) of finishedQuestsCounts.");
                }
                param1.writeShort(this.finishedQuestsCounts[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.activeQuests.length);
            var _loc_4:uint = 0;
            while (_loc_4 < this.activeQuests.length)
            {
                
                param1.writeShort((this.activeQuests[_loc_4] as QuestActiveInformations).getTypeId());
                (this.activeQuests[_loc_4] as QuestActiveInformations).serialize(param1);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_QuestListMessage(param1);
            return;
        }// end function

        public function deserializeAs_QuestListMessage(param1:IDataInput) : void
        {
            var _loc_8:uint = 0;
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            var _loc_11:QuestActiveInformations = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_8 = param1.readShort();
                if (_loc_8 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_8 + ") on elements of finishedQuestsIds.");
                }
                this.finishedQuestsIds.push(_loc_8);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = param1.readShort();
                if (_loc_9 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_9 + ") on elements of finishedQuestsCounts.");
                }
                this.finishedQuestsCounts.push(_loc_9);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:uint = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_10 = param1.readUnsignedShort();
                _loc_11 = ProtocolTypeManager.getInstance(QuestActiveInformations, _loc_10);
                _loc_11.deserialize(param1);
                this.activeQuests.push(_loc_11);
                _loc_7 = _loc_7 + 1;
            }
            return;
        }// end function

    }
}
