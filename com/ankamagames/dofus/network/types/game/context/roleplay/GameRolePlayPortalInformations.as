package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.PortalInformation;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    public class GameRolePlayPortalInformations extends GameRolePlayActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 467;

        public var portal:PortalInformation;

        public function GameRolePlayPortalInformations()
        {
            this.portal = new PortalInformation();
            super();
        }

        override public function getTypeId():uint
        {
            return (467);
        }

        public function initGameRolePlayPortalInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, portal:PortalInformation=null):GameRolePlayPortalInformations
        {
            super.initGameRolePlayActorInformations(contextualId, look, disposition);
            this.portal = portal;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.portal = new PortalInformation();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayPortalInformations(output);
        }

        public function serializeAs_GameRolePlayPortalInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayActorInformations(output);
            output.writeShort(this.portal.getTypeId());
            this.portal.serialize(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayPortalInformations(input);
        }

        public function deserializeAs_GameRolePlayPortalInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            var _id1:uint = input.readUnsignedShort();
            this.portal = ProtocolTypeManager.getInstance(PortalInformation, _id1);
            this.portal.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

