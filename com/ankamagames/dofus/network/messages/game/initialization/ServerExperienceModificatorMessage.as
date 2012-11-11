package com.ankamagames.dofus.network.messages.game.initialization
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ServerExperienceModificatorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var experiencePercent:uint = 0;
        public static const protocolId:uint = 6237;

        public function ServerExperienceModificatorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6237;
        }// end function

        public function initServerExperienceModificatorMessage(param1:uint = 0) : ServerExperienceModificatorMessage
        {
            this.experiencePercent = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.experiencePercent = 0;
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
            this.serializeAs_ServerExperienceModificatorMessage(param1);
            return;
        }// end function

        public function serializeAs_ServerExperienceModificatorMessage(param1:IDataOutput) : void
        {
            if (this.experiencePercent < 0)
            {
                throw new Error("Forbidden value (" + this.experiencePercent + ") on element experiencePercent.");
            }
            param1.writeShort(this.experiencePercent);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ServerExperienceModificatorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ServerExperienceModificatorMessage(param1:IDataInput) : void
        {
            this.experiencePercent = param1.readShort();
            if (this.experiencePercent < 0)
            {
                throw new Error("Forbidden value (" + this.experiencePercent + ") on element of ServerExperienceModificatorMessage.experiencePercent.");
            }
            return;
        }// end function

    }
}
