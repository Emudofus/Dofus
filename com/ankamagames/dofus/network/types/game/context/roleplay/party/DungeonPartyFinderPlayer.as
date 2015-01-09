package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.enums.PlayableBreedEnum;

    public class DungeonPartyFinderPlayer implements INetworkType 
    {

        public static const protocolId:uint = 373;

        public var playerId:uint = 0;
        public var playerName:String = "";
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var level:uint = 0;


        public function getTypeId():uint
        {
            return (373);
        }

        public function initDungeonPartyFinderPlayer(playerId:uint=0, playerName:String="", breed:int=0, sex:Boolean=false, level:uint=0):DungeonPartyFinderPlayer
        {
            this.playerId = playerId;
            this.playerName = playerName;
            this.breed = breed;
            this.sex = sex;
            this.level = level;
            return (this);
        }

        public function reset():void
        {
            this.playerId = 0;
            this.playerName = "";
            this.breed = 0;
            this.sex = false;
            this.level = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_DungeonPartyFinderPlayer(output);
        }

        public function serializeAs_DungeonPartyFinderPlayer(output:ICustomDataOutput):void
        {
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeUTF(this.playerName);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DungeonPartyFinderPlayer(input);
        }

        public function deserializeAs_DungeonPartyFinderPlayer(input:ICustomDataInput):void
        {
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of DungeonPartyFinderPlayer.playerId.")));
            };
            this.playerName = input.readUTF();
            this.breed = input.readByte();
            if ((((this.breed < PlayableBreedEnum.Feca)) || ((this.breed > PlayableBreedEnum.Eliatrope))))
            {
                throw (new Error((("Forbidden value (" + this.breed) + ") on element of DungeonPartyFinderPlayer.breed.")));
            };
            this.sex = input.readBoolean();
            this.level = input.readUnsignedByte();
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of DungeonPartyFinderPlayer.level.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.party

