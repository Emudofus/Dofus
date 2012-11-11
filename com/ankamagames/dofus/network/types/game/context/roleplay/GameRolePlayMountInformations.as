package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayMountInformations extends GameRolePlayNamedActorInformations implements INetworkType
    {
        public var ownerName:String = "";
        public var level:uint = 0;
        public static const protocolId:uint = 180;

        public function GameRolePlayMountInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 180;
        }// end function

        public function initGameRolePlayMountInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:String = "", param6:uint = 0) : GameRolePlayMountInformations
        {
            super.initGameRolePlayNamedActorInformations(param1, param2, param3, param4);
            this.ownerName = param5;
            this.level = param6;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.ownerName = "";
            this.level = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayMountInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayMountInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayNamedActorInformations(param1);
            param1.writeUTF(this.ownerName);
            if (this.level < 0 || this.level > 255)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeByte(this.level);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayMountInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayMountInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.ownerName = param1.readUTF();
            this.level = param1.readUnsignedByte();
            if (this.level < 0 || this.level > 255)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of GameRolePlayMountInformations.level.");
            }
            return;
        }// end function

    }
}
