package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GetPartInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GetPartInfoMessage() {
         super();
      }
      
      public static const protocolId:uint = 1506;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:String = "";
      
      override public function getMessageId() : uint {
         return 1506;
      }
      
      public function initGetPartInfoMessage(id:String="") : GetPartInfoMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = "";
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
         this.serializeAs_GetPartInfoMessage(output);
      }
      
      public function serializeAs_GetPartInfoMessage(output:IDataOutput) : void {
         output.writeUTF(this.id);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GetPartInfoMessage(input);
      }
      
      public function deserializeAs_GetPartInfoMessage(input:IDataInput) : void {
         this.id = input.readUTF();
      }
   }
}
