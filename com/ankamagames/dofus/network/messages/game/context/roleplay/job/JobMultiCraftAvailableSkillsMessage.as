package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class JobMultiCraftAvailableSkillsMessage extends JobAllowMultiCraftRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5747;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;
        public var skills:Vector.<uint>;

        public function JobMultiCraftAvailableSkillsMessage()
        {
            this.skills = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5747);
        }

        public function initJobMultiCraftAvailableSkillsMessage(enabled:Boolean=false, playerId:uint=0, skills:Vector.<uint>=null):JobMultiCraftAvailableSkillsMessage
        {
            super.initJobAllowMultiCraftRequestMessage(enabled);
            this.playerId = playerId;
            this.skills = skills;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.playerId = 0;
            this.skills = new Vector.<uint>();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_JobMultiCraftAvailableSkillsMessage(output);
        }

        public function serializeAs_JobMultiCraftAvailableSkillsMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_JobAllowMultiCraftRequestMessage(output);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeShort(this.skills.length);
            var _i2:uint;
            while (_i2 < this.skills.length)
            {
                if (this.skills[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.skills[_i2]) + ") on element 2 (starting at 1) of skills.")));
                };
                output.writeVarShort(this.skills[_i2]);
                _i2++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobMultiCraftAvailableSkillsMessage(input);
        }

        public function deserializeAs_JobMultiCraftAvailableSkillsMessage(input:ICustomDataInput):void
        {
            var _val2:uint;
            super.deserialize(input);
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of JobMultiCraftAvailableSkillsMessage.playerId.")));
            };
            var _skillsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _skillsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of skills.")));
                };
                this.skills.push(_val2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

