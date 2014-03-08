package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOptionEmote extends HumanOption implements INetworkType
   {
      
      public function HumanOptionEmote() {
         super();
      }
      
      public static const protocolId:uint = 407;
      
      public var emoteId:uint = 0;
      
      public var emoteStartTime:Number = 0;
      
      override public function getTypeId() : uint {
         return 407;
      }
      
      public function initHumanOptionEmote(emoteId:uint=0, emoteStartTime:Number=0) : HumanOptionEmote {
         this.emoteId = emoteId;
         this.emoteStartTime = emoteStartTime;
         return this;
      }
      
      override public function reset() : void {
         this.emoteId = 0;
         this.emoteStartTime = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_HumanOptionEmote(output);
      }
      
      public function serializeAs_HumanOptionEmote(output:IDataOutput) : void {
         super.serializeAs_HumanOption(output);
         if((this.emoteId < 0) || (this.emoteId > 255))
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         else
         {
            output.writeByte(this.emoteId);
            output.writeDouble(this.emoteStartTime);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HumanOptionEmote(input);
      }
      
      public function deserializeAs_HumanOptionEmote(input:IDataInput) : void {
         super.deserialize(input);
         this.emoteId = input.readUnsignedByte();
         if((this.emoteId < 0) || (this.emoteId > 255))
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of HumanOptionEmote.emoteId.");
         }
         else
         {
            this.emoteStartTime = input.readDouble();
            return;
         }
      }
   }
}
