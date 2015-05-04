package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StatedElement extends Object implements INetworkType
   {
      
      public function StatedElement()
      {
         super();
      }
      
      public static const protocolId:uint = 108;
      
      public var elementId:uint = 0;
      
      public var elementCellId:uint = 0;
      
      public var elementState:uint = 0;
      
      public function getTypeId() : uint
      {
         return 108;
      }
      
      public function initStatedElement(param1:uint = 0, param2:uint = 0, param3:uint = 0) : StatedElement
      {
         this.elementId = param1;
         this.elementCellId = param2;
         this.elementState = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.elementId = 0;
         this.elementCellId = 0;
         this.elementState = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_StatedElement(param1);
      }
      
      public function serializeAs_StatedElement(param1:ICustomDataOutput) : void
      {
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         else
         {
            param1.writeInt(this.elementId);
            if(this.elementCellId < 0 || this.elementCellId > 559)
            {
               throw new Error("Forbidden value (" + this.elementCellId + ") on element elementCellId.");
            }
            else
            {
               param1.writeVarShort(this.elementCellId);
               if(this.elementState < 0)
               {
                  throw new Error("Forbidden value (" + this.elementState + ") on element elementState.");
               }
               else
               {
                  param1.writeVarInt(this.elementState);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StatedElement(param1);
      }
      
      public function deserializeAs_StatedElement(param1:ICustomDataInput) : void
      {
         this.elementId = param1.readInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of StatedElement.elementId.");
         }
         else
         {
            this.elementCellId = param1.readVarUhShort();
            if(this.elementCellId < 0 || this.elementCellId > 559)
            {
               throw new Error("Forbidden value (" + this.elementCellId + ") on element of StatedElement.elementCellId.");
            }
            else
            {
               this.elementState = param1.readVarUhInt();
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
