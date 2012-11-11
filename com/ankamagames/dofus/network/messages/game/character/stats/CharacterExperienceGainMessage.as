package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterExperienceGainMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var experienceCharacter:Number = 0;
        public var experienceMount:Number = 0;
        public var experienceGuild:Number = 0;
        public var experienceIncarnation:Number = 0;
        public static const protocolId:uint = 6321;

        public function CharacterExperienceGainMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6321;
        }// end function

        public function initCharacterExperienceGainMessage(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : CharacterExperienceGainMessage
        {
            this.experienceCharacter = param1;
            this.experienceMount = param2;
            this.experienceGuild = param3;
            this.experienceIncarnation = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.experienceCharacter = 0;
            this.experienceMount = 0;
            this.experienceGuild = 0;
            this.experienceIncarnation = 0;
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
            this.serializeAs_CharacterExperienceGainMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterExperienceGainMessage(param1:IDataOutput) : void
        {
            if (this.experienceCharacter < 0)
            {
                throw new Error("Forbidden value (" + this.experienceCharacter + ") on element experienceCharacter.");
            }
            param1.writeDouble(this.experienceCharacter);
            if (this.experienceMount < 0)
            {
                throw new Error("Forbidden value (" + this.experienceMount + ") on element experienceMount.");
            }
            param1.writeDouble(this.experienceMount);
            if (this.experienceGuild < 0)
            {
                throw new Error("Forbidden value (" + this.experienceGuild + ") on element experienceGuild.");
            }
            param1.writeDouble(this.experienceGuild);
            if (this.experienceIncarnation < 0)
            {
                throw new Error("Forbidden value (" + this.experienceIncarnation + ") on element experienceIncarnation.");
            }
            param1.writeDouble(this.experienceIncarnation);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterExperienceGainMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterExperienceGainMessage(param1:IDataInput) : void
        {
            this.experienceCharacter = param1.readDouble();
            if (this.experienceCharacter < 0)
            {
                throw new Error("Forbidden value (" + this.experienceCharacter + ") on element of CharacterExperienceGainMessage.experienceCharacter.");
            }
            this.experienceMount = param1.readDouble();
            if (this.experienceMount < 0)
            {
                throw new Error("Forbidden value (" + this.experienceMount + ") on element of CharacterExperienceGainMessage.experienceMount.");
            }
            this.experienceGuild = param1.readDouble();
            if (this.experienceGuild < 0)
            {
                throw new Error("Forbidden value (" + this.experienceGuild + ") on element of CharacterExperienceGainMessage.experienceGuild.");
            }
            this.experienceIncarnation = param1.readDouble();
            if (this.experienceIncarnation < 0)
            {
                throw new Error("Forbidden value (" + this.experienceIncarnation + ") on element of CharacterExperienceGainMessage.experienceIncarnation.");
            }
            return;
        }// end function

    }
}
