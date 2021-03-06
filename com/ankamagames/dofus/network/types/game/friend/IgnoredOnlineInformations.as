﻿package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.enums.PlayableBreedEnum;

    public class IgnoredOnlineInformations extends IgnoredInformations implements INetworkType 
    {

        public static const protocolId:uint = 105;

        public var playerId:uint = 0;
        public var playerName:String = "";
        public var breed:int = 0;
        public var sex:Boolean = false;


        override public function getTypeId():uint
        {
            return (105);
        }

        public function initIgnoredOnlineInformations(accountId:uint=0, accountName:String="", playerId:uint=0, playerName:String="", breed:int=0, sex:Boolean=false):IgnoredOnlineInformations
        {
            super.initIgnoredInformations(accountId, accountName);
            this.playerId = playerId;
            this.playerName = playerName;
            this.breed = breed;
            this.sex = sex;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.playerId = 0;
            this.playerName = "";
            this.breed = 0;
            this.sex = false;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_IgnoredOnlineInformations(output);
        }

        public function serializeAs_IgnoredOnlineInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_IgnoredInformations(output);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeUTF(this.playerName);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IgnoredOnlineInformations(input);
        }

        public function deserializeAs_IgnoredOnlineInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of IgnoredOnlineInformations.playerId.")));
            };
            this.playerName = input.readUTF();
            this.breed = input.readByte();
            if ((((this.breed < PlayableBreedEnum.Feca)) || ((this.breed > PlayableBreedEnum.Eliatrope))))
            {
                throw (new Error((("Forbidden value (" + this.breed) + ") on element of IgnoredOnlineInformations.breed.")));
            };
            this.sex = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.types.game.friend

