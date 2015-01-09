package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayShowChallengeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 301;

        private var _isInitialized:Boolean = false;
        public var commonsInfos:FightCommonInformations;

        public function GameRolePlayShowChallengeMessage()
        {
            this.commonsInfos = new FightCommonInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (301);
        }

        public function initGameRolePlayShowChallengeMessage(commonsInfos:FightCommonInformations=null):GameRolePlayShowChallengeMessage
        {
            this.commonsInfos = commonsInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.commonsInfos = new FightCommonInformations();
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
            this.serializeAs_GameRolePlayShowChallengeMessage(output);
        }

        public function serializeAs_GameRolePlayShowChallengeMessage(output:ICustomDataOutput):void
        {
            this.commonsInfos.serializeAs_FightCommonInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayShowChallengeMessage(input);
        }

        public function deserializeAs_GameRolePlayShowChallengeMessage(input:ICustomDataInput):void
        {
            this.commonsInfos = new FightCommonInformations();
            this.commonsInfos.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.fight

