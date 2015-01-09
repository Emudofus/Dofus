package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.prism.PrismInformation;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    public class GameRolePlayPrismInformations extends GameRolePlayActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 161;

        public var prism:PrismInformation;

        public function GameRolePlayPrismInformations()
        {
            this.prism = new PrismInformation();
            super();
        }

        override public function getTypeId():uint
        {
            return (161);
        }

        public function initGameRolePlayPrismInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, prism:PrismInformation=null):GameRolePlayPrismInformations
        {
            super.initGameRolePlayActorInformations(contextualId, look, disposition);
            this.prism = prism;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.prism = new PrismInformation();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayPrismInformations(output);
        }

        public function serializeAs_GameRolePlayPrismInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayActorInformations(output);
            output.writeShort(this.prism.getTypeId());
            this.prism.serialize(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayPrismInformations(input);
        }

        public function deserializeAs_GameRolePlayPrismInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            var _id1:uint = input.readUnsignedShort();
            this.prism = ProtocolTypeManager.getInstance(PrismInformation, _id1);
            this.prism.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

