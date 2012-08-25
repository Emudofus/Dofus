package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobMultiCraftAvailableSkillsMessage extends JobAllowMultiCraftRequestMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;
        public var skills:Vector.<uint>;
        public static const protocolId:uint = 5747;

        public function JobMultiCraftAvailableSkillsMessage()
        {
            this.skills = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5747;
        }// end function

        public function initJobMultiCraftAvailableSkillsMessage(param1:Boolean = false, param2:uint = 0, param3:Vector.<uint> = null) : JobMultiCraftAvailableSkillsMessage
        {
            super.initJobAllowMultiCraftRequestMessage(param1);
            this.playerId = param2;
            this.skills = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.playerId = 0;
            this.skills = new Vector.<uint>;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_JobMultiCraftAvailableSkillsMessage(param1);
            return;
        }// end function

        public function serializeAs_JobMultiCraftAvailableSkillsMessage(param1:IDataOutput) : void
        {
            super.serializeAs_JobAllowMultiCraftRequestMessage(param1);
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            param1.writeShort(this.skills.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.skills.length)
            {
                
                if (this.skills[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.skills[_loc_2] + ") on element 2 (starting at 1) of skills.");
                }
                param1.writeShort(this.skills[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobMultiCraftAvailableSkillsMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobMultiCraftAvailableSkillsMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            super.deserialize(param1);
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of JobMultiCraftAvailableSkillsMessage.playerId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readShort();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of skills.");
                }
                this.skills.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
