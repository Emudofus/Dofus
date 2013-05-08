package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismFightSwapRequestMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismFightSwapRequestMessage() {
         super();
      }

      public static const protocolId:uint = 5901;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var targetId:uint = 0;

      override public function getMessageId() : uint {
         return 5901;
      }

      public function initPrismFightSwapRequestMessage(targetId:uint=0) : PrismFightSwapRequestMessage {
         this.targetId=targetId;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.targetId=0;
         this._isInitialized=false;
      }

      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }

      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PrismFightSwapRequestMessage(output);
      }

      public function serializeAs_PrismFightSwapRequestMessage(output:IDataOutput) : void {
         if(this.targetId<0)
         {
            throw new Error("Forbidden value ("+this.targetId+") on element targetId.");
         }
         else
         {
            output.writeInt(this.targetId);
            return;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightSwapRequestMessage(input);
      }

      public function deserializeAs_PrismFightSwapRequestMessage(input:IDataInput) : void {
         this.targetId=input.readInt();
         if(this.targetId<0)
         {
            throw new Error("Forbidden value ("+this.targetId+") on element of PrismFightSwapRequestMessage.targetId.");
         }
         else
         {
            return;
         }
      }
   }

}