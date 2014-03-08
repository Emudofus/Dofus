package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismsListRegisterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismsListRegisterMessage() {
         super();
      }
      
      public static const protocolId:uint = 6441;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var listen:uint = 0;
      
      override public function getMessageId() : uint {
         return 6441;
      }
      
      public function initPrismsListRegisterMessage(listen:uint=0) : PrismsListRegisterMessage {
         this.listen = listen;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.listen = 0;
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
         this.serializeAs_PrismsListRegisterMessage(output);
      }
      
      public function serializeAs_PrismsListRegisterMessage(output:IDataOutput) : void {
         output.writeByte(this.listen);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismsListRegisterMessage(input);
      }
      
      public function deserializeAs_PrismsListRegisterMessage(input:IDataInput) : void {
         this.listen = input.readByte();
         if(this.listen < 0)
         {
            throw new Error("Forbidden value (" + this.listen + ") on element of PrismsListRegisterMessage.listen.");
         }
         else
         {
            return;
         }
      }
   }
}
