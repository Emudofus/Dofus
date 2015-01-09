package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    public class GameContextActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 150;

        public var contextualId:int = 0;
        public var look:EntityLook;
        public var disposition:EntityDispositionInformations;

        public function GameContextActorInformations()
        {
            this.look = new EntityLook();
            this.disposition = new EntityDispositionInformations();
            super();
        }

        public function getTypeId():uint
        {
            return (150);
        }

        public function initGameContextActorInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null):GameContextActorInformations
        {
            this.contextualId = contextualId;
            this.look = look;
            this.disposition = disposition;
            return (this);
        }

        public function reset():void
        {
            this.contextualId = 0;
            this.look = new EntityLook();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameContextActorInformations(output);
        }

        public function serializeAs_GameContextActorInformations(output:ICustomDataOutput):void
        {
            output.writeInt(this.contextualId);
            this.look.serializeAs_EntityLook(output);
            output.writeShort(this.disposition.getTypeId());
            this.disposition.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameContextActorInformations(input);
        }

        public function deserializeAs_GameContextActorInformations(input:ICustomDataInput):void
        {
            this.contextualId = input.readInt();
            this.look = new EntityLook();
            this.look.deserialize(input);
            var _id3:uint = input.readUnsignedShort();
            this.disposition = ProtocolTypeManager.getInstance(EntityDispositionInformations, _id3);
            this.disposition.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context

