package com.ankamagames.dofus.network.types.web.krosmaster
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class KrosmasterFigure extends Object implements INetworkType
   {
      
      public function KrosmasterFigure() {
         super();
      }
      
      public static const protocolId:uint = 397;
      
      public var uid:String = "";
      
      public var figure:uint = 0;
      
      public var pedestal:uint = 0;
      
      public var bound:Boolean = false;
      
      public function getTypeId() : uint {
         return 397;
      }
      
      public function initKrosmasterFigure(uid:String = "", figure:uint = 0, pedestal:uint = 0, bound:Boolean = false) : KrosmasterFigure {
         this.uid = uid;
         this.figure = figure;
         this.pedestal = pedestal;
         this.bound = bound;
         return this;
      }
      
      public function reset() : void {
         this.uid = "";
         this.figure = 0;
         this.pedestal = 0;
         this.bound = false;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_KrosmasterFigure(output);
      }
      
      public function serializeAs_KrosmasterFigure(output:IDataOutput) : void {
         output.writeUTF(this.uid);
         if(this.figure < 0)
         {
            throw new Error("Forbidden value (" + this.figure + ") on element figure.");
         }
         else
         {
            output.writeShort(this.figure);
            if(this.pedestal < 0)
            {
               throw new Error("Forbidden value (" + this.pedestal + ") on element pedestal.");
            }
            else
            {
               output.writeShort(this.pedestal);
               output.writeBoolean(this.bound);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KrosmasterFigure(input);
      }
      
      public function deserializeAs_KrosmasterFigure(input:IDataInput) : void {
         this.uid = input.readUTF();
         this.figure = input.readShort();
         if(this.figure < 0)
         {
            throw new Error("Forbidden value (" + this.figure + ") on element of KrosmasterFigure.figure.");
         }
         else
         {
            this.pedestal = input.readShort();
            if(this.pedestal < 0)
            {
               throw new Error("Forbidden value (" + this.pedestal + ") on element of KrosmasterFigure.pedestal.");
            }
            else
            {
               this.bound = input.readBoolean();
               return;
            }
         }
      }
   }
}
