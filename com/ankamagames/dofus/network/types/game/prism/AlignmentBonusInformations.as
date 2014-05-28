package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class AlignmentBonusInformations extends Object implements INetworkType
   {
         

      public function AlignmentBonusInformations() {
         super();
      }

      public static const protocolId:uint = 135;

      public var pctbonus:uint = 0;

      public var grademult:Number = 0;

      public function getTypeId() : uint {
         return 135;
      }

      public function initAlignmentBonusInformations(pctbonus:uint=0, grademult:Number=0) : AlignmentBonusInformations {
         this.pctbonus=pctbonus;
         this.grademult=grademult;
         return this;
      }

      public function reset() : void {
         this.pctbonus=0;
         this.grademult=0;
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AlignmentBonusInformations(output);
      }

      public function serializeAs_AlignmentBonusInformations(output:IDataOutput) : void {
         if(this.pctbonus<0)
         {
            throw new Error("Forbidden value ("+this.pctbonus+") on element pctbonus.");
         }
         else
         {
            output.writeInt(this.pctbonus);
            output.writeDouble(this.grademult);
            return;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlignmentBonusInformations(input);
      }

      public function deserializeAs_AlignmentBonusInformations(input:IDataInput) : void {
         this.pctbonus=input.readInt();
         if(this.pctbonus<0)
         {
            throw new Error("Forbidden value ("+this.pctbonus+") on element of AlignmentBonusInformations.pctbonus.");
         }
         else
         {
            this.grademult=input.readDouble();
            return;
         }
      }
   }

}