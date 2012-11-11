package com.ankamagames.dofus.network.types.game.interactive
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StatedElement extends Object implements INetworkType
    {
        public var elementId:uint = 0;
        public var elementCellId:uint = 0;
        public var elementState:uint = 0;
        public static const protocolId:uint = 108;

        public function StatedElement()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 108;
        }// end function

        public function initStatedElement(param1:uint = 0, param2:uint = 0, param3:uint = 0) : StatedElement
        {
            this.elementId = param1;
            this.elementCellId = param2;
            this.elementState = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.elementId = 0;
            this.elementCellId = 0;
            this.elementState = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_StatedElement(param1);
            return;
        }// end function

        public function serializeAs_StatedElement(param1:IDataOutput) : void
        {
            if (this.elementId < 0)
            {
                throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
            }
            param1.writeInt(this.elementId);
            if (this.elementCellId < 0 || this.elementCellId > 559)
            {
                throw new Error("Forbidden value (" + this.elementCellId + ") on element elementCellId.");
            }
            param1.writeShort(this.elementCellId);
            if (this.elementState < 0)
            {
                throw new Error("Forbidden value (" + this.elementState + ") on element elementState.");
            }
            param1.writeInt(this.elementState);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StatedElement(param1);
            return;
        }// end function

        public function deserializeAs_StatedElement(param1:IDataInput) : void
        {
            this.elementId = param1.readInt();
            if (this.elementId < 0)
            {
                throw new Error("Forbidden value (" + this.elementId + ") on element of StatedElement.elementId.");
            }
            this.elementCellId = param1.readShort();
            if (this.elementCellId < 0 || this.elementCellId > 559)
            {
                throw new Error("Forbidden value (" + this.elementCellId + ") on element of StatedElement.elementCellId.");
            }
            this.elementState = param1.readInt();
            if (this.elementState < 0)
            {
                throw new Error("Forbidden value (" + this.elementState + ") on element of StatedElement.elementState.");
            }
            return;
        }// end function

    }
}
