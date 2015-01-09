package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class JobCrafterDirectorySettingsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5652;

        private var _isInitialized:Boolean = false;
        public var craftersSettings:Vector.<JobCrafterDirectorySettings>;

        public function JobCrafterDirectorySettingsMessage()
        {
            this.craftersSettings = new Vector.<JobCrafterDirectorySettings>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5652);
        }

        public function initJobCrafterDirectorySettingsMessage(craftersSettings:Vector.<JobCrafterDirectorySettings>=null):JobCrafterDirectorySettingsMessage
        {
            this.craftersSettings = craftersSettings;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.craftersSettings = new Vector.<JobCrafterDirectorySettings>();
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
            this.serializeAs_JobCrafterDirectorySettingsMessage(output);
        }

        public function serializeAs_JobCrafterDirectorySettingsMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.craftersSettings.length);
            var _i1:uint;
            while (_i1 < this.craftersSettings.length)
            {
                (this.craftersSettings[_i1] as JobCrafterDirectorySettings).serializeAs_JobCrafterDirectorySettings(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobCrafterDirectorySettingsMessage(input);
        }

        public function deserializeAs_JobCrafterDirectorySettingsMessage(input:ICustomDataInput):void
        {
            var _item1:JobCrafterDirectorySettings;
            var _craftersSettingsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _craftersSettingsLen)
            {
                _item1 = new JobCrafterDirectorySettings();
                _item1.deserialize(input);
                this.craftersSettings.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

