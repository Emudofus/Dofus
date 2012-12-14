package com.ankamagames.dofus.network.types.game.character
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AbstractCharacterInformation extends Object implements INetworkType
    {
        public var id:uint = 0;
        public static const protocolId:uint = 400;

        public function AbstractCharacterInformation()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 400;
        }// end function

        public function initAbstractCharacterInformation(param1:uint = 0) : AbstractCharacterInformation
        {
            this.id = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AbstractCharacterInformation(param1);
            return;
        }// end function

        public function serializeAs_AbstractCharacterInformation(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AbstractCharacterInformation(param1);
            return;
        }// end function

        public function deserializeAs_AbstractCharacterInformation(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of AbstractCharacterInformation.id.");
            }
            return;
        }// end function

    }
}
