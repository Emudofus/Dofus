package com.ankamagames.dofus.network.messages.web.krosmaster
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class KrosmasterAuthTokenMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KrosmasterAuthTokenMessage() {
         super();
      }
      
      public static const protocolId:uint = 6351;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var token:String = "";
      
      override public function getMessageId() : uint {
         return 6351;
      }
      
      public function initKrosmasterAuthTokenMessage(token:String="") : KrosmasterAuthTokenMessage {
         this.token = token;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.token = "";
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
         this.serializeAs_KrosmasterAuthTokenMessage(output);
      }
      
      public function serializeAs_KrosmasterAuthTokenMessage(output:IDataOutput) : void {
         output.writeUTF(this.token);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KrosmasterAuthTokenMessage(input);
      }
      
      public function deserializeAs_KrosmasterAuthTokenMessage(input:IDataInput) : void {
         this.token = input.readUTF();
      }
   }
}
