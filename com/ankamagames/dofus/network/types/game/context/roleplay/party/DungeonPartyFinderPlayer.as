package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DungeonPartyFinderPlayer extends Object implements INetworkType
    {
        public var playerId:uint = 0;
        public var playerName:String = "";
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var level:uint = 0;
        public static const protocolId:uint = 373;

        public function DungeonPartyFinderPlayer()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 373;
        }// end function

        public function initDungeonPartyFinderPlayer(param1:uint = 0, param2:String = "", param3:int = 0, param4:Boolean = false, param5:uint = 0) : DungeonPartyFinderPlayer
        {
            this.playerId = param1;
            this.playerName = param2;
            this.breed = param3;
            this.sex = param4;
            this.level = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.playerId = 0;
            this.playerName = "";
            this.breed = 0;
            this.sex = false;
            this.level = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_DungeonPartyFinderPlayer(param1);
            return;
        }// end function

        public function serializeAs_DungeonPartyFinderPlayer(param1:IDataOutput) : void
        {
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            param1.writeUTF(this.playerName);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeShort(this.level);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DungeonPartyFinderPlayer(param1);
            return;
        }// end function

        public function deserializeAs_DungeonPartyFinderPlayer(param1:IDataInput) : void
        {
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of DungeonPartyFinderPlayer.playerId.");
            }
            this.playerName = param1.readUTF();
            this.breed = param1.readByte();
            if (this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Steamer)
            {
                throw new Error("Forbidden value (" + this.breed + ") on element of DungeonPartyFinderPlayer.breed.");
            }
            this.sex = param1.readBoolean();
            this.level = param1.readShort();
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of DungeonPartyFinderPlayer.level.");
            }
            return;
        }// end function

    }
}
