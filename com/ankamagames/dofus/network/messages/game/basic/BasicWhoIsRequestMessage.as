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
      
      public function initBasicWhoIsRequestMessage(param1:Boolean=false, param2:String="") : BasicWhoIsRequestMessage {
         this.verbose = param1;
         this.search = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.verbose = false;
         this.search = "";
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_BasicWhoIsRequestMessage(param1);
      }
      
      public function serializeAs_BasicWhoIsRequestMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.verbose);
         param1.writeUTF(this.search);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicWhoIsRequestMessage(param1);
      }
      
      public function deserializeAs_BasicWhoIsRequestMessage(param1:IDataInput) : void {
         this.verbose = param1.readBoolean();
         this.search = param1.readUTF();
      }
   }
}
