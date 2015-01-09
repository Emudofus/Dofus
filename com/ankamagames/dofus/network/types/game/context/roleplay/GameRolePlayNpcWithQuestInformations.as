package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameRolePlayNpcWithQuestInformations extends GameRolePlayNpcInformations implements INetworkType 
    {

        public static const protocolId:uint = 383;

        public var questFlag:GameRolePlayNpcQuestFlag;

        public function GameRolePlayNpcWithQuestInformations()
        {
            this.questFlag = new GameRolePlayNpcQuestFlag();
            super();
        }

        override public function getTypeId():uint
        {
            return (383);
        }

        public function initGameRolePlayNpcWithQuestInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, npcId:uint=0, sex:Boolean=false, specialArtworkId:uint=0, questFlag:GameRolePlayNpcQuestFlag=null):GameRolePlayNpcWithQuestInformations
        {
            super.initGameRolePlayNpcInformations(contextualId, look, disposition, npcId, sex, specialArtworkId);
            this.questFlag = questFlag;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.questFlag = new GameRolePlayNpcQuestFlag();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayNpcWithQuestInformations(output);
        }

        public function serializeAs_GameRolePlayNpcWithQuestInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayNpcInformations(output);
            this.questFlag.serializeAs_GameRolePlayNpcQuestFlag(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayNpcWithQuestInformations(input);
        }

        public function deserializeAs_GameRolePlayNpcWithQuestInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.questFlag = new GameRolePlayNpcQuestFlag();
            this.questFlag.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

