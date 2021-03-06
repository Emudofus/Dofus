﻿package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameRolePlayActorInformations extends GameContextActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 141;


        override public function getTypeId():uint
        {
            return (141);
        }

        public function initGameRolePlayActorInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null):GameRolePlayActorInformations
        {
            super.initGameContextActorInformations(contextualId, look, disposition);
            return (this);
        }

        override public function reset():void
        {
            super.reset();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayActorInformations(output);
        }

        public function serializeAs_GameRolePlayActorInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameContextActorInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayActorInformations(input);
        }

        public function deserializeAs_GameRolePlayActorInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

