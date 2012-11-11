package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobExperienceUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var experiencesUpdate:JobExperience;
        public static const protocolId:uint = 5654;

        public function JobExperienceUpdateMessage()
        {
            this.experiencesUpdate = new JobExperience();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5654;
        }// end function

        public function initJobExperienceUpdateMessage(param1:JobExperience = null) : JobExperienceUpdateMessage
        {
            this.experiencesUpdate = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.experiencesUpdate = new JobExperience();
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
            this.serializeAs_JobExperienceUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_JobExperienceUpdateMessage(param1:IDataOutput) : void
        {
            this.experiencesUpdate.serializeAs_JobExperience(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobExperienceUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobExperienceUpdateMessage(param1:IDataInput) : void
        {
            this.experiencesUpdate = new JobExperience();
            this.experiencesUpdate.deserialize(param1);
            return;
        }// end function

    }
}
