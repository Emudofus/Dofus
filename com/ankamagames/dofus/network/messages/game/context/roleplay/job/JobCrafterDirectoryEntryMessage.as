package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobCrafterDirectoryEntryMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var playerInfo:JobCrafterDirectoryEntryPlayerInfo;
        public var jobInfoList:Vector.<JobCrafterDirectoryEntryJobInfo>;
        public var playerLook:EntityLook;
        public static const protocolId:uint = 6044;

        public function JobCrafterDirectoryEntryMessage()
        {
            this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
            this.jobInfoList = new Vector.<JobCrafterDirectoryEntryJobInfo>;
            this.playerLook = new EntityLook();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6044;
        }// end function

        public function initJobCrafterDirectoryEntryMessage(param1:JobCrafterDirectoryEntryPlayerInfo = null, param2:Vector.<JobCrafterDirectoryEntryJobInfo> = null, param3:EntityLook = null) : JobCrafterDirectoryEntryMessage
        {
            this.playerInfo = param1;
            this.jobInfoList = param2;
            this.playerLook = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
            this.playerLook = new EntityLook();
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
            this.serializeAs_JobCrafterDirectoryEntryMessage(param1);
            return;
        }// end function

        public function serializeAs_JobCrafterDirectoryEntryMessage(param1:IDataOutput) : void
        {
            this.playerInfo.serializeAs_JobCrafterDirectoryEntryPlayerInfo(param1);
            param1.writeShort(this.jobInfoList.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.jobInfoList.length)
            {
                
                (this.jobInfoList[_loc_2] as JobCrafterDirectoryEntryJobInfo).serializeAs_JobCrafterDirectoryEntryJobInfo(param1);
                _loc_2 = _loc_2 + 1;
            }
            this.playerLook.serializeAs_EntityLook(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobCrafterDirectoryEntryMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobCrafterDirectoryEntryMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
            this.playerInfo.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new JobCrafterDirectoryEntryJobInfo();
                _loc_4.deserialize(param1);
                this.jobInfoList.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.playerLook = new EntityLook();
            this.playerLook.deserialize(param1);
            return;
        }// end function

    }
}
