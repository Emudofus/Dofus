package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    public class GameRolePlayHumanoidInformations extends GameRolePlayNamedActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 159;

        public var humanoidInfo:HumanInformations;
        public var accountId:uint = 0;

        public function GameRolePlayHumanoidInformations()
        {
            this.humanoidInfo = new HumanInformations();
            super();
        }

        override public function getTypeId():uint
        {
            return (159);
        }

        public function initGameRolePlayHumanoidInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, name:String="", humanoidInfo:HumanInformations=null, accountId:uint=0):GameRolePlayHumanoidInformations
        {
            super.initGameRolePlayNamedActorInformations(contextualId, look, disposition, name);
            this.humanoidInfo = humanoidInfo;
            this.accountId = accountId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.humanoidInfo = new HumanInformations();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayHumanoidInformations(output);
        }

        public function serializeAs_GameRolePlayHumanoidInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayNamedActorInformations(output);
            output.writeShort(this.humanoidInfo.getTypeId());
            this.humanoidInfo.serialize(output);
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayHumanoidInformations(input);
        }

        public function deserializeAs_GameRolePlayHumanoidInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            var _id1:uint = input.readUnsignedShort();
            this.humanoidInfo = ProtocolTypeManager.getInstance(HumanInformations, _id1);
            this.humanoidInfo.deserialize(input);
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of GameRolePlayHumanoidInformations.accountId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

