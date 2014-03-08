package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class StatedElement extends Object implements INetworkType
   {
      
      public function StatedElement() {
         super();
      }
      
      public static const protocolId:uint = 108;
      
      public var elementId:uint = 0;
      
      public var elementCellId:uint = 0;
      
      public var elementState:uint = 0;
      
      public function getTypeId() : uint {
         return 108;
      }
      
      public function initStatedElement(elementId:uint=0, elementCellId:uint=0, elementState:uint=0) : StatedElement {
         this.elementId = elementId;
         this.elementCellId = elementCellId;
         this.elementState = elementState;
         return this;
      }
      
      public function reset() : void {
         this.elementId = 0;
         this.elementCellId = 0;
         this.elementState = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_StatedElement(output);
      }
      
      public function serializeAs_StatedElement(output:IDataOutput) : void {
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         else
         {
            output.writeInt(this.elementId);
            if((this.elementCellId < 0) || (this.elementCellId > 559))
            {
               throw new Error("Forbidden value (" + this.elementCellId + ") on element elementCellId.");
            }
            else
            {
               output.writeShort(this.elementCellId);
               if(this.elementState < 0)
               {
                  throw new Error("Forbidden value (" + this.elementState + ") on element elementState.");
               }
               else
               {
                  output.writeInt(this.elementState);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StatedElement(input);
      }
      
      public function deserializeAs_StatedElement(input:IDataInput) : void {
         this.elementId = input.readInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of StatedElement.elementId.");
         }
         else
         {
            this.elementCellId = input.readShort();
            if((this.elementCellId < 0) || (this.elementCellId > 559))
            {
               throw new Error("Forbidden value (" + this.elementCellId + ") on element of StatedElement.elementCellId.");
            }
            else
            {
               this.elementState = input.readInt();
               if(this.elementState < 0)
               {
                  throw new Error("Forbidden value (" + this.elementState + ") on element of StatedElement.elementState.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
