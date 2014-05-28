package com.ankamagames.dofus.network.messages.game.script
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class URLOpenMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function URLOpenMessage() {
         super();
      }
      
      public static const protocolId:uint = 6266;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var urlId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6266;
      }
      
      public function initURLOpenMessage(urlId:uint = 0) : URLOpenMessage {
         this.urlId = urlId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.urlId = 0;
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
         this.serializeAs_URLOpenMessage(output);
      }
      
      public function serializeAs_URLOpenMessage(output:IDataOutput) : void {
         if(this.urlId < 0)
         {
            throw new Error("Forbidden value (" + this.urlId + ") on element urlId.");
         }
         else
         {
            output.writeInt(this.urlId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_URLOpenMessage(input);
      }
      
      public function deserializeAs_URLOpenMessage(input:IDataInput) : void {
         this.urlId = input.readInt();
         if(this.urlId < 0)
         {
            throw new Error("Forbidden value (" + this.urlId + ") on element of URLOpenMessage.urlId.");
         }
         else
         {
            return;
         }
      }
   }
}
