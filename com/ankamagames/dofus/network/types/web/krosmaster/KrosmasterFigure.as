package com.ankamagames.dofus.network.types.web.krosmaster
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class KrosmasterFigure extends Object implements INetworkType
    {
        public var uid:String = "";
        public var figure:uint = 0;
        public var pedestal:uint = 0;
        public var bound:Boolean = false;
        public static const protocolId:uint = 397;

        public function KrosmasterFigure()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 397;
        }// end function

        public function initKrosmasterFigure(param1:String = "", param2:uint = 0, param3:uint = 0, param4:Boolean = false) : KrosmasterFigure
        {
            this.uid = param1;
            this.figure = param2;
            this.pedestal = param3;
            this.bound = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.uid = "";
            this.figure = 0;
            this.pedestal = 0;
            this.bound = false;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_KrosmasterFigure(param1);
            return;
        }// end function

        public function serializeAs_KrosmasterFigure(param1:IDataOutput) : void
        {
            param1.writeUTF(this.uid);
            if (this.figure < 0)
            {
                throw new Error("Forbidden value (" + this.figure + ") on element figure.");
            }
            param1.writeShort(this.figure);
            if (this.pedestal < 0)
            {
                throw new Error("Forbidden value (" + this.pedestal + ") on element pedestal.");
            }
            param1.writeShort(this.pedestal);
            param1.writeBoolean(this.bound);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_KrosmasterFigure(param1);
            return;
        }// end function

        public function deserializeAs_KrosmasterFigure(param1:IDataInput) : void
        {
            this.uid = param1.readUTF();
            this.figure = param1.readShort();
            if (this.figure < 0)
            {
                throw new Error("Forbidden value (" + this.figure + ") on element of KrosmasterFigure.figure.");
            }
            this.pedestal = param1.readShort();
            if (this.pedestal < 0)
            {
                throw new Error("Forbidden value (" + this.pedestal + ") on element of KrosmasterFigure.pedestal.");
            }
            this.bound = param1.readBoolean();
            return;
        }// end function

    }
}
