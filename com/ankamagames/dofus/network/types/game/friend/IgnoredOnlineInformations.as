package com.ankamagames.dofus.network.types.game.friend
{
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IgnoredOnlineInformations extends IgnoredInformations implements INetworkType
    {
        public var playerName:String = "";
        public var breed:int = 0;
        public var sex:Boolean = false;
        public static const protocolId:uint = 105;

        public function IgnoredOnlineInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 105;
        }// end function

        public function initIgnoredOnlineInformations(param1:uint = 0, param2:String = "", param3:String = "", param4:int = 0, param5:Boolean = false) : IgnoredOnlineInformations
        {
            super.initIgnoredInformations(param1, param2);
            this.playerName = param3;
            this.breed = param4;
            this.sex = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.playerName = "";
            this.breed = 0;
            this.sex = false;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_IgnoredOnlineInformations(param1);
            return;
        }// end function

        public function serializeAs_IgnoredOnlineInformations(param1:IDataOutput) : void
        {
            super.serializeAs_IgnoredInformations(param1);
            param1.writeUTF(this.playerName);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IgnoredOnlineInformations(param1);
            return;
        }// end function

        public function deserializeAs_IgnoredOnlineInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.playerName = param1.readUTF();
            this.breed = param1.readByte();
            if (this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Steamer)
            {
                throw new Error("Forbidden value (" + this.breed + ") on element of IgnoredOnlineInformations.breed.");
            }
            this.sex = param1.readBoolean();
            return;
        }// end function

    }
}
