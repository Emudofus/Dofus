package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IgnoredDeleteRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredDeleteRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5680;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var accountId:uint = 0;
      
      public var session:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5680;
      }
      
      public function initIgnoredDeleteRequestMessage(accountId:uint=0, session:Boolean=false) : IgnoredDeleteRequestMessage {
         this.accountId = accountId;
         this.session = session;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accountId = 0;
         this.session = false;
         this._isInitialized = false;
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
         this.serializeAs_IgnoredDeleteRequestMessage(output);
      }
      
      public function serializeAs_IgnoredDeleteRequestMessage(output:IDataOutput) : void {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            output.writeInt(this.accountId);
            output.writeBoolean(this.session);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IgnoredDeleteRequestMessage(input);
      }
      
      public function deserializeAs_IgnoredDeleteRequestMessage(input:IDataInput) : void {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of IgnoredDeleteRequestMessage.accountId.");
         }
         else
         {
            this.session = input.readBoolean();
            return;
         }
      }
   }
}
