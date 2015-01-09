package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightAIInformations extends GameFightFighterInformations implements INetworkType 
    {

        public static const protocolId:uint = 151;


        override public function getTypeId():uint
        {
            return (151);
        }

        public function initGameFightAIInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, previousPositions:Vector.<uint>=null):GameFightAIInformations
        {
            super.initGameFightFighterInformations(contextualId, look, disposition, teamId, wave, alive, stats, previousPositions);
            return (this);
        }

        override public function reset():void
        {
            super.reset();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightAIInformations(output);
        }

        public function serializeAs_GameFightAIInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightFighterInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightAIInformations(input);
        }

        public function deserializeAs_GameFightAIInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

