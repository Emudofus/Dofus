package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightUpdateTeamMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5572;

        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var team:FightTeamInformations;

        public function GameFightUpdateTeamMessage()
        {
            this.team = new FightTeamInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5572);
        }

        public function initGameFightUpdateTeamMessage(fightId:uint=0, team:FightTeamInformations=null):GameFightUpdateTeamMessage
        {
            this.fightId = fightId;
            this.team = team;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.team = new FightTeamInformations();
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
            this.serializeAs_GameFightUpdateTeamMessage(output);
        }

        public function serializeAs_GameFightUpdateTeamMessage(output:ICustomDataOutput):void
        {
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeShort(this.fightId);
            this.team.serializeAs_FightTeamInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightUpdateTeamMessage(input);
        }

        public function deserializeAs_GameFightUpdateTeamMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readShort();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of GameFightUpdateTeamMessage.fightId.")));
            };
            this.team = new FightTeamInformations();
            this.team.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

