package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterExperienceGainMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6321;

        private var _isInitialized:Boolean = false;
        public var experienceCharacter:Number = 0;
        public var experienceMount:Number = 0;
        public var experienceGuild:Number = 0;
        public var experienceIncarnation:Number = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6321);
        }

        public function initCharacterExperienceGainMessage(experienceCharacter:Number=0, experienceMount:Number=0, experienceGuild:Number=0, experienceIncarnation:Number=0):CharacterExperienceGainMessage
        {
            this.experienceCharacter = experienceCharacter;
            this.experienceMount = experienceMount;
            this.experienceGuild = experienceGuild;
            this.experienceIncarnation = experienceIncarnation;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.experienceCharacter = 0;
            this.experienceMount = 0;
            this.experienceGuild = 0;
            this.experienceIncarnation = 0;
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
            this.serializeAs_CharacterExperienceGainMessage(output);
        }

        public function serializeAs_CharacterExperienceGainMessage(output:ICustomDataOutput):void
        {
            if ((((this.experienceCharacter < 0)) || ((this.experienceCharacter > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceCharacter) + ") on element experienceCharacter.")));
            };
            output.writeVarLong(this.experienceCharacter);
            if ((((this.experienceMount < 0)) || ((this.experienceMount > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceMount) + ") on element experienceMount.")));
            };
            output.writeVarLong(this.experienceMount);
            if ((((this.experienceGuild < 0)) || ((this.experienceGuild > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceGuild) + ") on element experienceGuild.")));
            };
            output.writeVarLong(this.experienceGuild);
            if ((((this.experienceIncarnation < 0)) || ((this.experienceIncarnation > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceIncarnation) + ") on element experienceIncarnation.")));
            };
            output.writeVarLong(this.experienceIncarnation);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterExperienceGainMessage(input);
        }

        public function deserializeAs_CharacterExperienceGainMessage(input:ICustomDataInput):void
        {
            this.experienceCharacter = input.readVarUhLong();
            if ((((this.experienceCharacter < 0)) || ((this.experienceCharacter > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceCharacter) + ") on element of CharacterExperienceGainMessage.experienceCharacter.")));
            };
            this.experienceMount = input.readVarUhLong();
            if ((((this.experienceMount < 0)) || ((this.experienceMount > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceMount) + ") on element of CharacterExperienceGainMessage.experienceMount.")));
            };
            this.experienceGuild = input.readVarUhLong();
            if ((((this.experienceGuild < 0)) || ((this.experienceGuild > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceGuild) + ") on element of CharacterExperienceGainMessage.experienceGuild.")));
            };
            this.experienceIncarnation = input.readVarUhLong();
            if ((((this.experienceIncarnation < 0)) || ((this.experienceIncarnation > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experienceIncarnation) + ") on element of CharacterExperienceGainMessage.experienceIncarnation.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.stats

