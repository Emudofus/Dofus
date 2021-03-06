﻿package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FriendInformations extends AbstractContactInformations implements INetworkType 
    {

        public static const protocolId:uint = 78;

        public var playerState:uint = 99;
        public var lastConnection:uint = 0;
        public var achievementPoints:int = 0;


        override public function getTypeId():uint
        {
            return (78);
        }

        public function initFriendInformations(accountId:uint=0, accountName:String="", playerState:uint=99, lastConnection:uint=0, achievementPoints:int=0):FriendInformations
        {
            super.initAbstractContactInformations(accountId, accountName);
            this.playerState = playerState;
            this.lastConnection = lastConnection;
            this.achievementPoints = achievementPoints;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.playerState = 99;
            this.lastConnection = 0;
            this.achievementPoints = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FriendInformations(output);
        }

        public function serializeAs_FriendInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractContactInformations(output);
            output.writeByte(this.playerState);
            if (this.lastConnection < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastConnection) + ") on element lastConnection.")));
            };
            output.writeVarShort(this.lastConnection);
            output.writeInt(this.achievementPoints);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FriendInformations(input);
        }

        public function deserializeAs_FriendInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.playerState = input.readByte();
            if (this.playerState < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerState) + ") on element of FriendInformations.playerState.")));
            };
            this.lastConnection = input.readVarUhShort();
            if (this.lastConnection < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastConnection) + ") on element of FriendInformations.lastConnection.")));
            };
            this.achievementPoints = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.types.game.friend

