package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobExperienceMultiUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var experiencesUpdate:Vector.<JobExperience>;
        public static const protocolId:uint = 5809;

        public function JobExperienceMultiUpdateMessage()
        {
            this.experiencesUpdate = new Vector.<JobExperience>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5809;
        }// end function

        public function initJobExperienceMultiUpdateMessage(param1:Vector.<JobExperience> = null) : JobExperienceMultiUpdateMessage
        {
            this.experiencesUpdate = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.experiencesUpdate = new Vector.<JobExperience>;
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
            this.serializeAs_JobExperienceMultiUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_JobExperienceMultiUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.experiencesUpdate.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.experiencesUpdate.length)
            {
                
                (this.experiencesUpdate[_loc_2] as JobExperience).serializeAs_JobExperience(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobExperienceMultiUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobExperienceMultiUpdateMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new JobExperience();
                _loc_4.deserialize(param1);
                this.experiencesUpdate.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
