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
      
      public function initHumanOptionEmote(param1:uint=0, param2:Number=0) : HumanOptionEmote {
         this.emoteId = param1;
         this.emoteStartTime = param2;
         return this;
      }
      
      override public function reset() : void {
         this.emoteId = 0;
         this.emoteStartTime = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HumanOptionEmote(param1);
      }
      
      public function serializeAs_HumanOptionEmote(param1:IDataOutput) : void {
         super.serializeAs_HumanOption(param1);
         if(this.emoteId < 0 || this.emoteId > 255)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         else
         {
            param1.writeByte(this.emoteId);
            param1.writeDouble(this.emoteStartTime);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HumanOptionEmote(param1);
      }
      
      public function deserializeAs_HumanOptionEmote(param1:IDataInput) : void {
         super.deserialize(param1);
         this.emoteId = param1.readUnsignedByte();
         if(this.emoteId < 0 || this.emoteId > 255)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of HumanOptionEmote.emoteId.");
         }
         else
         {
            this.emoteStartTime = param1.readDouble();
            return;
         }
      }
   }
}
