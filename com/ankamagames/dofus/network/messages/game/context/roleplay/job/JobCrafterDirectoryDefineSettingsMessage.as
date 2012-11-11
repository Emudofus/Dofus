package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobCrafterDirectoryDefineSettingsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var settings:JobCrafterDirectorySettings;
        public static const protocolId:uint = 5649;

        public function JobCrafterDirectoryDefineSettingsMessage()
        {
            this.settings = new JobCrafterDirectorySettings();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5649;
        }// end function

        public function initJobCrafterDirectoryDefineSettingsMessage(param1:JobCrafterDirectorySettings = null) : JobCrafterDirectoryDefineSettingsMessage
        {
            this.settings = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.settings = new JobCrafterDirectorySettings();
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
            this.serializeAs_JobCrafterDirectoryDefineSettingsMessage(param1);
            return;
        }// end function

        public function serializeAs_JobCrafterDirectoryDefineSettingsMessage(param1:IDataOutput) : void
        {
            this.settings.serializeAs_JobCrafterDirectorySettings(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobCrafterDirectoryDefineSettingsMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobCrafterDirectoryDefineSettingsMessage(param1:IDataInput) : void
        {
            this.settings = new JobCrafterDirectorySettings();
            this.settings.deserialize(param1);
            return;
        }// end function

    }
}
