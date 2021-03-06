﻿package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class JobExperienceMultiUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5809;

        private var _isInitialized:Boolean = false;
        public var experiencesUpdate:Vector.<JobExperience>;

        public function JobExperienceMultiUpdateMessage()
        {
            this.experiencesUpdate = new Vector.<JobExperience>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5809);
        }

        public function initJobExperienceMultiUpdateMessage(experiencesUpdate:Vector.<JobExperience>=null):JobExperienceMultiUpdateMessage
        {
            this.experiencesUpdate = experiencesUpdate;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.experiencesUpdate = new Vector.<JobExperience>();
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
            this.serializeAs_JobExperienceMultiUpdateMessage(output);
        }

        public function serializeAs_JobExperienceMultiUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.experiencesUpdate.length);
            var _i1:uint;
            while (_i1 < this.experiencesUpdate.length)
            {
                (this.experiencesUpdate[_i1] as JobExperience).serializeAs_JobExperience(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobExperienceMultiUpdateMessage(input);
        }

        public function deserializeAs_JobExperienceMultiUpdateMessage(input:ICustomDataInput):void
        {
            var _item1:JobExperience;
            var _experiencesUpdateLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _experiencesUpdateLen)
            {
                _item1 = new JobExperience();
                _item1.deserialize(input);
                this.experiencesUpdate.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

