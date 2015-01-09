package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class QuestObjectiveInformations implements INetworkType 
    {

        public static const protocolId:uint = 385;

        public var objectiveId:uint = 0;
        public var objectiveStatus:Boolean = false;
        public var dialogParams:Vector.<String>;

        public function QuestObjectiveInformations()
        {
            this.dialogParams = new Vector.<String>();
            super();
        }

        public function getTypeId():uint
        {
            return (385);
        }

        public function initQuestObjectiveInformations(objectiveId:uint=0, objectiveStatus:Boolean=false, dialogParams:Vector.<String>=null):QuestObjectiveInformations
        {
            this.objectiveId = objectiveId;
            this.objectiveStatus = objectiveStatus;
            this.dialogParams = dialogParams;
            return (this);
        }

        public function reset():void
        {
            this.objectiveId = 0;
            this.objectiveStatus = false;
            this.dialogParams = new Vector.<String>();
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_QuestObjectiveInformations(output);
        }

        public function serializeAs_QuestObjectiveInformations(output:IDataOutput):void
        {
            if (this.objectiveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectiveId) + ") on element objectiveId.")));
            };
            output.writeShort(this.objectiveId);
            output.writeBoolean(this.objectiveStatus);
            output.writeShort(this.dialogParams.length);
            var _i3:uint;
            while (_i3 < this.dialogParams.length)
            {
                output.writeUTF(this.dialogParams[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_QuestObjectiveInformations(input);
        }

        public function deserializeAs_QuestObjectiveInformations(input:IDataInput):void
        {
            var _val3:String;
            this.objectiveId = input.readShort();
            if (this.objectiveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectiveId) + ") on element of QuestObjectiveInformations.objectiveId.")));
            };
            this.objectiveStatus = input.readBoolean();
            var _dialogParamsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _dialogParamsLen)
            {
                _val3 = input.readUTF();
                this.dialogParams.push(_val3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.quest

