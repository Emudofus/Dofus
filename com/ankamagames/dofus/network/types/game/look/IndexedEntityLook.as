package com.ankamagames.dofus.network.types.game.look
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IndexedEntityLook extends Object implements INetworkType
    {
        public var look:EntityLook;
        public var index:uint = 0;
        public static const protocolId:uint = 405;

        public function IndexedEntityLook()
        {
            this.look = new EntityLook();
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 405;
        }// end function

        public function initIndexedEntityLook(param1:EntityLook = null, param2:uint = 0) : IndexedEntityLook
        {
            this.look = param1;
            this.index = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.look = new EntityLook();
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_IndexedEntityLook(param1);
            return;
        }// end function

        public function serializeAs_IndexedEntityLook(param1:IDataOutput) : void
        {
            this.look.serializeAs_EntityLook(param1);
            if (this.index < 0)
            {
                throw new Error("Forbidden value (" + this.index + ") on element index.");
            }
            param1.writeByte(this.index);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IndexedEntityLook(param1);
            return;
        }// end function

        public function deserializeAs_IndexedEntityLook(param1:IDataInput) : void
        {
            this.look = new EntityLook();
            this.look.deserialize(param1);
            this.index = param1.readByte();
            if (this.index < 0)
            {
                throw new Error("Forbidden value (" + this.index + ") on element of IndexedEntityLook.index.");
            }
            return;
        }// end function

    }
}
