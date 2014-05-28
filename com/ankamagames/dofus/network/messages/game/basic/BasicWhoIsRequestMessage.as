package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicWhoIsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicWhoIsRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 181;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var verbose:Boolean = false;
      
      public var search:String = "";
      
      override public function getMessageId() : uint {
         return 181;
      }
      
      public function initBasicWhoIsRequestMessage(verbose:Boolean = false, search:String = "") : BasicWhoIsRequestMessage {
         this.verbose = verbose;
         this.search = search;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.verbose = false;
         this.search = "";
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
         this.serializeAs_BasicWhoIsRequestMessage(output);
      }
      
      public function serializeAs_BasicWhoIsRequestMessage(output:IDataOutput) : void {
         output.writeBoolean(this.verbose);
         output.writeUTF(this.search);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicWhoIsRequestMessage(input);
      }
      
      public function deserializeAs_BasicWhoIsRequestMessage(input:IDataInput) : void {
         this.verbose = input.readBoolean();
         this.search = input.readUTF();
      }
   }
}
