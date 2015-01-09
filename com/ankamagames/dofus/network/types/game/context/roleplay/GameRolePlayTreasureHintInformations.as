package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public class GameRolePlayTreasureHintInformations extends GameRolePlayActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 471;

        public var npcId:uint = 0;


        override public function getTypeId():uint
        {
            return (471);
        }

        public function initGameRolePlayTreasureHintInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, npcId:uint=0):GameRolePlayTreasureHintInformations
        {
            super.initGameRolePlayActorInformations(contextualId, look, disposition);
            this.npcId = npcId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.npcId = 0;
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameRolePlayTreasureHintInformations(output);
        }

        public function serializeAs_GameRolePlayTreasureHintInformations(output:IDataOutput):void
        {
            super.serializeAs_GameRolePlayActorInformations(output);
            if (this.npcId < 0)
            {
                throw (new Error((("Forbidden value (" + this.npcId) + ") on element npcId.")));
            };
            output.writeShort(this.npcId);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameRolePlayTreasureHintInformations(input);
        }

        public function deserializeAs_GameRolePlayTreasureHintInformations(input:IDataInput):void
        {
            super.deserialize(input);
            this.npcId = input.readShort();
            if (this.npcId < 0)
            {
                throw (new Error((("Forbidden value (" + this.npcId) + ") on element of GameRolePlayTreasureHintInformations.npcId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

