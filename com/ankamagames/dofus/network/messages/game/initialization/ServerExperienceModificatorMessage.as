package com.ankamagames.dofus.network.messages.game.initialization
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ServerExperienceModificatorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6237;

        private var _isInitialized:Boolean = false;
        public var experiencePercent:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6237);
        }

        public function initServerExperienceModificatorMessage(experiencePercent:uint=0):ServerExperienceModificatorMessage
        {
            this.experiencePercent = experiencePercent;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.experiencePercent = 0;
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
            this.serializeAs_ServerExperienceModificatorMessage(output);
        }

        public function serializeAs_ServerExperienceModificatorMessage(output:ICustomDataOutput):void
        {
            if (this.experiencePercent < 0)
            {
                throw (new Error((("Forbidden value (" + this.experiencePercent) + ") on element experiencePercent.")));
            };
            output.writeVarShort(this.experiencePercent);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServerExperienceModificatorMessage(input);
        }

        public function deserializeAs_ServerExperienceModificatorMessage(input:ICustomDataInput):void
        {
            this.experiencePercent = input.readVarUhShort();
            if (this.experiencePercent < 0)
            {
                throw (new Error((("Forbidden value (" + this.experiencePercent) + ") on element of ServerExperienceModificatorMessage.experiencePercent.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.initialization

