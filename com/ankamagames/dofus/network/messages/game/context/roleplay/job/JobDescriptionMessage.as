package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobDescriptionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var jobsDescription:Vector.<JobDescription>;
        public static const protocolId:uint = 5655;

        public function JobDescriptionMessage()
        {
            this.jobsDescription = new Vector.<JobDescription>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5655;
        }// end function

        public function initJobDescriptionMessage(param1:Vector.<JobDescription> = null) : JobDescriptionMessage
        {
            this.jobsDescription = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.jobsDescription = new Vector.<JobDescription>;
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
            this.serializeAs_JobDescriptionMessage(param1);
            return;
        }// end function

        public function serializeAs_JobDescriptionMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.jobsDescription.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.jobsDescription.length)
            {
                
                (this.jobsDescription[_loc_2] as JobDescription).serializeAs_JobDescription(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobDescriptionMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobDescriptionMessage(param1:IDataInput) : void
        {
            var _loc_4:JobDescription = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new JobDescription();
                _loc_4.deserialize(param1);
                this.jobsDescription.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
