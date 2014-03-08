package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NumericWhoIsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NumericWhoIsMessage() {
         super();
      }
      
      public static const protocolId:uint = 6297;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playerId:uint = 0;
      
      public var accountId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6297;
      }
      
      public function initNumericWhoIsMessage(playerId:uint=0, accountId:uint=0) : NumericWhoIsMessage {
         this.playerId = playerId;
         this.accountId = accountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerId = 0;
         this.accountId = 0;
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
         this.serializeAs_NumericWhoIsMessage(output);
      }
      
      public function serializeAs_NumericWhoIsMessage(output:IDataOutput) : void {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            if(this.accountId < 0)
            {
               throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
            }
            else
            {
               output.writeInt(this.accountId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NumericWhoIsMessage(input);
      }
      
      public function deserializeAs_NumericWhoIsMessage(input:IDataInput) : void {
         this.playerId = input.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of NumericWhoIsMessage.playerId.");
         }
         else
         {
            this.accountId = input.readInt();
            if(this.accountId < 0)
            {
               throw new Error("Forbidden value (" + this.accountId + ") on element of NumericWhoIsMessage.accountId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
